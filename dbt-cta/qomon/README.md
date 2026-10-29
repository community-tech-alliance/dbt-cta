# Qomon

The dbt models in this project deliver the following deduplicated tables from the Qomon Raw Data Feed:

- action_facts
- actions
- addresses
- contacts
- custom_fields
- fact_contacts
- facts
- formdata
- forms
- profiles
- refvalues
- users

Plus `canvass_contacts`, a flat table with one row per contact who has at least one completed field interaction.

The Airflow DAG (`airflow-dags/cta-dags/gcs_syncs/qomon`) appends every feed file to a `_raw_{table}` table, with every column as STRING plus `_cta_loaded_at` and `_source_file`. For more info on the feed itself, check out Qomon's "Qomon Raw Data Feed" integration reference.

## How the base models work

`{table}_ab1` casts the documented columns to their source types with `select * replace (...)`, so any column Qomon adds to the feed later still passes through as STRING.

Timestamps in the files don't match Qomon's docs (which say UTC, e.g. `2026-08-26 09:21:23.456+00`). They're serialized like `2026-10-09 14:23:11.123456 +0200 CEST`, with a zone abbreviation BigQuery can't parse, so they're parsed with the abbreviation stripped (the numeric offset carries the zone). `contacts.birthdate` is stored as local midnight, so it's typed as a DATE from its date part rather than converted to UTC, which would shift birthdays back a day.

It also adds:

- `_extracted_at`: the extraction timestamp from the file name (`<table>_<YYYYMMDD>T<HHMMSS>Z.csv`)
- `_feed_prefix`: the folder the file came from, which is one per Qomon group (e.g. `MA`). Use it to split tables like `action_facts` that have no `group_id`.

`{table}_ab2` deduplicates. Rows are ordered by `_extracted_at` rather than load time, so files loaded out of order still resolve correctly.

- **Incremental tables** (`contacts`, `addresses`, `profiles`, `formdata`, `custom_fields`, `facts`, `actions`): the row from the latest extract wins per `id`. Soft-deleted rows are kept with `deleted_at` set, so filter on `deleted_at is null` for current data.
- **Snapshot tables** (`forms`, `refvalues`, `users`): only rows in the latest snapshot for each feed are kept, then one row per `id`, since a user or form can be shared across groups.
- **Link tables** (`fact_contacts`, `action_facts`): these have no `deleted_at`, and Qomon re-sends all of a contact's (or fact's) links together. Only rows from the latest file containing each `contact_id` (or `fact_id`) are kept, so removed links drop out.

`{table}_base` tables are rebuilt in full on every run.

## canvass_contacts

Ported from the `canvass_flat` query Qomon shared on 10/14/2026. One row per contact with at least one `done` interaction, across all Qomon groups (use `group_id` to split by group/state). Includes:

- IDs: `qomon_contact_id`, `external_id` (for AFL-CIO this is the Catalist DWID)
- Contact details, address and `do_not_contact`
- `support_level`, `consent` and `presence`: latest answer to the STATUS, CONSENT and presence questions
- `canvass_count` and the latest canvass's action and canvasser
- `custom_fields`: `array<struct<field, value>>` with the latest value of every custom field (for AFL-CIO this includes "AFL-CIO Member ID" (COPE ID) and "Van ID")
- `survey_answers`: `array<struct<question, answer, answered_at>>` with the latest answer to every survey question. Checkbox answers are joined with `; `.

Differences from Qomon's flat file: custom fields and survey answers are arrays instead of one column per question (the questions differ by group and change when admins edit them), `canvass_count` counts distinct interactions, and the latest custom field value is chosen by date instead of `max()`.

To pull a single custom field into a column:

```sql
select
    qomon_contact_id,
    (select value from unnest(custom_fields) where field = 'Van ID') as van_id
from canvass_contacts
```

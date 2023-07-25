# ADP Worker Management

CTA's custom Airbyte connector delivers all data for this sync into BigQuery in a single JSON payload, `workers`. This includes some fields that are arrays, for which any individual worker might potentially have multiple rows (eg, email addresses). These are unnested in all of the models besides `workers`.

=======

## Raw data

Airbyte delivers all of the data (using CTA's [custom Airbyte source connector](https://github.com/community-tech-alliance/airbyte-source-adp-worker-management)) in a single table, `_airbyte_raw_workers`, in whose field `_airbyte_data` are contained all of the fields in the sync. Most of these are captured in the table `workers`, and some, such as contact info fields (personal_emails, work_emails) are array fields that are unnested in separate models. This is necessary because a single worker (associateOID in `workers`) might have more than one row for those streams.

In addition, the array field `workerAssignments` has two array fields that are further unnested: `assignedOrganizationalUnits` and `homeOrganizationalUnits`.

## Tests

This sync includes source tests, which look a lot like the tests we encode in schema yml files but are actually just included in `sources.yml`. I don't know why I chose to add them here, since in theory they are duplicative of the tests yet to come. I must have been in some type of mood. But if a test is good enough to run once, it's good enough to run twice, I guess?

All tables are updated using the Full Refresh - Overwrite sync mode in Airbyte, and all CTA base models use the full refresh strategy (`1_cta_full_refresh`). As such, the unique primary key for each table is the `_airbyte_*_hashid` generated in the `*_ab3` step in 0_ctes, and the tests are all configured to check for non-null-ness and uniqueness for these `hashid` fields.
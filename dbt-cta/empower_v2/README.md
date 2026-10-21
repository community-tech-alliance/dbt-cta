# empower_v2

dbt models for data synced from the [Empower Export API v2](https://github.com/getempower/api-documentation/blob/main/README.md) by a low-code Airbyte connector. The older `empower` folder models the v1 export API and is still used by syncs that haven't moved to v2.

## Streams

`regions`, `tags`, `ctas`, `ctas_prompts`, `ctas_prompts_answers`, `profiles`, `profiles_tags`, `ctas_results`, `ctas_results_answers`, `outreach_entries`. All are full refresh.

## How the models work

Airbyte lands each stream as a raw table, `airbyte_internal.<CTA_DATASET_ID>_raw__stream_<stream>`, with the record as JSON in `_airbyte_data`.

- `0_ctes/<stream>_ab1`: extracts each declared column from the JSON, casts it, and adds a `_airbyte_<stream>_hashid` of the record.
- `0_ctes/<stream>_ab2`: keeps one row per hashid.
- `1_cta_full_refresh/<stream>_base`: the typed table in `CTA_DATASET_ID`.
- `2_cta_delivery/<stream>`: `select *` from the base table, for Analytics Hub delivery.

Column names keep Empower's camelCase. A column the API doesn't send for an org (it's blank, or Empower omits it) comes through as all NULL.

## Types

The connector syncs every value as a string. Types are set in `ab1` with `safe_cast`, so a value that doesn't fit becomes NULL instead of failing the run:

- `*Mts` columns (epoch milliseconds), `ordering` and `initialPromptResponse`: `int64`
- `is*`, `should*`, `uses*` and `can*` flags: `bool`
- everything else, including IDs and JSON-valued columns: `string`. `ctas_prompts.dependsOnInitialDispositionResponse` stays `string` too, because the API doc doesn't make clear whether it's a flag or a response code.

## Tests

Primary keys get `unique` and `not_null` at `warn` severity. `profiles_tags` and `ctas_results_answers` have no primary key in the API. Their tests check a guessed composite key, `(eid, tagId)` and `(resultId, answerId)`, also at `warn`.

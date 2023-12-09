# Facebook Pages (BQ V2 using raw data in `airbyte_internal`)

When running dbt on the raw tables created from the BQ V2 destination connector, `cta_dataset_id` must be passed in as a dbt var (in addition to exporting to the env_var CTA_DATASET_ID). This is because profiles.yml can only read env_vars and the SQL model templates can only read vars. :|

## Usage

```shell

dbt run --target cta --select tag:cta --vars '{"cta_dataset_id": "raza_facebook_pages"}'
```


# Running dbt locally for point-to-point syncs

```shell

# drop into the point_to_point/ directory
cd point_to_point

# export your env variables
export CTA_PROJECT_ID='my_dev_project' 
export CTA_P2P_SOURCE_RAW_DATASET_ID=p2p_demo_raw
export CTA_P2P_SOURCE_BASE_DATASET_ID=p2p_demo_base
export CTA_P2P_DESTINATION_DATASET_ID=p2p_demo_mapped
export SYNC_NAME=google_sheets_van_upsert_contacts

# normalize raw data to base tables
pipenv run dbt run --target cta_p2p_source_base --select tag:normalization

# run tests on base tables
pipenv run dbt test --target cta_p2p_source_base --select tag:normalization

# create mapped tables for use in rETL
pipenv run dbt run --target cta_p2p_destination --select tag:mapping

```
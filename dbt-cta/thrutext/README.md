# Running Locally

Run these commands from within the `dbt-cta` folder _within_ this repo (sorry, it's confusing).

```shell
cd dbt-cta

export CTA_PROJECT_ID=some_project_id
export CTA_DATASET_ID=partner_a_getthru_thrutext
export PARTNER_PROJECT_ID=another_project_id
export PARTNER_DATASET_ID=thrutext
export SYNC_NAME=thrutext

# to run a single model, replace tag:cta with the name of the file
pipenv run dbt run --target cta --select daily_messages_base


# run dbt tests for a single table
pipenv run dbt test --target cta --select daily_messages_base
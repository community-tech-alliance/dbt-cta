# generate_dbt.py

This script generates dbt models for tables in a given dataset.

Currently it assumes that all tables are already normalized using Airbyte's BigQuery Destination V2, which delivers normalized tables to the dataset in the CTA project that will also contain `_base` tables created by the dbt.

## Usage

This is written to be executed from within this folder.

```shell
cd utils/generate_dbt
pipenv run python generate_dbt.py
```

You will be asked to provide a few inputs. First, enter the name of the sync (e.g., `facebook_pages`), or just hit ENTER to use the name `test`.

```
Enter sync name (default: test): 
```

Next, enter the project ID and dataset ID where the Airbyte connection is delivering normalized tables (which is also where the dbt will materialize `_base` tables, a.k.a. the env_var `CTA_DATASET_ID`).

```
Enter project ID:
Enter dataset ID (default: dbt_gen_science):
```

Finally, input a number (1, 2, or 3) to indicate whether you want to generate `_base` models using full-refresh or incremental sync strategies - or both, if your sync has a mix of both and you need to pick and choose different models for different tables.

```
Which base models do you need generated? (1=full_refresh, 2=incremental, 3 or skip to generate both):
```

The script will go _brrrr_ and you will see new files being created - everything you need in order to start running some dbt on your BQ V2-normalized data. Computers!
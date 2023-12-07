
# generate_dbt.py

This script generates dbt models for tables in a given dataset.

Currently it assumes that all tables are already normalized, and that they should all be updated using a full refresh overwrite strategy. (TODO: implement incremental refresh as well)

## Usage

This is written to be executed from within this folder.

```shell
cd utils/generate_dbt
pipenv run python generate_dbt.py
```
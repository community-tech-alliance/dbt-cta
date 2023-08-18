# dbt-cta

## Welcome!

Whatever whims of fate conspired to bring you here, we at Community Tech Alliance welcome you to this humble repository, in which are contained the `dbt` models we use to transform and deliver data to our partner organizations.

This is an open-source project, and we invite you to contribute! Please check out our [contribution guidelines](CONTRIBUTING.md) for details on how to report bugs, submit feature requests, and contribute new code to this repository.

If you have questions, concerns, or feedback about this project, the best way to let us know is by submitting an issue (please refer to the aforementioned [guidelines](CONTRIBUTING.md) for doing so). You can also reach us by [email](mailto:help@techallies.org). 

We hope you enjoy your stay!

## How CTA runs dbt

CTA runs dbt in Composer, which is Airflow managed by Google Cloud Platform. It's just Airflow, but Google calls it Composer. Why? Because reasons.

We use a combination of this repository (which is public - after all, you seem to be here) and a private repository that configures the variables passed to [profiles.yml](profiles.yml).

### Preferred: dbt Operators

The most commonly used package for running dbt in Airflow using Airflow operators is [airflow-dbt](https://github.com/gocardless/airflow-dbt). The latest release as of this writing is v0.4.0, which does not support passing variables into sources.yml, which is something we do. As a (hopefully temporary) workaround, CTA uses a PyPi package of our own creation, [airflow-dbt-cta](https://pypi.org/project/airflow-dbt-cta/), which implements the functionality we crave.

### Hacky workaround: BashOperators

You can run any bash commands you want within Airflow, so this approach does technically work. TKTKTK some details. We don't recommend it, though. It's messy and not 100% reliable.

## How YOU can run dbt

You can run dbt in as many ways as you can run, you know, any command-line tool.

- Airflow, or any other orchestration tool
- Run it in a container (eg using Google Workflows, or your platform of choice for running arbitrary code in the cloud)
- Run it locally

## Initializing dbt projects from Airbyte syncs

Most of our dbt originates from the default normalization that Airbyte runs for data synced from each vendor. Airbyte has instructions for how to export this dbt on their [website](https://docs.airbyte.com/operator-guides/transformation-and-normalization/transformations-with-dbt#exporting-dbt-normalization-project-outside-airbyte).

We also have some tools and techniques (outlined below) that we use internally to make our lives easier (but you can, too!).

## Formatting
We currently use SQLFluff to lint and format out dbt models. If you would like to run the linter, you can use the 
`utils/cta_dbt_helper.sh` script! Just run `./utils/cta_dbt_helper.sh` and choose the `Run SQL Fluff to lint dbt files` option. It will ask you for the vendor (folder name) you would like to lint and if you want to run the SQLFluff fix option. 

If this is your first time running the helper script, make sure to run the `Initialize Python virtual env` option first to install all the needed dependencies. 

## Cleanup Scripts

### Implementing dbt functions

Do *you* want to automatically replace all static references to tables as generated by Airbyte? I bet you do.

To replace ctes:

```shell
for file in $(ls mobilize/models/0_ctes/); do
	sed -i .bak -e 's/\`\prod.*\(_airbyte_raw_[^ ]*\)/{{ source("'"cta"'", "'"\1"'" \) }}/g' mobilize/models/0_ctes/$file;
done
```

To replace base tables:

```shell
for file in $(ls mobilize/models/1_cta_base_tables/); do
	sed -i .bak -e 's/\`\prod.*\(_airbyte_raw_[^ ]*\)/{{ source("'"cta"'", "'"\1"'" \) }}/g' mobilize/models/1_cta_base_tables/$file;
done
```

To build out materialized views, if applicable, run this sed replacement once you have the fields copied in from the base table:
```shell
sed -i .bak -e 's/    \([a-z0-9_]*\),/    ,max(\1) as \1/g' FILE.sql
```

Once you're sure things look good, delete the backups:

```shell
rm **/**/*.sql.bak
```
### Renaming files

For ctes:

```shell
for file in $(ls mobilize/models/0_ctes/); do
    newFile="${file#*airbyte_org_[0-9][a-z]*_}"
    mv mobilize/models/0_ctes/"$file" mobilize/models/0_ctes/"$newFile"
done
```

And base tables:
```shell
for file in $(ls mobilize/models/1_cta_base_tables/); do
    newFile="${file#*org_[0-9][a-z]*_}"
    mv mobilize/models/1_cta_base_tables/"$file" mobilize/models/1_cta_base_tables/"$newFile"
done
```
### Generating Sources

The sources.yml provides context to the dynamic lookups in the models. The file looks like this:
```
version: 2
sources:
- name: cta
  database: "{{ env_var('CTA_PROJECT_ID') }}"
  schema: "{{ env_var('CTA_DATASET_ID') }}"
  tables:
    - name: _airbyte_raw_affiliations
    - name: affiliatons
    ...
```

To generate the base set of sources (raw tables and base tables for `cta`) from the tables
loaded into BigQuery from the initial sync:

```shell
bq ls \
--project_id=prod8b61f23e \
dataset_id \
| jq '[{name: .[].tableReference.tableId}]_base' \
| yq -P
- name: event_co_hosts
- name: event_tags
...
```

From there, you can just copy and paste that into the sources.yml file.

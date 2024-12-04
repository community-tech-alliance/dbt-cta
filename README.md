# dbt-cta

## Welcome!

Whatever whims of fate conspired to bring you here, we at Community Tech Alliance welcome you to this humble repository, in which are contained the `dbt` models we use to transform and deliver data to our partner organizations.

This is an open-source project, and we invite you to contribute! Please check out our [contribution guidelines](CONTRIBUTING.md) for details on how to report bugs, submit feature requests, and contribute new code to this repository.

If you have questions, concerns, or feedback about this project, the best way to let us know is by submitting an issue (please refer to the aforementioned [guidelines](CONTRIBUTING.md) for doing so). You can also reach us by [email](mailto:help@techallies.org). 

We hope you enjoy your stay!

### ATTENTION: This repo is set up for secrets scanning using pre-commit and TruffleHog. pre-commit (as the name implies) will run before git commit commands. For the purposes of secrets detection, we want to catch them before they're committed and pushed to GitHub, as opposed to having a GitHub Action that catches them after they've already been exposed. TruffleHog is an open-source secrets detection tool that we can leverage for local scanning for this exact purpose. Follow the instructions below after cloning the repo to your local machine. 

```
brew install pre-commit trufflehog  # This only needs to be done once on your machine
pre-commit install                  # Note that this needs to be run for each repo that has a pre-commit config
pre-commit run                      # Run once to make sure the pre-commit works
```

All done! Be on the lookout for any secrets that were detected during the pre-commit step from your local machine.

Note: if you're using GitHub Desktop, this should still work but you'll need to configure GitHub Desktop to use your default shell application (such as Terminal, iTerm 2, etc.). You can do that by going to `GitHub Desktop -> Settings -> Integrations -> Shell` then restart GitHub Desktop afterwards.

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

If the pre-commit hook is not letting you commit something and you want to override it. You can ignore the sqlfluff lint hook by running your `git commit` with the `--no-verify` flag.

## Containerizing dbt-cta
There is a _Dockerfile_ at the root of this repo that can be used to create a dbt-cta image. This image can be used to run dbt as a container, which makes it possible to run dbt in either Docker or Kubernetes. There is a Makefile that can be used to simplify the process of building and running the dbt-cta image locally for testing!

### Makefile Requirements
- A Google Cloud Platform(GCP) Project with Cloud Build and [Artifact Registry](https://cloud.google.com/artifact-registry/docs/docker) enabled. The Makefile works by using GCP Cloud Build to build and deploy the image to Google's Artifact Registry. 
- Setup Docker Authentication to Artifact Registry
    - [Documentation from GCP](https://cloud.google.com/artifact-registry/docs/docker/authentication)
    - I've had no issues using the [gcloud cli credential helper](https://cloud.google.com/artifact-registry/docs/docker/authentication#gcloud-helper)
- If you are running the dbt locally, you must have Docker up and running on your computer.

### Using the Makefile
Below are the commands you can run with the Makefile. To view a summary of these on your CLI, run `make help`

- `make help` - prints out a help menu with all the available commands
- `make build PROJECT_ID=myprojectid` - Starts a Cloud Build run to build and deploy an image. It uses the current Git HEAD hash as the tag.
- `make tag PROJECT_ID=myprojectid` - Adds the _latest_ tag to Artifact tagged with the current Git Hash.
    - Optionally, you can specify a different tag to add and a specific Git Hash to apply the tag to.
    Example: `make tag PROJECT_ID=myprojectid TAG=0.0.1 GIT_HASH=somecommithash`
- `make run PROJECT_ID=myprojectid` - pulls the image with the current git hash tag and runs dbt locally on Docker. 
    - NOTE: You must have a `.env` file at the root of this repo for this to work. The `.env` file should have the following Variables set.
    ```shell
    CTA_PROJECT_ID=source_project_id
    CTA_DATASET_ID=source_dataset_id
    PARTNER_PROJECT_ID=destination_project_id
    PARTNER_DATASET_ID=destination_dataset_id
    SYNC_NAME=sync_name  # Example: actblue
    DBT_TARGET="cta"  # Can be any available target in profiles.yml
    DBT_SELECT="tag:cta"  # Specify what models should be selected, can specify tags, model names, folders, etc..
    ```
- `make helper` - Will kickoff the `utils/cta_dbt_helper.sh` script.


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

## IMPORTANT note about tables generated from nested fields

In some cases, Airbyte's default normalization creates new tables to flatten out nested fields. See models in Quickbooks for an example of this on steroids.

If your sync has models that flatten out nested fields into new tables, make sure to update references in the models in `0_ctes` by adding the `_base` suffix to references (e.g., use `{{ ref('payments_base') }}` instead of `{{ ref('payments_base') }}`).

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

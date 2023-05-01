# CTA dbt Utils

## cta_dbt_helper.sh

### Why would I run this?

This script streamlines the process of initializing dbt for Airbyte syncs that have not already been modeled elsewhere in this repository. It's a moderately annoying process, but this script makes it, you know, a bit less so.

Specifically, it makes the dbt files:

1) conform to CTA's naming conventions (useful if you are CTA or wish to [contribute to this repository](https://github.com/community-tech-alliance/dbt-cta/blob/main/CONTRIBUTING.md)), and

2) emotionally easier to work with.

### What does cta_dbt_helper.sh do?

It moves around some folders, renames some files, and does some string replacements in the dbt project that Airbyte generates when running a sync using default normalization. (See [Airbyte's documentation](https://docs.airbyte.com/operator-guides/transformation-and-normalization/transformations-with-dbt/) for more context.)

### Running cta_dbt_helper.sh

In the Terminal, navigate yourself to the root directory of our dbt project
("/dbt-cta/dbt-cta").

Then:

```
sh ../utils/cta_dbt_helper.sh
```

This will start an interactive session that will let you do various things. Here's some more info on each option

### Initialize Python virtual env
This script uses both of the `dbt_format_utils.py` and `generate_schema_yml.py` Python scripts. This option will create a virtual environment with all of the python dependencies needed by both of these Python scripts. If you run the other commands before this one, you'll run into some errors. Generally, its just a good idea to give it a run before using other options! There's no harm if dependencies haven't changed and if they have, now you have all of them!

### Copy dbt from an Airbyte Workspace (getting normalization dbt from Airbyte)
This option is really only for CTA internal use. It will pull down an internal script from our Cacher snippet repo. Save it to the following path `.cta/copy_airbyte_workspace.sh`. And finally run this script to pull down a copy of an Airbyte Workspace to the following directory `airbyte_dbt_export/<Workspace ID>/`. 

Note: For CTA users, you will need to provide your personal Cacher API Key and Token when prompted. The prompt has a link that when you navigate to it and authenticate into Cacher, it will show you your personal API Key and Token. 

Additional Note: An Airbyte Workspace ID is just the directory Airbyte creates for an Airbyte Connection sync run. You can find it by opening up the logs for the specific Airbyte sync run you want. The log filepath will have a number in it `/path/to/workspace/<ID>/0/logs.log`

##### Not CTA,but still want to get normalization dbt from Airbyte?
Airbyte has written up some good documentation on how to export dbt normalization from your Airbyte Instance - https://docs.airbyte.com/operator-guides/transformation-and-normalization/transformations-with-dbt/#exporting-dbt-normalization-project-outside-airbyte

### Format exported Airbyte dbt to CTA structure
This option will take the default `normalization` dbt from an exported Airbyte Workspace and move those into the dbt-cta repo. It will rename the directories and modify the dbt files to match what CTA expects.

### Add '_base' suffix to all models in a folder
This option will prompt the user for a directory that holds base models (`1_cta_full_refresh`, `1_cta_incremental`) and then add the `_base` suffix to all of the files in the input directory if they dont already have that suffix. It will also print out a list of updated table names that can be copied and pasted directly into your `sources.yml` file. (Automation for this step to come!)

### Generate Matviews for all the models in a folder
This option will also prompt the user for a directory that holds base models (`1_cta_full_refresh`, `1_cta_incremental`). It will then generate new dbt files in the `2_partner_matviews` that do a `select *` of all the columns excluding the Airbyte Specific columns from the base table models.

### Generate dbt Tests for a vendor dbt folder
This option will prompt a user for a vendor name and generate a starter schema.yml file for a new dbt project. For more info on this script, check out the `generate_schema_yml.py` section a bit further down!

Congratulations! Now you have a cleaned-up dbt project you can use to start hacking away. (Which is where the real fun begins - best of luck to you.)

Double check these few things before venturing too far forward:

0. Delete the Airbyte workspace files we used to initialize the dbt - we don't need it anymore. :wave:
1. Make sure the sources.yml file lands in the models folder.
2. Create a README.md file in the base (partner name) folder.
3. In the 0_ctes folder, make sure wherever the code says `source('..', '_airbyte_raw_...')` that the first string in the list is 'cta', not '{​partner_name}'.
4. Check the spacing in `sources.yml`. Make sure that `database` and `schema` are nested under `name` and aligned with `tables`.


## generate_schema_yml.py
This script generates starter schema.yml files for a new dbt project. It uses dbt's
[codegen](https://github.com/dbt-labs/dbt-codegen) package to run a series of 
`generate_model_yaml` commands, and then aggregates them all together in a single
yaml file. It queries the database to get the column names, and then uses the
`universal_tests.yml` file to generate a set of tests for each column.

This script runs at the end of `init_dbt`, but can also be run independently.

### Requirements
1. Have all the necessary environmental variables set to run dbt, including `SYNC_NAME`,
`CTA_PROJECT_ID`, and `CTA_DATASET_ID`. Make sure you can run `dbt debug --target cta`
successfully. Make sure to run `dbt deps` to install the codegen package.
 Make sure to run `dbt deps` to install the codegen package.
2. Be in the `/dbt-cta` directory
3. Run `python ./utils/generate_schema_yml.py`

### Arguments
`--sync-name`: The name of the sync you want to generate schema.yml files for.
 If not provided, the script will use the value of the `SYNC_NAME` environmental variable.

`--overwrite`: If set, the script will overwrite any existing schema.yml files
 for the provided sync. If not set, the script will skip any models that already have
 a schema.yml file.

`--merge`: If set, the script will merge any changes into existing schema.yml
 files. If this is set, the script will also set the `--overwrite` flag to True.

`--universal-tests`: A path to a "universal tests" yml file (defaults to
`../utils/universal_tests.yml`). This file should contain a list of tests, in dbt test
format, that should be configured on every column with the same name.

### Example Usage

Overwrite all schema.yml files for the sync designated by the `SYNC_NAME` environmental variable:
```bash
cd dbt-cta/dbt-cta
python ../utils/generate_schema_yml.py --overwrite
```

Merge changes into existing schema.yml files for the Mailchimp sync:
```bash
python ../utils/generate_schema_yml.py --merge --sync-name mailchimp
```

Set up schema.yml files for a new Twitter sync, and use a different universal tests file:
```bash
python ../utils/generate_schema_yml.py --sync-name twitter --universal-tests ../utils/twitter_universal_tests.yml
```

### Running in pipenv

If you find yourself using pipenv because your global python configuration is messed up and you don't know why (sure, that's a personal problem, but still), here are the commands you run to get that to work.

First, create a `.env` file in `dbt-cta/dbt-cta` with the variables necessary to run dbt commands:

```
export CTA_PROJECT_ID=(DEV CTA PROJECT)
export CTA_DATASET_ID=partner_a_empower
export PARTNER_PROJECT_ID=(DEV PARTNER PROJECT)
export PARTNER_DATASET_ID=empower
export SYNC_NAME=empower
```

Then you will need to install `pyyaml` in your pipenv:

```
pipenv install pyyaml
```

Make sure your pipenv has access to the environment variables in your .env file:

```
pipenv run source .env
```

(This throws me an error but it seems to have done the job?)

And finally you can run the script using commands as in the examples listed above:

```
pipenv run python ../utils/generate_schema_yml.py --overwrite
```

### Limitations
dbt's codegen package does not currently work on ephemeral models. The way our
directories are structured, we have an entire folder of CTEs, so this script just skips
those.

### Next Steps
 - We're using an outdated version of the codegen package to play nicely with our other
 dependencies. The latest version (`0.9.0`) woudd let us generate schema.yml files for
 a list of models, rather than parsing them one at a time.

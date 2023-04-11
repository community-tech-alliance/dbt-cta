# init_dbt.sh

## Why would I run this?

This script streamlines the process of initializing dbt for Airbyte syncs that have not already been modeled elsewhere in this repository. It's a moderately annoying process, but this script makes it, you know, a bit less so.

Specifically, it makes the dbt files:

1) conform to CTA's naming conventions (useful if you are CTA or wish to [contribute to this repository](https://github.com/community-tech-alliance/dbt-cta/blob/main/CONTRIBUTING.md)), and

2) emotionally easier to work with.

## What does init_dbt.sh do?

It moves around some folders, renames some files, and does some string replacements in the dbt project that Airbyte generates when running a sync using default normalization. (See [Airbyte's documentation](https://docs.airbyte.com/operator-guides/transformation-and-normalization/transformations-with-dbt/) for more context.)

The script assumes that you've already obtained a tarball of data from Airbyte using one of the methods described [below](#generating-the-tarball). Place the tarball in `dbt-cta/dbt-cta`. This is temporary - we will remove the file later.

## Running init_dbt.sh

In the Terminal, navigate yourself to the root directory of our dbt project
("/dbt-cta/dbt-cta") and make sure it contains the tarball of default Airbyte dbt files.

Then:

```
sh ../utils/init_dbt
```

Congratulations! Now you have a cleaned-up dbt project you can use to start hacking away. (Which is where the real fun begins - best of luck to you.)

Double check these few things before venturing too far forward:

0. Delete the tarball file we used to initialize the dbt - we don't need it anymore. :wave:
1. Make sure the sources.yml file lands in the models folder.
2. Create a README.md file in the base (partner name) folder.
3. In the 0_ctes folder, make sure wherever the code says `source('..', '_airbyte_raw_...')` that the first string in the list is 'cta', not '{​partner_name}'.
4. Check the spacing in `sources.yml`. Make sure that `database` and `schema` are nested under `name` and aligned with `tables`.

## Generating the tarball

### CTA: run some commands

If you are a CTA engineer looking for the tarball file containing your sync's auto-generated dbt, download and run the shell script contained in [this Cacher snippet](https://snippets.cacher.io/snippet/2b77280d537736f980f9).

### Not CTA, but still running Airbyte in a GCE instance:

You can use the same command - just replace the ```$(gcloud compute instance-groups managed list-instances ...)``` command with the name of the GCE instance you're using to run Airbyte.

# generate_schema_yml.py
This script generates starter schema.yml files for a new dbt project. It uses dbt's
[codegen](https://github.com/dbt-labs/dbt-codegen) package to run a series of 
`generate_model_yaml` commands, and then aggregates them all together in a single
yaml file. It queries the database to get the column names, and then uses the
`universal_tests.yml` file to generate a set of tests for each column.

This script runs at the end of `init_dbt`, but can also be run independently.

## Requirements
1. Have all the necessary environmental variables set to run dbt, including `SYNC_NAME`.
 Make sure to run `dbt deps` to install the codegen package.
2. Be in the `/dbt-cta` directory
3. Run `python ./utils/generate_schema_yml.py`

## Arguments
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

## Example Usage

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

## Limitations
dbt's codegen package does not currently work on ephemeral models. The way our
directories are structured, we have an entire folder of CTEs, so this script just skips
those.

## Next Steps
 - We're using an outdated version of the codegen package to play nicely with our other
 dependencies. The latest version (`0.9.0`) woudd let us generate schema.yml files for
 a list of models, rather than parsing them one at a time.

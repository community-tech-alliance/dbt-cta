# init_dbt.sh

## Why would I run this?

This script streamlines the process of initializing dbt for Airbyte syncs that have not already been modeled elsewhere in this repository. It's a moderately annoying process, but this script makes it, you know, a bit less so.

Specifically, it makes the dbt files:

1) conform to CTA's naming conventions (useful if you are CTA or wish to [contribute to this repository](https://github.com/community-tech-alliance/dbt-cta/blob/main/CONTRIBUTING.md)), and

2) emotionally easier to work with.

## What does init_dbt.sh do?

It moves around some folders, renames some files, and does some string replacements in the dbt project that Airbyte generates when running a sync using default normalization. (See [Airbyte's documentation](https://docs.airbyte.com/operator-guides/transformation-and-normalization/transformations-with-dbt/) for more context.)

The script assumes that you've already obtained a tarball of data from Airbyte using one of the methods described [below](#generating-the-tarball).

## Running init_dbt.sh

In the Terminal, navigate yourself to a folder that includes both init_dbt.sh and the tarball containing the default Airbyte dbt files.

Then:

```
sh init_dbt.sh
```

Congratulations! Now you have a cleaned-up dbt project you can use to start hacking away. (Which is where the real fun begins - best of luck to you.)

Double check these few things before venturing too far forward:
1. Make sure the sources.yml file lands in the models folder.
2. Create a README.md file in the base (partner name) folder.
3. In the 0_ctes folder, make sure wherever the code says `source('..', '_airbyte_raw_...')` that the first string in the list is 'cta', not '{​partner_name}'.
4. Check the spacing in `sources.yml`. Make sure that `database` and `schema` are nested under `name` and aligned with `tables`.

## Generating the tarball

### CTA: run some commands

If you are a CTA engineer looking for the tarball file containing your sync's auto-generated dbt, download and run the shell script contained in [this Cacher snippet](https://snippets.cacher.io/snippet/093ede6b991a307580d8).

### Not CTA, but still running Airbyte in a GCE instance:

You can use the same command - just replace the ```$(gcloud compute instance-groups managed list-instances ...)``` command with the name of the GCE instance you're using to run Airbyte.

# generate_schema_yml.py
This script generates starter schema.yml files for a new dbt project. It uses dbt's
[codegen](https://github.com/dbt-labs/dbt-codegen) package to run a series of 
`generate_model_yaml` commands, and then aggregates them all together in a single
yaml file.

## Requirements
1. Have all the necessary environmental variables set to run dbt, including `SYNC_NAME`.
 Make sure to run `dbt deps` to install the codegen package.
2. Be in the `/dbt-cta` directory
3. Run `python ./utils/generate_schema_yml.py`

## Limitations
dbt's codegen package does not currently work on ephemeral models. The way our
directories are structured, we have an entire folder of CTEs, so this script just skips
those.

## Next Steps
 - Ideally, this script would generate some basic tests, perhaps configured to set the
same tests on a set list of column names.
 - We're using an outdated version of the codegen package to play nicely with our other
 dependencies. The latest version (`0.9.0`) woudd let us generate schema.yml files for
 a list of models, rather than parsing them one at a time.
 - If we have existing schema.yml files, an additional run of this script could be
 configured to merge in changes, rather than overwriting them.


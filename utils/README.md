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

## Generating the tarball

### CTA: run some commands

These commands were written for CTA internal use, which assumes Airbyte is running in a Google Compute Engine instance managed by an Instance Group Manager.

```
PROJECT_ID=<CTA project id>
PROJECT_NAME=<dev|prod>
WORKSPACE_ID=<workspace ID>
export WORKSPACE_ID="$WORKSPACE_ID";
gcloud compute ssh --project=$PROJECT_ID -zone=us-central1-a $(gcloud compute instance-groups managed list-instances f-igm-airbyte-${PROJECT_NAME} \
 --zone=us-central1-a \
 --project=$PROJECT_ID \
 --filter="STATUS=running" \
 --format="csv(NAME)[no-heading]") --command "sudo tar -cv /var/lib/docker/volumes/airbyte_workspace/_data/${WORKSPACE_ID}/0/" > $WORKSPACE_ID.tar.gz
```

### What is this doing?

Basically just connecting to our remote instance (via SSH) and running this command:

```"sudo tar -cv /var/lib/docker/volumes/airbyte_workspace/_data/${WORKSPACE_ID}/0/" > $WORKSPACE_ID.tar.gz```

1) `tar` creates a tarball of the dbt files located deep inside the docker container running Airbyte, and then 

2) we save it locally to `$WORKSPACE_ID.tar.gz`.

Everything else is just a bunch of variables needed for ```gcloud compute ssh``` to connect to the instance running Airbyte.

Because CTA uses an Instance Group Manager, the instance name changes regularly - thus we need to run ```$(gcloud compute instance-groups managed list-instances ...)``` to fetch the latest.

### Not CTA, but still running Airbyte in a GCE instance:

You can use the same command - just replace the ```$(gcloud compute instance-groups managed list-instances ...)``` command with the name of the GCE instance you're using to run Airbyte.
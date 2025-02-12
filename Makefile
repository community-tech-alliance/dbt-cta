# Makefile to make building and pushing dbt-cta Docker Image consistent
.EXPORT_ALL_VARIABLES:

# ------ VARIABLES ------
ARTIFACT_NAME ?= dbt-cta
TAG ?= latest
GIT_HASH ?= $(shell git rev-parse HEAD)

# ------ HELPER FUNCTIONS -------
# Load Environment variables defined in .env file
define get_env_vars
	$(eval include .env)
	$(eval export)
endef


# ------ TARGETS ------
help:	  	## Show help for available make functions
##   
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

build:		## Start a cloud build job for dbt-cta artifact. 
#		## Required Args: PROJECT_ID
#		## Optional Args: ARTIFACT_NAME
##  
# Check if PROJECT_ID was passed in
	@[ "${PROJECT_ID}" ] || ( echo "PROJECT_ID must be passed in. Example: make target PROJECT_ID=myprojectid"; exit 1 )
# Build and deploy image
	echo "Building Artifact and Deploying to: us-central1-docker.pkg.dev/${PROJECT_ID}/${ARTIFACT_NAME}/${ARTIFACT_NAME}:${GIT_HASH}"
	gcloud builds submit --region=us-central1 --tag us-central1-docker.pkg.dev/${PROJECT_ID}/${ARTIFACT_NAME}/${ARTIFACT_NAME}:${GIT_HASH} --gcs-log-dir=gs://${PROJECT_ID}_cloudbuild/logs/
	echo "Successfully built ${ARTIFACT_NAME} with tag: ${GIT_HASH}"

tag:		## Add a tag to an existing Artifact.
#		## Defaults to adding 'latest' tag to current GIT_HASH Artifact
#		## Required Args: PROJECT_ID
#		## Optional Args: TAG, GIT_HASH
##  
# Check if PROJECT_ID was passed in
	@[ "${PROJECT_ID}" ] || ( echo "PROJECT_ID must be passed in. Example: make target PROJECT_ID=myprojectid"; exit 1 )
# Add Tag to Artifact
	echo "Adding tag: ${TAG} to Artifact: us-central1-docker.pkg.dev/${PROJECT_ID}/${ARTIFACT_NAME}/${ARTIFACT_NAME}:${GIT_HASH}"
	gcloud artifacts docker tags add \
	us-central1-docker.pkg.dev/${PROJECT_ID}/${ARTIFACT_NAME}/${ARTIFACT_NAME}:${GIT_HASH} \
	us-central1-docker.pkg.dev/${PROJECT_ID}/${ARTIFACT_NAME}/${ARTIFACT_NAME}:${TAG}
	echo "Successfully added ${TAG} to us-central1-docker.pkg.dev/${PROJECT_ID}/${ARTIFACT_NAME}/${ARTIFACT_NAME}:${GIT_HASH}"

run:		## Run dbt with current Git Hash Artifact
#		## Required Args: PROJECT_ID
##  
# Check if PROJECT_ID was passed in
	@[ "${PROJECT_ID}" ] || ( echo "PROJECT_ID must be passed in. Example: make target PROJECT_ID=myprojectid"; exit 1 )
# Load Variable from .env file
	$(call get_env_vars)
# Run dbt on local docker
	docker pull us-central1-docker.pkg.dev/${PROJECT_ID}/${ARTIFACT_NAME}/${ARTIFACT_NAME}:${GIT_HASH}
	docker run \
  -e SYNC_NAME=${SYNC_NAME} \
  -e CTA_DATASET_ID=${CTA_DATASET_ID} \
  -e CTA_PROJECT_ID=${CTA_PROJECT_ID} \
  -e PARTNER_DATASET_ID=${PARTNER_DATASET_ID} \
  -e PARTNER_PROJECT_ID=${PARTNER_PROJECT_ID} \
  -e GOOGLE_APPLICATION_CREDENTIALS=/tmp/gcloud/application_default_credentials.json \
  -v ${HOME}/.config/gcloud/application_default_credentials.json:/tmp/gcloud/application_default_credentials.json \
  us-central1-docker.pkg.dev/${PROJECT_ID}/${ARTIFACT_NAME}/${ARTIFACT_NAME}:${GIT_HASH} \
	run --profiles-dir /dbt --target ${DBT_TARGET} --select ${DBT_SELECT} ${DBT_FLAGS}

helper:		## Run cta_dbt_helper script
##  
	./utils/cta_dbt_helper.sh

.PHONY: help build tag helper run
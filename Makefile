# Makefile to make building and pushing dbt-cta Docker Image consistent
.EXPORT_ALL_VARIABLES:
PIPENV_VENV_IN_PROJECT = 1

# VARIABLES
ARTIFACT_NAME ?= dbt-cta
TAG ?= latest
GIT_HASH ?= $(shell git rev-parse HEAD)

# Helper Functions
define get_env_vars
	$(eval include .env)
	$(eval export)
endef

# TARGETS
help:	  	## Show help for available make functions
##   
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

build:		## Start a cloud build job for dbt-cta artifact. 
##  Required Args: PROJECT_ID
##  Optional Args: ARTIFACT_NAME
##  
	ifndef PROJECT_ID
		$(error PROJECT_ID must be passed in. Example: make build PROJECT_ID=myprojectid)
	endif
	echo "Building Artifact and Deploying to: us-central1-docker.pkg.dev/${PROJECT_ID}/${ARTIFACT_NAME}/${ARTIFACT_NAME}:${GIT_HASH}"
	gcloud builds submit --region=us-central1 --tag us-central1-docker.pkg.dev/${PROJECT_ID}/${ARTIFACT_NAME}/${ARTIFACT_NAME}:${GIT_HASH} --gcs-log-dir=gs://${PROJECT_ID}_cloudbuild/logs/
	echo "Successfully built ${ARTIFACT_NAME} with tag: ${GIT_HASH}"

tag:		## Add a tag to an existing Artifact.
##  Defaults to adding 'latest' tag to current GIT_HASH Artifact
##  Required Args: PROJECT_ID
##  Optional Args: TAG, GIT_HASH
##  
	ifndef PROJECT_ID
		$(error PROJECT_ID must be passed in. Example: make tag PROJECT_ID=myprojectid)
	endif
	echo "Adding tag: ${TAG} to Artifact: us-central1-docker.pkg.dev/${PROJECT_ID}/${ARTIFACT_NAME}/${ARTIFACT_NAME}:${GIT_HASH}"
	gcloud artifacts docker tags add \
	us-central1-docker.pkg.dev/${PROJECT_ID}/${ARTIFACT_NAME}/${ARTIFACT_NAME}:${GIT_HASH} \
	us-central1-docker.pkg.dev/${PROJECT_ID}/${ARTIFACT_NAME}/${ARTIFACT_NAME}:${TAG}
	echo "Successfully added ${TAG} to us-central1-docker.pkg.dev/${PROJECT_ID}/${ARTIFACT_NAME}/${ARTIFACT_NAME}:${GIT_HASH}"

helper:
	./utils/cta_dbt_helper.sh

run:  ## Run dbt with current Git Hash Artifact
	ifndef PROJECT_ID
		$(error PROJECT_ID must be passed in. Example: make run PROJECT_ID=myprojectid)
	endif
	$(call get_env_vars)
	cd dbt-cta
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
	run --profiles-dir /dbt --target ${DBT_TARGET} --select ${DBT_SELECT}

.PHONY: help build tag helper run
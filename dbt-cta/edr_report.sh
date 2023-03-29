#!/usr/bin/env sh
export PATH='$PATH:/home/airflow/.local/bin:/opt/python3.8/bin'
edr send-report \
    --profiles-dir . \
    --project-profile-target cta -c . \
    --slack-token $ELEMENTARY_SLACK_TOKEN \
    --slack-channel-name "elementary-alerts" \
    --project-name $SYNC_NAME \
    --env dev
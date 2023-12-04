#!/bin/bash

shopt -s nocasematch

# Ensure the user provides a pod name regex pattern, namespace, and container name as arguments
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <POD_NAME_REGEX_PATTERN> <NAMESPACE> <CONTAINER_NAME>"
    exit 1
fi

POD_NAME_PATTERN=$1
NAMESPACE=$2
CONTAINER_NAME=$3

while true; do
    # Get all pods in the namespace
    PODS=$(kubectl get pods -n $NAMESPACE --no-headers -o custom-columns=":metadata.name")

    for POD in $PODS; do
        # Use grep to filter pods based on the regex pattern
        if [[ $POD =~ $POD_NAME_PATTERN ]]; then
            # Fetch the container status using kubectl for each matching pod
            CONTAINER_STATUS=$(kubectl get pod $POD -n $NAMESPACE -o=jsonpath="{.status.phase}")

            # Check if the container is Running
            if [[ "$CONTAINER_STATUS" == *'running'* ]]; then
                echo "Container $CONTAINER_NAME in pod $POD is now running."

                # Copy /config directory from running container to local
                echo "Copying /config directory from $CONTAINER_NAME in pod $POD to local machine..."
                echo "Copying these files to local..."
                kubectl -n "$NAMESPACE" exec -ti "$POD" -- /bin/ls /config
                kubectl -n "$NAMESPACE" cp $NAMESPACE/$POD:/config config
                if [ $? -eq 0 ]; then
                    echo "Successfully copied /config directory."
                    exit 0
                else
                    echo "Failed to copy /config directory."
                    exit 1
                fi
            else
                echo "Waiting for container $CONTAINER_NAME in pod $POD to be running... Current status: $CONTAINER_STATUS"
            fi
        fi
    done

    sleep 0.5  # wait for 0.5 seconds before checking again
done


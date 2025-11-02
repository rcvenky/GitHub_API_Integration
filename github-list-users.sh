#!/bin/bash

######################################
# Author: Venkatesh
# Date: 14th Oct 2025
# About: This Script will give you list of GitHub Collaborators
# Version: v.0.01
# Updated on: 02nd Nov 2025
######################################

API_URL="https://api.github.com"

USERNAME=$username
TOKEN=$token

REPO_OWNER=$1
REPO_NAME=$2
function get_function {
	local endpoint="$1"
	curl -s -u "${USERNAME}:${TOKEN}" "${API_URL}/${endpoint}"
}
function list_of_collaborators {
	local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"
	collaborators="$(get_function "$endpoint" | jq -r '.[] | select(.permissions.admin == true) | .login ')"
	if [[ -z "$collaborators" ]]; then
		echo "No users for ${REPO_OWNER}/${REPO_NAME}"
	else
		echo "List of Users for this ${REPO_OWNER}/${REPO_NAME} Repository"
		echo "$collaborators"
	fi
}
list_of_collaborators

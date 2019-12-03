#!/bin/bash

if [[ -z "$ASSUME_ADMIN_TRUST_JWT" ]]; then
    echo "Must provide ASSUME_ADMIN_TRUST_JWT in environment" 1>&2
    exit 1
fi

if [[ -z "$FASTLANE_PASSWORD" ]]; then
    echo "Must provide FASTLANE_PASSWORD in environment" 1>&2
    exit 1
fi

if [[ -z "$FASTLANE_ITC_TEAM_ID" ]]; then
    echo "Must provide FASTLANE_ITC_TEAM_ID in environment" 1>&2
    exit 1
fi

if [[ -z "$FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD" ]]; then
    echo "Must provide FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD in environment" 1>&2
    exit 1
fi

SECONDS=0

# check libraries are installed that we need.

# get build related env vars now.

# with the trust JWT, get the store object.
export BASE_URL="https://y974dhoem9.execute-api.us-east-1.amazonaws.com/${STAGE}/web/configurator-proxy"
export GET_STORE_DETAILS_URL="${BASE_URL}/store"
export POST_UPDATE_URL="${BASE_URL}/build_update"

echo "Store Details URL | ${GET_STORE_DETAILS_URL} "
echo "Post Update URL | ${POST_UPDATE_URL} "
curl -H "Authorization: Bearer $ASSUME_ADMIN_TRUST_JWT" $GET_STORE_DETAILS_URL
export STORE_JSON=$(curl -H "Authorization: Bearer $ASSUME_ADMIN_TRUST_JWT" $GET_STORE_DETAILS_URL)
export APP_NAME=$(echo $STORE_JSON | jq '.store.name' -r)
export BUNDLE_IDENTIFIER=$(echo $STORE_JSON | jq '.store.bundle_identifier' -r)
export APP_OWNER=$(echo $STORE_JSON | jq '.store.email' -r)
export APP_BUILD_FOLDER="$BUNDLE_IDENTIFIER"

export KEYCHAIN_PATH=/Users/travis/Library/Keychains/travis-db
export KEYCHAIN_NAME=travis
export KEYCHAIN_PASS=travis

export LOADING_SCREEN_IMAGE=$(echo $STORE_JSON | jq '.store.branding.loadingScreen' -r)
export APP_ICON_IMAGE=$(echo $STORE_JSON | jq '.store.branding.appIcon' -r)
echo "Store Name | ${APP_NAME} "
echo "Bundle ID | ${BUNDLE_IDENTIFIER}"
echo "Loading image | ${LOADING_SCREEN_IMAGE}"
echo "App Icon image | ${APP_ICON_IMAGE}"
echo "App Owner | ${APP_OWNER}"
curl -X POST -H "Content-Type: application/json" \
    -H "Accept: application/json" \
    -H "Authorization: Bearer $ASSUME_ADMIN_TRUST_JWT" \
    -d "{\"status\": \"1. started\", \"build_id\": \"$BUILD_ID\"}" ${POST_UPDATE_URL}
./2-get-codebase.sh
./3-make-icons.sh
./4-begin-build.sh
echo "$SECONDS elapsed."

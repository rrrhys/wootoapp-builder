rm -rf $APP_BUILD_FOLDER
git clone --depth 1 https://github.com/rrrhys/wootoapp-rewrite.git $APP_BUILD_FOLDER
cd $APP_BUILD_FOLDER
yarn

curl -X POST -H "Content-Type: application/json" \
    -H "Accept: application/json" \
    -H "Authorization: Bearer $ASSUME_ADMIN_TRUST_JWT" \
    -d "{\"status\": \"2. installed JS\", \"build_id\": \"$BUILD_ID\"}" ${POST_UPDATE_URL}

pwd
cd ios
pod install
pod update

curl -X POST -H "Content-Type: application/json" \
    -H "Accept: application/json" \
    -H "Authorization: Bearer $ASSUME_ADMIN_TRUST_JWT" \
    -d "{\"status\": \"3. installed pods\", \"build_id\": \"$BUILD_ID\"}" ${POST_UPDATE_URL}

cd -

find . -name 'Appfile' -print0 | xargs -0 sed -i "" "s/com.wootoapp.MobileTEST/$BUNDLE_IDENTIFIER/g"
find . -name 'Fastfile' -print0 | xargs -0 sed -i "" "s/com.wootoapp.MobileTEST/$BUNDLE_IDENTIFIER/g"
find . -name 'project.pbxproj' -print0 | xargs -0 sed -i "" "s/com.wootoapp.MobileTEST/$BUNDLE_IDENTIFIER/g"

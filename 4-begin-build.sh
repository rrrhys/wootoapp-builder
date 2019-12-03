pwd
cd $APP_BUILD_FOLDER
cd ios

pwd

EMAIL="signing@wootoapp.com"
bundle install

echo "************ CREATE KEYCHAIN ************"
fastlane run create_keychain default_keychain:true timeout:3600 unlock:true add_to_search_list:true name:$KEYCHAIN_NAME password:$KEYCHAIN_PASS

echo "KEYCHAIN PATH $KEYCHAIN_PATH $KEYCHAIN_NAME $KEYCHAIN_PASS"
echo "************ MATCH ************"
fastlane match appstore -u $EMAIL --verbose --team-id $TEAM_ID --app_identifier $BUNDLE_IDENTIFIER --git_url https://rrrhys@github.com/rrrhys/wootoapp-match.git --keychain_name $KEYCHAIN_NAME --keychain_password $KEYCHAIN_PASS

echo "************ RUNNING FASTLANE PRODUCE ************"
fastlane produce create --app_name "$APP_NAME" --username $EMAIL --app_identifier "$BUNDLE_IDENTIFIER"
echo "************ RUNNING FASTLANE CERT ************"
fastlane cert -u $EMAIL --keychain_path $KEYCHAIN_PATH --keychain_password $KEYCHAIN_PASS --team_id $TEAM_ID
echo "************ RUNNING FASTLANE SIGH ************"
fastlane sigh --app_identifier "$BUNDLE_IDENTIFIER" -u $EMAIL --provisioning_name "$BUNDLE_IDENTIFIER profile"

echo "**** RANDO KEY THING ****"
security set-key-partition-list -S apple-tool:,apple: -s -k $KEYCHAIN_PASS $KEYCHAIN_PATH
echo "***** TRY UPDATE PROFILE****"
fastlane run update_project_provisioning xcodeproj:"MobileTEST.xcodeproj" profile:"./AppStore_$BUNDLE_IDENTIFIER.mobileprovision"
echo "****** TRY ADD TEAM*****"
fastlane run update_project_team path:"MobileTEST.xcodeproj" teamid:$TEAM_ID
echo "************ RUNNING FASTLANE BETA ************"
echo "******DATE******"
DATE=$(date +%s)
fastlane run increment_version_number version_number:$DATE
fastlane beta
fastlane pilot add $APP_OWNER -a $BUNDLE_IDENTIFIER --username $EMAIL --groups "External Testers"

pwd
cd $APP_BUILD_FOLDER
cd ios

pwd

EMAIL="signing@wootoapp.com"
bundle install

echo "************ CREATE KEYCHAIN ************"
fastlane action create_keychain default_keychain:true unlock:true add_to_search_list:true name:$KEYCHAIN_NAME

echo "************ MATCH ************"
fastlane match appstore -u $EMAIL --team-id $TEAM_ID --app_identifier $BUNDLE_IDENTIFIER --git_url https://rrrhys@github.com/rrrhys/wootoapp-match.git --keychain_name $KEYCHAIN_NAME --keychain_password $KEYCHAIN_PASS

echo "************ RUNNING FASTLANE PRODUCE ************"
fastlane produce create --app_name "$APP_NAME" --username $EMAIL --app_identifier "$BUNDLE_IDENTIFIER"
echo "************ RUNNING FASTLANE CERT ************"
fastlane cert -u $EMAIL --keychain_path $KEYCHAIN_PATH --keychain_password $KEYCHAIN_PASS
echo "************ RUNNING FASTLANE SIGH ************"
fastlane sigh --app_identifier "$BUNDLE_IDENTIFIER" -u $EMAIL --provisioning_name "$BUNDLE_IDENTIFIER profile"

echo "***** TRY UPDATE PROFILE****"
fastlane run update_project_provisioning xcodeproj:"MobileTEST.xcodeproj" profile:"./AppStore_com.$BUNDLE_IDENTIFIER.mobileprovision"
echo "************ RUNNING FASTLANE BETA ************"
fastlane beta
fastlane pilot add $APP_OWNER -a $BUNDLE_IDENTIFIER --username $EMAIL --groups "External Testers"

pwd
cd $APP_BUILD_FOLDER
cd ios

pwd

EMAIL="rrrhys@gmail.com"
bundle install

fastlane match appstore -u $EMAIL --team-id $TEAM_ID --app_identifier $BUNDLE_IDENTIFIER --git_url https://rrrhys@github.com/rrrhys/wootoapp-match.git --readonly true

echo "************ RUNNING FASTLANE PRODUCE ************"
fastlane produce create --app_name "$APP_NAME" --username $EMAIL --app_identifier "$BUNDLE_IDENTIFIER"
echo "************ RUNNING FASTLANE CERT ************"
fastlane cert -u $EMAIL
echo "************ RUNNING FASTLANE SIGH ************"
fastlane sigh --app_identifier "$BUNDLE_IDENTIFIER" --provisioning_name "$BUNDLE_IDENTIFIER profile"

echo "************ RUNNING FASTLANE BETA ************"
fastlane beta
fastlane pilot add $APP_OWNER -a $BUNDLE_IDENTIFIER --username $EMAIL --groups "External Testers"

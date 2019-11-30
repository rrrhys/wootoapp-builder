pwd
cd $APP_BUILD_FOLDER
cd ios

pwd

EMAIL="rrrhys@gmail.com"
bundle install

fastlane match -u $EMAIL --team-id $TEAM_ID --app_identifier $BUNDLE_IDENTIFIER --git_url git@github.com:rrrhys/wootoapp-match.git --type appstore

fastlane produce create --app_name "$APP_NAME" --username $EMAIL --app_identifier "$BUNDLE_IDENTIFIER"
fastlane cert -u $EMAIL
fastlane sigh --app_identifier "$BUNDLE_IDENTIFIER" --provisioning_name "$BUNDLE_IDENTIFIER profile" --force
fastlane beta
fastlane pilot add $APP_OWNER -a $BUNDLE_IDENTIFIER --username $EMAIL --groups "External Testers"

rm -rf $APP_BUILD_FOLDER
git clone --depth 1 https://github.com/rrrhys/wootoapp-rewrite.git $APP_BUILD_FOLDER
cd $APP_BUILD_FOLDER
npm i -g makeappicon
yarn
pwd
cd ios
pod install

cd -

find . -name 'Appfile' -print0 | xargs -0 sed -i "" "s/com.wootoapp.MobileTEST/$BUNDLE_IDENTIFIER/g"
find . -name 'Fastfile' -print0 | xargs -0 sed -i "" "s/com.wootoapp.MobileTEST/$BUNDLE_IDENTIFIER/g"
find . -name 'project.pbxproj' -print0 | xargs -0 sed -i "" "s/com.wootoapp.MobileTEST/$BUNDLE_IDENTIFIER/g"

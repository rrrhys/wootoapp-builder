rm -rf $APP_BUILD_FOLDER
echo "github.com ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==" >>~/.ssh/known_hosts
git clone --depth 1 git@github.com:rrrhys/wootoapp-rewrite.git $APP_BUILD_FOLDER
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

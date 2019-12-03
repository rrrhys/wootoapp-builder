cd $APP_BUILD_FOLDER
mkdir icontest
cd icontest
pwd
curl -O $APP_ICON_IMAGE
ICON_FILENAME=$(ls)
echo "Icon filename is $ICON_FILENAME"
RESULT=$(makeappicon --base-icon $ICON_FILENAME)
echo "RESULT IS $RESULT"
ls -l
cp AppIcon.appiconset/* ../ios/MobileTEST/Images.xcassets/AppIcon.appiconset/
cd ..
rm -rf icontest

mkdir loadingtest
cd loadingtest
pwd
curl -O $LOADING_SCREEN_IMAGE
LOADING_FILENAME=$(ls)
echo $LOADING_FILENAME
cp $LOADING_FILENAME elsplasho.jpg
cp $LOADING_FILENAME elsplasho-1.jpg
cp $LOADING_FILENAME elsplasho-2.jpg
cp -f elsplasho.jpg ../assets/elsplasho.jpg
cp -f elsplasho.jpg ../ios/MobileTEST/Images.xcassets/elsplasho.imageset/elsplasho.jpg
cp -f elsplasho-1.jpg ../ios/MobileTEST/Images.xcassets/elsplasho.imageset/elsplasho-1.jpg
cp -f elsplasho-2.jpg ../ios/MobileTEST/Images.xcassets/elsplasho.imageset/elsplasho-2.jpg
cd ..

rm -rf loadingtest

curl -X POST -H "Content-Type: application/json" \
    -H "Accept: application/json" \
    -H "Authorization: Bearer $ASSUME_ADMIN_TRUST_JWT" \
    -d "{\"status\": \"4. created icons\", \"build_id\": \"$BUILD_ID\"}" ${POST_UPDATE_URL}

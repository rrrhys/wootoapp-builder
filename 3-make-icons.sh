cd $APP_BUILD_FOLDER
mkdir icontest
cd icontest
pwd
curl -O $APP_ICON_IMAGE
ICON_FILENAME=$(ls)
makeappicon --base-icon $ICON_FILENAME
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

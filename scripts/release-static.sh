#!/bin/sh
brew install xcodegen
./generate-projects.sh --force-with-wrong-xcodegen
xcodebuild \
 -workspace FacebookSDK.xcworkspace \
 -scheme BuildAllKits-Static \
 -configuration Release \
 -sdk iphoneos \
 -derivedDataPath ./tmp

cp LICENSE tmp/Build/Products/Release-iphoneos/ || exit 1
cd tmp/Build/Products/Release-iphoneos/ || exit 1
zip -r FacebookSDK_static.zip ./*.framework ./*/*.framework LICENSE || exit 1
cd ../../../../
mkdir -p build || exit 1
mkdir -p build/Release || exit 1
cp tmp/Build/Products/Release-iphoneos/FacebookSDK_static.zip build/Release || exit 1
rm -rf tmp
#!/bin/sh

KEYCHAIN_NAME=ios-build.keychain
KEYCHAIN_PASSWORD=travis

# Create a custom keychain
security create-keychain -p $KEYCHAIN_PASSWORD $KEYCHAIN_NAME

# Make the custom keychain default, so xcodebuild will use it for signing
security default-keychain -s $KEYCHAIN_NAME

# Unlock the keychain
security unlock-keychain -p $KEYCHAIN_PASSWORD $KEYCHAIN_NAME

# Set keychain timeout to 1 hour for long builds
# see http://www.egeek.me/2013/02/23/jenkins-and-xcode-user-interaction-is-not-allowed/
security set-keychain-settings -t 3600 -l ~/Library/Keychains/$KEYCHAIN_NAME

# Add certificates to keychain and allow codesign to access them
security import ./scripts/certs/AppleWWDRCA.cer -k ~/Library/Keychains/$KEYCHAIN_NAME -T /usr/bin/codesign
security import ./scripts/certs/dev.cer -k ~/Library/Keychains/$KEYCHAIN_NAME -T /usr/bin/codesign
security import ./scripts/certs/dev.p12 -k ~/Library/Keychains/$KEYCHAIN_NAME -P $KEY_PASSWORD -T /usr/bin/codesign

#
# Put the provisioning profile in place
export DELIVER_PASSWORD=$APPLE_PASSWORD && export FASTLANE_DONT_STORE_PASSWORD=_ \
	&& produce -u $APPLE_ID --app_identifier $APP_ID --app_name $APP_TITLE --app_version "1.0"

export DELIVER_PASSWORD=$APPLE_PASSWORD && export FASTLANE_DONT_STORE_PASSWORD=_ \
	&& sigh --development -u $APPLE_ID --app_identifier $APP_ID --filename $APP_ID.mobileprovision --skip_install

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
cp "./$APP_ID.mobileprovision" ~/Library/MobileDevice/Provisioning\ Profiles/
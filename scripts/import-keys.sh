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

# # Put the provisioning profile in place
# mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
# cp "./scripts/profile/$PROFILE_NAME.mobileprovision" ~/Library/MobileDevice/Provisioning\ Profiles/
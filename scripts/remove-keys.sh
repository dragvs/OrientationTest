#!/bin/sh

security delete-keychain ios-build.keychain
rm -f ~/Library/MobileDevice/Provisioning\ Profiles/$APP_ID.mobileprovision
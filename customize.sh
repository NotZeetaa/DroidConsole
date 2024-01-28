#!/data/adb/magisk/busybox sh
set -o standalone

set -x

# Check Android API
[ $API -ge 23 ] ||
 abort "- Unsupported API version: $API"

mkdir -p $MODPATH/system/bin
mv -f $MODPATH/DroidConsole $MODPATH/system/bin/DroidConsole

# Clean up
ui_print "  Cleaning obsolete files"
find $MODPATH/* -maxdepth 0 \
! -name 'module.prop' \
! -name 'post-fs-data.sh' \
! -name 'service.sh' \
! -name 'system' \
! -name 'config.sh' \
-exec rm -rf {} \;

# Settings dir and file permission
ui_print "  Settings permissions"
set_perm_recursive $MODPATH 0 0 0755 0755
set_perm $MODPATH/system/bin/DroidConsole 0 2000 0755

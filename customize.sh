#!/data/adb/magisk/busybox sh
set -o standalone

set -x

# Check Android API
[ $API -ge 23 ] ||
 abort "- Unsupported API version: $API"

mkdir -p $MODPATH/system/bin
mv -f $MODPATH/config $MODPATH/system/bin/config
mv -f $MODPATH/DroidConsole $MODPATH/system/bin/DroidConsole
mv -f $MODPATH/scripts/cpu $MODPATH/system/bin/cpu
mv -f $MODPATH/scripts/ram $MODPATH/system/bin/ram
mv -f $MODPATH/scripts/gpu $MODPATH/system/bin/gpu
mv -f $MODPATH/scripts/misc $MODPATH/system/bin/misc
mv -f $MODPATH/scripts/variables $MODPATH/system/bin/variables
mv -f $MODPATH/restore $MODPATH/system/bin/restore

# Clean up
ui_print "  Cleaning obsolete files"
find $MODPATH/* -maxdepth 0 \
! -name 'module.prop' \
! -name 'post-fs-data.sh' \
! -name 'service.sh' \
! -name 'system' \
! -name 'config' \
! -name 'restore' \
! -name 'scripts/' \
-exec rm -rf {} \;

# Settings dir and file permission
ui_print "  Settings permissions"
set_perm_recursive $MODPATH 0 0 0755 0755
set_perm $MODPATH/system/bin/config 0 2000 0755
set_perm $MODPATH/system/bin/DroidConsole 0 2000 0755
set_perm $MODPATH/system/bin/cpu 0 2000 0755
set_perm $MODPATH/system/bin/ram 0 2000 0755
set_perm $MODPATH/system/bin/gpu 0 2000 0755
set_perm $MODPATH/system/bin/misc 0 2000 0755
set_perm $MODPATH/system/bin/variables 0 2000 0755
set_perm $MODPATH/system/bin/restore 0 2000 0755

#!/data/adb/magisk/busybox sh
set -o standalone

set -x

# Check Android API
[ $API -ge 23 ] ||
 abort "- Unsupported API version: $API"

mkdir -p $MODPATH/system/bin
mv -f $MODPATH/DroidConsole.sh $MODPATH/system/bin/DroidConsole.sh
mv -f $MODPATH/scripts/cpu.sh $MODPATH/system/bin/cpu.sh
mv -f $MODPATH/scripts/ram.sh $MODPATH/system/bin/ram.sh
mv -f $MODPATH/scripts/gpu.sh $MODPATH/system/bin/gpu.sh
mv -f $MODPATH/scripts/misc.sh $MODPATH/system/bin/misc.sh
mv -f $MODPATH/scripts/variables.sh $MODPATH/system/bin/variables.sh

# Clean up
ui_print "  Cleaning obsolete files"
find $MODPATH/* -maxdepth 0 \
! -name 'module.prop' \
! -name 'post-fs-data.sh' \
! -name 'service.sh' \
! -name 'system' \
! -name 'config.sh' \
! -name 'scripts/' \
-exec rm -rf {} \;

# Settings dir and file permission
ui_print "  Settings permissions"
set_perm_recursive $MODPATH 0 0 0755 0755
set_perm $MODPATH/system/bin/DroidConsole.sh 0 2000 0755
set_perm $MODPATH/system/bin/cpu.sh 0 2000 0755
set_perm $MODPATH/system/bin/ram.sh 0 2000 0755
set_perm $MODPATH/system/bin/gpu.sh 0 2000 0755
set_perm $MODPATH/system/bin/misc.sh 0 2000 0755
set_perm $MODPATH/system/bin/variables.sh 0 2000 0755

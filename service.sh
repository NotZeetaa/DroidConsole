#!/data/adb/magisk/busybox sh
set -o standalone

MODDIR=${0%/*}

$MODDIR/config.sh > /dev/null

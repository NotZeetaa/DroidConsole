#!/data/adb/magisk/busybox sh
set -o standalone

MODDIR=${0%/*}

restore > /dev/null
config > /dev/null

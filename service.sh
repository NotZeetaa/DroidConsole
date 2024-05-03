#!/data/adb/magisk/busybox sh
set -o standalone

MODDIR=${0%/*}

config > /dev/null

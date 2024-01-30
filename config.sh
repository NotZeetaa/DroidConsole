#!/system/bin/sh

# Variables
KGSL=/sys/class/kgsl/kgsl-3d0/
S2=/sys/devices/system/cpu/cpufreq/schedutil
SC=/sys/devices/system/cpu/cpu0/cpufreq/schedutil
GPU_THROTTLING=
CPU_RATELIMITS=
IOWAIT_BOOST=

if [ "$GPU_THROTTLING" -eq 1 ]; then
    echo "1" > $KGSL/throttling
elif [ "$GPU_THROTTLING" -eq 0 ]; then
    echo "0" > $KGSL/throttling
fi

if [ "$CPU_RATELIMITS" -eq 1 ]; then
    if [ -d $S2 ]; then
        echo "500" > $S2/up_rate_limit_us
        echo "20000" > $S2/down_rate_limit_us
    elif [ -e $SC ]; then
        for cpu in /sys/devices/system/cpu/*/cpufreq/schedutil
        do
            echo "500" > "${cpu}/up_rate_limit_us"
            echo "20000" > "${cpu}/down_rate_limit_us"
        done
    fi
fi

if [ "$IOWAIT_BOOST" -eq 1 ]; then
    if [ -d $S2 ]; then
        echo "1" > $S2/iowait_boost_enable
    elif [ -e $SC ]; then
        for cpu in /sys/devices/system/cpu/*/cpufreq/schedutil
        do
            echo "1" > "${cpu}/iowait_boost_enable"
        done
    fi
elif [ "$IOWAIT_BOOST" -eq 0 ]; then
    if [ -d $S2 ]; then
        echo "0" > $S2/iowait_boost_enable
    elif [ -e $SC ]; then
        for cpu in /sys/devices/system/cpu/*/cpufreq/schedutil
        do
            echo "0" > "${cpu}/iowait_boost_enable"
        done
    fi
fi
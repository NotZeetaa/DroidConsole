#!/system/bin/sh

# Call variables script
. /data/adb/modules/DroidConsole/system/bin/variables

# Variables
GPU_THROTTLING=
CPU_RATELIMITS=
IOWAIT_BOOST=
RAM_SWAP=
POWER_EFFICIENT=
GPU_POWER_LEVEL=

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

if [ "$RAM_SWAP" -eq 1 ]; then
    echo "100" > $SWP
fi

if [ "$POWER_EFFICIENT" -eq 1 ]; then
    echo "1" > $PWR
elif [ "$POWER_EFFICIENT" -eq 0 ]; then
    echo "0" > $PWR
fi

if [ "$GPU_POWER_LEVEL" -eq 1 ]; then
    echo "0" > $KGSL/default_pwrlevel
elif [ "$GPU_POWER_LEVEL" -eq 0]; then
    echo "$MIN_GPU_POWER_LEVEL" > $KGSL/default_pwrlevel
fi

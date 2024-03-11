#!/system/bin/sh

# Call variables script
. $(pwd)/variables.sh

cpu_iowait_boost() {
    clear
    red
    animation_title
    echo "********************************"
    animation_title
    echo "      × IO Wait Boost ×      "
    animation_title
    echo "********************************"
    green
    space
    animation
    echo "1 - Enable IO Wait Boost"
    animation
    echo "2 - Disable IO Wait Boost"
    animation
    echo "3 - Go back"
    animation
    echo "4 - Main"
    animation
    echo "5 - Exit"
    reset
    space
    echo "Your input: "
    read input
    case $input in
        1)
            if [ -d $S2 ]; then
                echo "1" > $S2/iowait_boost_enable
            elif [ -e $SC ]; then
                for cpu in /sys/devices/system/cpu/*/cpufreq/schedutil
                do
                    echo "1" > "${cpu}/iowait_boost_enable"
                done
            fi
            sed -i '/^IOWAIT_BOOST=/c\IOWAIT_BOOST="1"' $CONFIG
            finish
            cpu
            ;;
        2)
            if [ -d $S2 ]; then
                echo "0" > $S2/iowait_boost_enable
            elif [ -e $SC ]; then
                for cpu in /sys/devices/system/cpu/*/cpufreq/schedutil
                do
                    echo "0" > "${cpu}/iowait_boost_enable"
                done
            fi
            sed -i '/^IOWAIT_BOOST=/c\IOWAIT_BOOST="0"' $CONFIG
            finish
            cpu
            ;;
        3)
            cpu
            ;;
        4)
            main
            ;;
        5)
            leave
            ;;
        *)
            red
            echo "Invalid input!"
            reset
            ;;
    esac
}

cpu() {
    clear
    red
    animation_title
    echo "*****************************"
    animation_title
    echo "      × CPU Tweaks ×      "
    animation_title
    echo "*****************************"
    green
    space
    animation
    echo "1 - Schedutil rate limits"
    animation
    echo "2 - Iowait boost"
    animation
    echo "3 - Main"
    animation
    echo "4 - Exit"
    reset
    space
    echo "Your input: "
    read cpu_input
    case $cpu_input in
        1)
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
            sed -i '/^CPU_RATELIMITS=/c\CPU_RATELIMITS="1"' $CONFIG
            finish
            cpu
            ;;
        2)
            cpu_iowait_boost
            ;;
        3)
            main
            ;;
        4)
            leave
            ;;
        *)
            red
            echo "Invalid input!"
            reset
            ;;
    esac
    reset
}
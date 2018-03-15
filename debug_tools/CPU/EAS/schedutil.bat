cls
@echo off

:loop
echo "CPU0 up_rate_limit_us: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy0/schedutil/up_rate_limit_us
echo "CPU0 down_rate_limit_us: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy0/schedutil/down_rate_limit_us
echo "CPU0 iowait_boost_enable: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy0/schedutil/iowait_boost_enable

echo "CPU4 up_rate_limit_us: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy4/schedutil/up_rate_limit_us
echo "CPU4 down_rate_limit_us: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy4/schedutil/down_rate_limit_us
echo "CPU4 iowait_boost_enable: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy4/schedutil/iowait_boost_enable

timeout /t 5 /nobreak
goto loop
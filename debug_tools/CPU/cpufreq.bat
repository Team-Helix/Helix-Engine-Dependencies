cls
@echo off

:loop
echo "CPU0 MAX: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
echo "CPU0 MIN: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq

echo "CPU4 MAX: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq
echo "CPU4 MIN: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy4/scaling_min_freq

timeout /t 5 /nobreak
goto loop
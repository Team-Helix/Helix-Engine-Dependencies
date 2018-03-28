cls
@echo off

:loop
echo "CPU0 MAX: "
adb shell cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo "CPU0 MIN: "
adb shell cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo "CPU0 GOV: "
adb shell cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

echo "CPU4 MAX: "
adb shell cat /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
echo "CPU4 MIN: "
adb shell cat /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
echo "CPU4 GOV: "
adb shell cat /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor

timeout /t 5 /nobreak
goto loop
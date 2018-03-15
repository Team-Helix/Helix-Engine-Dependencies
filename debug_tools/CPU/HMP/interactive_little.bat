cls
@echo off

:loop
echo "CPU0 target_loads: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy0/interactive/target_loads
echo "CPU0 timer_slack: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy0/interactive/timer_slack
echo "CPU0 timer_rate: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy0/interactive/timer_rate
echo "CPU0 hispeed_freq: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy0/interactive/hispeed_freq
echo "CPU0 above_hispeed_delay: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy0/interactive/above_hispeed_delay
echo "CPU0 go_hispeed_load: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy0/interactive/go_hispeed_load
echo "CPU0 min_sample_time: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy0/interactive/min_sample_time
echo "CPU0 max_freq_hysteresis: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy0/interactive/max_freq_hysteresis
echo "CPU0 boost: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy0/interactive/boost
echo "CPU0 fast_ramp_down: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy0/interactive/fast_ramp_down
echo "CPU0 use_sched_load: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy0/interactive/use_sched_load
echo "CPU0 boostpulse_duration: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy0/interactive/boostpulse_duration
echo "CPU0 io_is_busy: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy0/interactive/io_is_busy
echo "CPU0 enable_prediction: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy0/interactive/enable_prediction

timeout /t 5 /nobreak
goto loop
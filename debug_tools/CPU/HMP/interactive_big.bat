cls
@echo off

:loop
echo "CPU4 target_loads: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy4/interactive/target_loads
echo "CPU4 timer_slack: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy4/interactive/timer_slack
echo "CPU4 timer_rate: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy4/interactive/timer_rate
echo "CPU4 hispeed_freq: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy4/interactive/hispeed_freq
echo "CPU4 above_hispeed_delay: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy4/interactive/above_hispeed_delay
echo "CPU4 go_hispeed_load: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy4/interactive/go_hispeed_load
echo "CPU4 min_sample_time: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy4/interactive/min_sample_time
echo "CPU4 max_freq_hysteresis: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy4/interactive/max_freq_hysteresis
echo "CPU4 boost: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy4/interactive/boost
echo "CPU4 fast_ramp_down: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy4/interactive/fast_ramp_down
echo "CPU4 use_sched_load: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy4/interactive/use_sched_load
echo "CPU4 boostpulse_duration: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy4/interactive/boostpulse_duration
echo "CPU4 io_is_busy: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy4/interactive/io_is_busy
echo "CPU4 enable_prediction: "
adb shell cat /sys/devices/system/cpu/cpufreq/policy4/interactive/enable_prediction

timeout /t 5 /nobreak
goto loop
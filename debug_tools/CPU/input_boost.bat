cls
@echo off

:loop
echo "input_boost_enabled: "
adb shell cat /sys/module/cpu_boost/parameters/input_boost_enabled
echo "input_boost_freq: "
adb shell cat /sys/module/cpu_boost/parameters/input_boost_freq
echo "input_boost_ms: "
adb shell cat /sys/module/cpu_boost/parameters/input_boost_ms
echo "sched_boost_on_input: "
adb shell cat /sys/module/msm_performance/parameters/touchboost/sched_boost_on_input
echo "touchboost: "
adb shell cat /sys/module/msm_performance/parameters/touchboost

timeout /t 5 /nobreak
goto loop
cls
@echo off

:loop
echo "enable_adaptive_lmk: "
adb shell cat /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
echo "minfree: "
adb shell cat /sys/module/lowmemorykiller/parameters/minfree
echo "debug_level: "
adb shell cat /sys/module/lowmemorykiller/parameters/debug_level

timeout /t 5 /nobreak
goto loop
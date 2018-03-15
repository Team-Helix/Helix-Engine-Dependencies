cls
@echo off

:loop
echo "top-app/schedtune.boost: "
adb shell cat /dev/stune/top-app/schedtune.boost
echo "top-app/schedtune.prefer_idle: "
adb shell cat /dev/stune/top-app/schedtune.prefer_idle
echo "foreground/schedtune.boost: "
adb shell cat /dev/stune/foreground/schedtune.boost
echo "foreground/schedtune.prefer_idle: "
adb shell cat /dev/stune/foreground/schedtune.prefer_idle
echo "background/schedtune.boost: "
adb shell cat /dev/stune/background/schedtune.boost
echo "background/schedtune.prefer_idle: "
adb shell cat /dev/stune/background/schedtune.prefer_idle
echo "dynamic_stune_boost: "
adb shell cat /sys/module/cpu_boost/parameters/dynamic_stune_boost

timeout /t 5 /nobreak
goto loop
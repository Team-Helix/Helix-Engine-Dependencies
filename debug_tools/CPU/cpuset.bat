cls
@echo off

:loop
echo "background: "
adb shell cat /dev/cpuset/background/cpus
echo "system-background: "
adb shell cat /dev/cpuset/system-background/cpus

timeout /t 5 /nobreak
goto loop
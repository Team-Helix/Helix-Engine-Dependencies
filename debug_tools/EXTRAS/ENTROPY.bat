cls
@echo off

:loop
echo "read_wakeup_threshold: "
adb shell cat /proc/sys/kernel/random/read_wakeup_threshold
echo "write_wakeup_threshold: "
adb shell cat /proc/sys/kernel/random/write_wakeup_threshold

timeout /t 5 /nobreak
goto loop
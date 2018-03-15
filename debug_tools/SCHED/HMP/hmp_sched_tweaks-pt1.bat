cls
@echo off

:loop
echo "sched_downmigrate: "
adb shell cat /proc/sys/kernel/sched_downmigrate
echo "sched_group_downmigrate: "
adb shell cat /proc/sys/kernel/sched_group_downmigrate
echo "sched_upmigrate: "
adb shell cat /proc/sys/kernel/sched_upmigrate
echo "sched_group_upmigrate: "
adb shell cat /proc/sys/kernel/sched_group_upmigrate

timeout /t 5 /nobreak
goto loop
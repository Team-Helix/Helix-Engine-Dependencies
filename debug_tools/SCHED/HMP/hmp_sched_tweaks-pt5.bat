cls
@echo off

:loop
echo "sched_wakeup_load_threshold: "
adb shell cat /proc/sys/kernel/sched_wakeup_load_threshold
echo "sched_rr_timeslice_ms: "
adb shell cat /proc/sys/kernel/sched_rr_timeslice_ms
echo "sched_migration_fixup: "
adb shell cat /proc/sys/kernel/sched_migration_fixup
echo "sched_autogroup_enabled: "
adb shell cat /proc/sys/kernel/sched_autogroup_enabled

timeout /t 5 /nobreak
goto loop
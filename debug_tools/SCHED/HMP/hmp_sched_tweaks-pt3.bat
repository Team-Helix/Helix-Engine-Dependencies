cls
@echo off

:loop
echo "sched_big_waker_task_load: "
adb shell cat /proc/sys/kernel/sched_big_waker_task_load
echo "sched_window_stats_policy: "
adb shell cat /proc/sys/kernel/sched_window_stats_policy
echo "sched_ravg_hist_size: "
adb shell cat /proc/sys/kernel/sched_ravg_hist_size
echo "sched_upmigrate_min_nice: "
adb shell cat /proc/sys/kernel/sched_upmigrate_min_nice

timeout /t 5 /nobreak
goto loop
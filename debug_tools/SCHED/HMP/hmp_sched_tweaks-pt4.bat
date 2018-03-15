cls
@echo off

:loop
echo "sched_spill_nr_run: "
adb shell cat /proc/sys/kernel/sched_spill_nr_run
echo "sched_spill_load: "
adb shell cat /proc/sys/kernel/sched_spill_load
echo "sched_enable_thread_grouping: "
adb shell cat /proc/sys/kernel/sched_enable_thread_grouping
echo "sched_restrict_cluster_spill: "
adb shell cat /proc/sys/kernel/sched_restrict_cluster_spill

timeout /t 5 /nobreak
goto loop
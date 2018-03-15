cls
@echo off

:loop
echo "sched_small_wakee_task_load: "
adb shell cat /proc/sys/kernel/sched_small_wakee_task_load
echo "sched_init_task_load: "
adb shell cat /proc/sys/kernel/sched_init_task_load
echo "sched_enable_power_aware: "
adb shell cat /proc/sys/kernel/sched_enable_power_aware
echo "sched_enable_thread_grouping: "
adb shell cat /proc/sys/kernel/sched_enable_thread_grouping

timeout /t 5 /nobreak
goto loop
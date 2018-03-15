cls
@echo off

:loop
echo "sched_use_walt_task_util: "
adb shell cat /proc/sys/kernel/sched_use_walt_task_util
echo "sched_use_walt_cpu_util: "
adb shell cat /proc/sys/kernel/sched_use_walt_cpu_util
echo "sched_walt_init_task_load_pct: "
adb shell cat /proc/sys/kernel/sched_walt_init_task_load_pct
echo "sched_walt_cpu_high_irqload: "
adb shell cat /proc/sys/kernel/sched_walt_cpu_high_irqload
echo "sched_child_runs_first: "
adb shell cat /proc/sys/kernel/sched_child_runs_first
echo "sched_nr_migrate: "
adb shell cat /proc/sys/kernel/sched_nr_migrate
echo "sched_initial_task_util: "
adb shell cat /proc/sys/kernel/sched_initial_task_util

timeout /t 5 /nobreak
goto loop
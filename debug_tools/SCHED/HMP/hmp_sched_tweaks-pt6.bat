cls
@echo off

:loop
echo "sched_freq_inc_notify: "
adb shell cat /proc/sys/kernel/sched_freq_inc_notify
echo "sched_freq_dec_notify: "
adb shell cat /proc/sys/kernel/sched_freq_dec_notify
echo "sched_select_prev_cpu_us: "
adb shell cat /proc/sys/kernel/sched_select_prev_cpu_us

timeout /t 5 /nobreak
goto loop
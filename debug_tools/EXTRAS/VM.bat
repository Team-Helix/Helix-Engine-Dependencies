cls
@echo off

:loop
echo "dirty_expire_centisecs: "
adb shell cat /proc/sys/vm/dirty_expire_centisecs
echo "dirty_writeback_centisecs: "
adb shell cat /proc/sys/vm/dirty_writeback_centisecs
echo "oom_kill_allocating_task: "
adb shell cat /proc/sys/vm/oom_kill_allocating_task
echo "page-cluster: "
adb shell cat /proc/sys/vm/page-cluster
echo "swappiness: "
adb shell cat /proc/sys/vm/swappiness
echo "vfs_cache_pressure: "
adb shell cat /proc/sys/vm/vfs_cache_pressure
echo "dirty_ratio: "
adb shell cat /proc/sys/vm/dirty_ratio
echo "dirty_background_ratio: "
adb shell cat /proc/sys/vm/dirty_background_ratio
echo "overcommit_memory: "
adb shell cat /proc/sys/vm/overcommit_memory
echo "overcommit_ratio: "
adb shell cat /proc/sys/vm/overcommit_ratio
echo "min_free_kbytes: "
adb shell cat /proc/sys/vm/min_free_kbytes

timeout /t 5 /nobreak
goto loop
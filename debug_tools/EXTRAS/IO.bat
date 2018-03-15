cls
@echo off

:loop
echo "scheduler: "
adb shell cat /sys/block/sda/queue/scheduler
echo "read_ahead_kb: "
adb shell cat /sys/block/sda/queue/read_ahead_kb
echo "nr_requests: "
adb shell cat /sys/block/sda/queue/nr_requests
echo "add_random: "
adb shell cat /sys/block/sda/queue/add_random
echo "iostats: "
adb shell cat /sys/block/sda/queue/iostats
echo "nomerges: "
adb shell cat /sys/block/sda/queue/nomerges
echo "rotational: "
adb shell cat /sys/block/sda/queue/rotational
echo "rq_affinity: "
adb shell cat /sys/block/sda/queue/rq_affinity

timeout /t 5 /nobreak
goto loop
#!/system/bin/sh
#Original author: Alcolawl
#Settings By: RogerF81
#Device: LG G4 (h815/h811)
#Codename: LoG
#SoC: Snapdragon 808
#Build Status: Final
#Version: 4.0
#Last Updated: 10/10/2017
#Credits: @Alcolawl @soniCron @Asiier @Freak07 @Mostafa Wael @Senthil360 @TotallyAnxious @Eliminater74 @RenderBroken @ZeroInfinity @kyuubi10 @ivicask
sleep 30
echo "\m/"
echo "Let's go"
#Disable BCL
if [ -e "/sys/devices/soc/soc:qcom,bcl/mode" ]; then
echo Disabling BCL and Removing Perfd
	chmod 644 /sys/devices/soc/soc:qcom,bcl/mode
	echo -n disable > /sys/devices/soc/soc:qcom,bcl/mode
fi
if [ -e "/sys/devices/soc.0/qcom,bcl.67/mode" ]; then
	echo disable > /sys/devices/soc.0/qcom,bcl.67/mode
	echo -n disable > /sys/devices/soc.0/qcom,bcl.67/mode
fi
if [ -e "/data/system/perfd" ]; then
	stop perfd
fi
if [ -e "/data/system/perfd/default_values" ]; then
	rm /data/system/perfd/default_values
fi
chmod 644 /sys/devices/system/cpu/online
echo 0-5 > /sys/devices/system/cpu/online
echo 1 > /sys/devices/system/cpu/cpu0/online
echo 1 > /sys/devices/system/cpu/cpu1/online
echo 1 > /sys/devices/system/cpu/cpu2/online
echo 1 > /sys/devices/system/cpu/cpu3/online
echo 1 > //sys/devices/system/cpu/cpu4/online
echo 1 > //sys/devices/system/cpu/cpu5/online
chmod 444 /sys/devices/system/cpu/online
#LITTLE cluster
chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo interactive > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo 1440000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
#Tweak LITTLE cluster
chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/*
echo 76 600000:40 672000:58 787200:82 960000:89 1248000:99 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
echo 356940 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_slack
echo 600000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
echo 20000 460000:0 600000:60000 672000:100000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
echo 400 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/ignore_hispeed_on_notif
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/boost
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/fast_ramp_down
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/align_windows
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/boostpulse_duration
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/enable_prediction
chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/interactive/*
#big cluster
chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
echo interactive > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
echo 384000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
echo 1824000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
#Tweak big cluster
chmod 644 /sys/devices/system/cpu/cpu2/cpufreq/interactive/*
echo 76 633000:48 768000:57 1248000:74 1440000:86 1824000:99 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
echo 178470 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_slack
echo 1824000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
echo 10000 1440000:120000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
echo 400 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis
echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/ignore_hispeed_on_notif
echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/boost
echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/fast_ramp_down
echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/align_windows
echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load
echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/boostpulse_duration
echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/enable_prediction
chmod 444 /sys/devices/system/cpu/cpu2/cpufreq/interactive/*
#Disable input boost
if [ -e "/sys/kernel/cpu_input_boost" ]; then
	chmod 644 /sys/kernel/cpu_input_boost/enable
	echo 0 > /sys/kernel/cpu_input_boost/enable
	chmod 644 /sys/kernel/cpu_input_boost/ib_duration_ms
	echo 0 > /sys/kernel/cpu_input_boost/ib_duration_ms
	chmod 644 /sys/kernel/cpu_input_boost/ib_freqs
	echo "0 0" > /sys/kernel/cpu_input_boost/ib_freqs
fi
if [ -e "/sys/module/cpu_boost" ]; then
	chmod 644 /sys/module/cpu_boost/parameters/input_boost_enabled
	echo 0 > /sys/module/cpu_boost/parameters/input_boost_enabled
	chmod 644 /sys/module/cpu_boost/parameters/input_boost_freq
	echo 0:0 1:0 2:0 3:0 > /sys/module/cpu_boost/parameters/input_boost_freq
	chmod 644 /sys/module/cpu_boost/parameters/boost_ms
	echo 0 > /sys/module/cpu_boost/parameters/boost_ms
	chmod 644 /sys/module/cpu_boost/parameters/input_boost_ms
	echo 0 > /sys/module/cpu_boost/parameters/input_boost_ms
fi
#Disable TouchBoost
echo Disabling TouchBoost
if [ -e "/sys/module/msm_performance/parameters/touchboost" ]; then
	chmod 644 /sys/module/msm_performance/parameters/touchboost
	echo 0 > /sys/module/msm_performance/parameters/touchboost
fi
#Further settings
echo Tweaking HMP Scheduler
chmod 644 /sys/module/workqueue/parameters/power_efficient
echo Y > /sys/module/workqueue/parameters/power_efficient 
echo 68 > /proc/sys/kernel/sched_upmigrate
echo 33 > /proc/sys/kernel/sched_downmigrate
echo 20 > /proc/sys/kernel/sched_small_wakee_task_load
#echo 25 > /proc/sys/kernel/sched_init_task_load
if [ -e "/proc/sys/kernel/sched_heavy_task" ]; then
    echo 79 > /proc/sys/kernel/sched_heavy_task
fi
if [ -e "/proc/sys/kernel/sched_enable_power_aware" ]; then
    echo 1 > /proc/sys/kernel/sched_enable_power_aware
fi
echo 1 > /proc/sys/kernel/sched_enable_thread_grouping
echo 30 > /proc/sys/kernel/sched_big_waker_task_load
#if [ -e "/proc/sys/kernel/sched_small_task" ]; then
#	echo 7 > /proc/sys/kernel/sched_small_task
#fi
echo 2 > /proc/sys/kernel/sched_window_stats_policy
echo 4 > /proc/sys/kernel/sched_ravg_hist_size
echo 9 > /proc/sys/kernel/sched_upmigrate_min_nice
echo 3 > /proc/sys/kernel/sched_spill_nr_run
echo 74 > /proc/sys/kernel/sched_spill_load
echo 1 > /proc/sys/kernel/sched_enable_thread_grouping
echo 0 > /proc/sys/kernel/sched_restrict_cluster_spill
echo 110 > /proc/sys/kernel/sched_wakeup_load_threshold
echo 30 > /proc/sys/kernel/sched_rr_timeslice_ms
echo 950000 > /proc/sys/kernel/sched_rt_runtime_us
echo 1000000 > /proc/sys/kernel/sched_rt_period_us
if [ -e "/proc/sys/kernel/sched_migration_fixup" ]; then
	echo 1 > /proc/sys/kernel/sched_migration_fixup
fi
if [ -e "/proc/sys/kernel/sched_freq_dec_notify" ]; then
	echo 410000 > /proc/sys/kernel/sched_freq_dec_notify
fi
if [ -e "/proc/sys/kernel/sched_freq_inc_notify" ]; then
	echo 610000 > /proc/sys/kernel/sched_freq_inc_notify
fi
if [ -e "/proc/sys/kernel/sched_boost" ]; then
	echo 0 > /proc/sys/kernel/sched_boost
fi
#I/0 & block tweaks
string3=/block/mmcblk0/queue/scheduler;
maple=false;
cfq=false;
noop=false;
if grep 'maple' $string3; then
     maple=true;
fi
if grep 'cfq' $string3; then
     cfq=true;
fi
if grep 'noop' $string3; then
     noop=true;
fi
if [ "$maple" == "true" ]; then
	if [ -e $string3 ]; then
		echo "setting maple"
		echo 512 > /sys/block/mmcblk0/bdi/read_ahead_kb
		echo "maple" > /sys/block/mmcblk0/queue/scheduler
		echo 16 > /sys/block/mmcblk0/queue/iosched/fifo_batch
		echo 4 > /sys/block/mmcblk0/queue/iosched/writes_starved
		echo 10 > /sys/block/mmcblk0/queue/iosched/sleep_latency_multiple
		#echo 200 > /sys/block/mmcblk0/queue/iosched/async_read_expire   ##default values
		#echo 500 > /sys/block/mmcblk0/queue/iosched/async_write_expire   ##default values
		#echo 100 > /sys/block/mmcblk0/queue/iosched/sync_read_expire   ##default values
		#echo 350 > /sys/block/mmcblk0/queue/iosched/sync_write_expire   ##default values
		#echo 5 * HZ > /sys/block/mmcblk0/queue/iosched/async_read_expire  ##if CONFIG_HZ=1000
		#echo 5 * HZ > /sys/block/mmcblk0/queue/iosched/async_write_expire  ##if CONFIG_HZ=1000
		#echo HZ / 2 > /sys/block/mmcblk0/queue/iosched/sync_read_expire  ##if CONFIG_HZ=1000
		#echo HZ / 2 > /sys/block/mmcblk0/queue/iosched/sync_write_expire  ##if CONFIG_HZ=1000
		#echo 250 > /sys/block/mmcblk0/queue/iosched/async_read_expire  ##previously used values
		#echo 450 > /sys/block/mmcblk0/queue/iosched/async_write_expire  ##previously used values
		#echo 350 > /sys/block/mmcblk0/queue/iosched/sync_read_expire  ##previously used values
		#echo 550 > /sys/block/mmcblk0/queue/iosched/sync_write_expire  ##previously used values
		echo 1500 > /sys/block/mmcblk0/queue/iosched/async_read_expire
		echo 1500 > /sys/block/mmcblk0/queue/iosched/async_write_expire
		echo 150 > /sys/block/mmcblk0/queue/iosched/sync_read_expire
		echo 150 > /sys/block/mmcblk0/queue/iosched/sync_write_expire
		echo 128 > /sys/block/mmcblk0/queue/nr_requests
		echo 0 > /sys/block/mmcblk0/queue/add_random
		echo 0 > /sys/block/mmcblk0/queue/iostats
		echo 1 > /sys/block/mmcblk0/queue/nomerges
		echo 0 > /sys/block/mmcblk0/queue/rotational
		echo 1 > /sys/block/mmcblk0/queue/rq_affinity
		echo 1024 > /sys/block/mmcblk1/bdi/read_ahead_kb
		echo "maple" > /sys/block/mmcblk1/queue/scheduler
		echo 16 > /sys/block/mmcblk1/queue/iosched/fifo_batch
		echo 4 > /sys/block/mmcblk1/queue/iosched/writes_starved
		echo 10 > /sys/block/mmcblk1/queue/iosched/sleep_latency_multiple
		#echo 200 > /sys/block/mmcblk1/queue/iosched/async_read_expire   ##default values
		#echo 500 > /sys/block/mmcblk1/queue/iosched/async_write_expire   ##default values
		#echo 100 > /sys/block/mmcblk1/queue/iosched/sync_read_expire   ##default values
		#echo 350 > /sys/block/mmcblk1/queue/iosched/sync_write_expire   ##default values
		#echo 5 * HZ > /sys/block/mmcblk1/queue/iosched/async_read_expire  ##if CONFIG_HZ=1000
		#echo 5 * HZ > /sys/block/mmcblk1/queue/iosched/async_write_expire  ##if CONFIG_HZ=1000
		#echo HZ / 2 > /sys/block/mmcblk1/queue/iosched/sync_read_expire  ##if CONFIG_HZ=1000
		#echo HZ / 2 > /sys/block/mmcblk1/queue/iosched/sync_write_expire  ##if CONFIG_HZ=1000
		#echo 250 > /sys/block/mmcblk1/queue/iosched/async_read_expire  ##previously used values
		#echo 450 > /sys/block/mmcblk1/queue/iosched/async_write_expire  ##previously used values
		#echo 350 > /sys/block/mmcblk1/queue/iosched/sync_read_expire  ##previously used values
		#echo 550 > /sys/block/mmcblk1/queue/iosched/sync_write_expire  ##previously used values
		echo 1500 > /sys/block/mmcblk1/queue/iosched/async_read_expire
		echo 1500 > /sys/block/mmcblk1/queue/iosched/async_write_expire
		echo 150 > /sys/block/mmcblk1/queue/iosched/sync_read_expire
		echo 150 > /sys/block/mmcblk1/queue/iosched/sync_write_expire
		echo 128 > /sys/block/mmcblk1/queue/nr_requests
		echo 0 > /sys/block/mmcblk1/queue/add_random
		echo 0 > /sys/block/mmcblk1/queue/iostats
		echo 1 > /sys/block/mmcblk1/queue/nomerges
		echo 0 > /sys/block/mmcblk1/queue/rotational
		echo 1 > /sys/block/mmcblk1/queue/rq_affinity
		echo 1024 > /sys/block/mmcblk0rpmb/bdi/read_ahead_kb
		echo "maple" > /sys/block/mmcblk0rpmb/queue/scheduler
		echo 1 > /sys/block/mmcblk0rpmb/queue/iosched/fifo_batch
		echo 4 > /sys/block/mmcblk0rpmb/queue/iosched/writes_starved
		echo 10 > /sys/block/mmcblk0rpmb/queue/iosched/sleep_latency_multiple
		#echo 200 > /sys/block/mmcblk0rpmb/queue/iosched/async_read_expire   ##default values
		#echo 500 > /sys/block/mmcblk0rpmb/queue/iosched/async_write_expire   ##default values
		#echo 100 > /sys/block/mmcblk0rpmb/queue/iosched/sync_read_expire   ##default values
		#echo 350 > /sys/block/mmcblk0rpmb/queue/iosched/sync_write_expire   ##default values
		#echo 5 * HZ > /sys/block/mmcblk0rpmb/queue/iosched/async_read_expire  ##if CONFIG_HZ=1000
		#echo 5 * HZ > /sys/block/mmcblk0rpmb/queue/iosched/async_write_expire  ##if CONFIG_HZ=1000
		#echo HZ / 2 > /sys/block/mmcblk0rpmb/queue/iosched/sync_read_expire  ##if CONFIG_HZ=1000
		#echo HZ /2 > /sys/block/mmcblk0rpmb/queue/iosched/sync_write_expire  ##if CONFIG_HZ=1000
		#echo 250 > /sys/block/mmcblk0rpmb/queue/iosched/async_read_expire  ##previously used values
		#echo 450 > /sys/block/mmcblk0rpmb/queue/iosched/async_write_expire  ##previously used values
		#echo 350 > /sys/block/mmcblk0rpmb/queue/iosched/sync_read_expire  ##previously used values
		#echo 550 > /sys/block/mmcblk0rpmb/queue/iosched/sync_write_expire  ##previously used values
		echo 1500 > /sys/block/mmcblk0rpmb/queue/iosched/async_read_expire
		echo 1500 > /sys/block/mmcblk0rpmb/queue/iosched/async_write_expire
		echo 150 > /sys/block/mmcblk0rpmb/queue/iosched/sync_read_expire
		echo 150 > /sys/block/mmcblk0rpmb/queue/iosched/sync_write_expire
		echo 0 > /sys/block/mmcblk0rpmb/queue/add_random
		echo 0 > /sys/block/mmcblk0rpmb/queue/iostats
		echo 1 > /sys/block/mmcblk0rpmb/queue/nomerges
		echo 0 > /sys/block/mmcblk0rpmb/queue/rotational
		echo 1 > /sys/block/mmcblk0rpmb/queue/rq_affinity
	fi
elif [ "$maple" == "false" ] && [ "cfq" == "true" ]; then
	if [ -e $string3 ]; then
		echo setting cfq
		echo 512 > /sys/block/mmcblk0/bdi/read_ahead_kb
		echo "cfq" > /sys/block/mmcblk0/queue/scheduler
		echo 1 > /sys/block/mmcblk0/queue/iosched/back_seek_penalty
		echo 16384 > /sys/block/mmcblk0/queue/iosched/back_seek_max
		echo 120 > /sys/block/mmcblk0/queue/iosched/fifo_expire_sync
		echo 250 > /sys/block/mmcblk0/queue/iosched/fifo_expire_async
		echo 0 > /sys/block/mmcblk0/queue/iosched/slice_idle
		echo 8 > /sys/block/mmcblk0/queue/iosched/group_idle
		echo 1 > /sys/block/mmcblk0/queue/iosched/low_latency
		echo 10 > /sys/block/mmcblk0/queue/iosched/quantum
		echo 40 > /sys/block/mmcblk0/queue/iosched/slice_async
		echo 2 > /sys/block/mmcblk0/queue/iosched/slice_async_rq
		echo 100 > /sys/block/mmcblk0/queue/iosched/slice_sync
		echo 300 > /sys/block/mmcblk0/queue/iosched/target_latencymax_time
		echo 0 > /sys/block/mmcblk0/queue/add_random
		echo 0 > /sys/block/mmcblk0/queue/iostats
		echo 1 > /sys/block/mmcblk0/queue/nomerges
		echo 0 > /sys/block/mmcblk0/queue/rotational
		echo 1 > /sys/block/mmcblk1/queue/rq_affinity
		echo 1024 > /sys/block/mmcblk1/bdi/read_ahead_kb
		echo "cfq" > /sys/block/mmcblk1/queue/scheduler
		echo 1 > /sys/block/mmcblk1/queue/iosched/back_seek_penalty
		echo 16384 > /sys/block/mmcblk1/queue/iosched/back_seek_max
		echo 120 > /sys/block/mmcblk1/queue/iosched/fifo_expire_sync
		echo 250 > /sys/block/mmcblk1/queue/iosched/fifo_expire_async
		echo 0 > /sys/block/mmcblk1/queue/iosched/slice_idle
		echo 8 > /sys/block/mmcblk1/queue/iosched/group_idle
		echo 1 > /sys/block/mmcblk1/queue/iosched/low_latency
		echo 10 > /sys/block/mmcblk1/queue/iosched/quantum
		echo 40 > /sys/block/mmcblk1/queue/iosched/slice_async
		echo 2 > /sys/block/mmcblk1/queue/iosched/slice_async_rq
		echo 100 > /sys/block/mmcblk1/queue/iosched/slice_sync
		echo 300 > /sys/block/mmcblk1/queue/iosched/target_latencymax_time
		echo 0 > /sys/block/mmcblk1/queue/add_random
		echo 0 > /sys/block/mmcblk1/queue/iostats
		echo 1 > /sys/block/mmcblk1/queue/nomerges
		echo 0 > /sys/block/mmcblk1/queue/rotational
		echo 1 > /sys/block/mmcblk1/queue/rq_affinity
		echo "cfq" > /sys/block/mmcblk0rpmb/queue/scheduler
		echo 1 > /sys/block/mmcblk0rpmb/queue/iosched/back_seek_penalty
		echo 16384 > /sys/block/mmcblk0rpmb/queue/iosched/back_seek_max
		echo 120 > /sys/block/mmcblk0rpmb/queue/iosched/fifo_expire_sync
		echo 250 > /sys/block/mmcblk0rpmb/queue/iosched/fifo_expire_async
		echo 0 > /sys/block/mmcblk0rpmb/queue/iosched/slice_idle
		echo 8 > /sys/block/mmcblk0rpmb/queue/iosched/group_idle
		echo 1 > /sys/block/mmcblk0rpmb/queue/iosched/low_latency
		echo 10 > /sys/block/mmcblk0rpmb/queue/iosched/quantum
		echo 40 > /sys/block/mmcblk0rpmb/queue/iosched/slice_async
		echo 2 > /sys/block/mmcblk0rpmb/queue/iosched/slice_async_rq
		echo 100 > /sys/block/mmcblk0rpmb/queue/iosched/slice_sync
		echo 300 > /sys/block/mmcblk0rpmb/queue/iosched/target_latencymax_time
		echo 0 > /sys/block/mmcblk0rpmb/queue/add_random
		echo 0 > /sys/block/mmcblk0rpmb/queue/iostats
		echo 1 > /sys/block/mmcblk0rpmb/queue/nomerges
		echo 0 > /sys/block/mmcblk0rpmb/queue/rotational
		echo 1 > /sys/block/mmcblk0rpmb/queue/rq_affinity
	fi
elif [ "$maple" == "false" ] && [ "cfq" == "false" ]&& [ "noop" == "true" ]; then
	if [ -e $string3 ]; then
		echo setting noop
		echo 512 > /sys/block/mmcblk0/bdi/read_ahead_kb
		echo "noop" > /sys/block/mmcblk0/queue/scheduler
		echo 0 > /sys/block/mmcblk0/queue/add_random
		echo 0 > /sys/block/mmcblk0/queue/iostats
		echo 1 > /sys/block/mmcblk0/queue/nomerges
		echo 0 > /sys/block/mmcblk0/queue/rotational
		echo 1 > /sys/block/mmcblk1/queue/rq_affinity
		echo 1024 > /sys/block/mmcblk1/bdi/read_ahead_kb
		echo "noop" > /sys/block/mmcblk1/queue/scheduler
		echo 0 > /sys/block/mmcblk1/queue/add_random
		echo 0 > /sys/block/mmcblk1/queue/iostats
		echo 1 > /sys/block/mmcblk1/queue/nomerges
		echo 0 > /sys/block/mmcblk1/queue/rotational
		echo 1 > /sys/block/mmcblk1/queue/rq_affinity
		echo "noop" > /sys/block/mmcblk0rpmb/queue/scheduler
		echo 0 > /sys/block/mmcblk0rpmb/queue/add_random
		echo 0 > /sys/block/mmcblk0rpmb/queue/iostats
		echo 1 > /sys/block/mmcblk0rpmb/queue/nomerges
		echo 0 > /sys/block/mmcblk0rpmb/queue/rotational
		echo 1 > /sys/block/mmcblk0rpmb/queue/rq_affinity
	fi
else
    if [ -e $string3 ]; then
		echo "I/0 governor won't be changed"
    fi
fi
#TCP tweaks
string4=/proc/sys/net/ipv4/tcp_available_congestion_control;
westwood=false;
if grep 'westwood' $string4; then
	westwood=true;
fi
if [ "$westwood" == "true" ]; then
	if [ -e $string4 ]; then
		echo "westwood will be set"
		echo westwood > /proc/sys/net/ipv4/tcp_congestion_control
		echo 2 > /proc/sys/net/ipv4/tcp_ecn
		echo 1 > /proc/sys/net/ipv4/tcp_dsack
		echo 1 > /proc/sys/net/ipv4/tcp_low_latency
		echo 1 > /proc/sys/net/ipv4/tcp_timestamps
		echo 1 > /proc/sys/net/ipv4/tcp_sack
		echo 1 > /proc/sys/net/ipv4/tcp_window_scaling
	fi
else
	if [ -e $string4 ]; then
		echo "cubic will be set"
		echo cubic > /proc/sys/net/ipv4/tcp_congestion_control
		echo 2 > /proc/sys/net/ipv4/tcp_ecn
		echo 1 > /proc/sys/net/ipv4/tcp_dsack
		echo 1 > /proc/sys/net/ipv4/tcp_low_latency
		echo 1 > /proc/sys/net/ipv4/tcp_timestamps
		echo 1 > /proc/sys/net/ipv4/tcp_sack
		echo 1 > /proc/sys/net/ipv4/tcp_window_scaling
	fi
fi
## Wakelocks
if [ -e "/sys/module/bcmdhd/parameters/wlrx_divide" ]; then
	echo 10 > /sys/module/bcmdhd/parameters/wlrx_divide
fi
if [ -e "/sys/module/bcmdhd/parameters/wlctrl_divide" ]; then
	echo 10 > /sys/module/bcmdhd/parameters/wlctrl_divide
fi
if [ -e "/sys/module/wakeup/parameters/enable_bluetooth_timer" ]; then
	echo N > /sys/module/wakeup/parameters/enable_bluetooth_timer
fi
if [ -e "/sys/module/wakeup/parameters/enable_ipa_ws" ]; then 
	echo N > /sys/module/wakeup/parameters/enable_ipa_ws
fi
if [ -e "/sys/module/wakeup/parameters/enable_netlink_ws" ]; then
	echo N > /sys/module/wakeup/parameters/enable_netlink_ws
fi
if [ -e "/sys/module/wakeup/parameters/enable_netmgr_wl_ws" ]; then
	echo N > /sys/module/wakeup/parameters/enable_netmgr_wl_ws
fi
if [ -e "/sys/module/wakeup/parameters/enable_qcom_rx_wakelock_ws" ]; then 
	echo N > /sys/module/wakeup/parameters/enable_qcom_rx_wakelock_ws
fi
if [ -e "/sys/module/wakeup/parameters/enable_timerfd_ws" ]; then
	echo N > /sys/module/wakeup/parameters/enable_timerfd_ws
fi
if [ -e "/sys/module/wakeup/parameters/enable_wlan_extscan_wl_ws" ]; then 
	echo N > /sys/module/wakeup/parameters/enable_wlan_extscan_wl_ws
fi
if [ -e "/sys/module/wakeup/parameters/enable_wlan_wow_wl_ws" ]; then 
	echo N > /sys/module/wakeup/parameters/enable_wlan_wow_wl_ws
fi
if [ -e "/sys/module/wakeup/parameters/enable_wlan_ws" ]; then
	echo N > /sys/module/wakeup/parameters/enable_wlan_ws
fi
if [ -e "/sys/module/wakeup/parameters/enable_timerfd_ws" ]; then
	echo N > /sys/module/wakeup/parameters/enable_timerfd_ws
fi
if [ -e "/sys/module/wakeup/parameters/enable_netmgr_wl_ws" ]; then
	echo N > /sys/module/wakeup/parameters/enable_netmgr_wl_ws
fi
if [ -e "/sys/module/wakeup/parameters/enable_wlan_wow_wl_ws" ]; then
	echo N > /sys/module/wakeup/parameters/enable_wlan_wow_wl_ws
fi
if [ -e "/sys/module/wakeup/parameters/enable_wlan_ipa_ws" ]; then
	echo N > /sys/module/wakeup/parameters/enable_wlan_ipa_ws
fi
if [ -e "/sys/module/wakeup/parameters/enable_wlan_pno_wl_ws" ]; then
	echo N > /sys/module/wakeup/parameters/enable_wlan_pno_wl_ws
fi
if [ -e "/sys/module/wakeup/parameters/enable_wcnss_filter_lock_ws" ]; then
	echo N > /sys/module/wakeup/parameters/enable_wcnss_filter_lock_ws
fi
## Thermal
if [ -e "/sys/module/msm_thermal" ]; then
	chmod 644 /sys/module/msm_thermal/parameters/temp_threshold
	echo 38 > /sys/module/msm_thermal/parameters/temp_threshold
	echo 1 > /sys/module/msm_thermal/core_control/enabled
	chmod 644 /sys/module/msm_thermal/parameters/enabled
	echo N > /sys/module/msm_thermal/parameters/enabled
fi
## zRam
if [ -e "/sys/block/zram0" ]; then
	swapoff /dev/block/zram0 > /dev/null 2>&1
	echo 1 > /sys/block/zram0/reset
	echo lz4 > /sys/block/zram0/comp_algorithm
	echo 0 > /sys/block/zram0/disksize
	echo 0 > /sys/block/zram0/queue/add_random 
	echo 0 > /sys/block/zram0/queue/iostats 
	echo 2 > /sys/block/zram0/queue/nomerges 
	echo 0 > /sys/block/zram0/queue/rotational 
	echo 1 > /sys/block/zram0/queue/rq_affinity
	echo 48 > /sys/block/zram0/queue/nr_requests
	echo 4 > /sys/block/zram0/max_comp_streams
	chmod 644 /sys/block/zram0/disksize
	echo 1073741824 > /sys/block/zram0/disksize
	mkswap /dev/block/zram0 > /dev/null 2>&1
	swapon /dev/block/zram0 > /dev/null 2>&1
fi
## Vibration
chmod 644 /sys/class/timed_output/vibrator/voltage_level
echo 710 > /sys/class/timed_output/vibrator/voltage_level
chmod 444 /sys/class/timed_output/vibrator/voltage_level
## FS
echo 10 > /proc/sys/fs/lease-break-time
echo 32768 > /proc/sys/fs/inotify/max_queued_events
echo 256 > /proc/sys/fs/inotify/max_user_instances
echo 16384 > /proc/sys/fs/inotify/max_user_watches
## WQ
chmod 644 /sys/module/workqueue/parameters/power_efficient
echo Y > /sys/module/workqueue/parameters/power_efficient 
## VM
echo 500 > /proc/sys/vm/dirty_expire_centisecs
echo 6000 > /proc/sys/vm/dirty_writeback_centisecs
echo 1 > /proc/sys/vm/oom_kill_allocating_task
echo 2 > /proc/sys/vm/page-cluster
echo 60 > /proc/sys/vm/swappiness
echo 100 > /proc/sys/vm/vfs_cache_pressure
echo 40 > /proc/sys/vm/dirty_ratio
echo 20 > /proc/sys/vm/dirty_background_ratio
echo 0 > /proc/sys/vm/overcommit_memory
echo 4096 > /proc/sys/vm/min_free_kbytes
echo 64 > /proc/sys/kernel/random/read_wakeup_threshold
echo 896 > /proc/sys/kernel/random/write_wakeup_threshold
## Block loop
for i in /sys/block/loop*; do
   echo 0 > $i/queue/add_random
   echo 0 > $i/queue/iostats
   echo 1 > $i/queue/nomerges
   echo 0 > $i/queue/rotational
   echo 1 > $i/queue/rq_affinity
done
## Block ram
for j in /sys/block/ram*; do
   echo 0 > $j/queue/add_random
   echo 0 > $j/queue/iostats
   echo 1 > $j/queue/nomerges
   echo 0 > $j/queue/rotational
   echo 1 > $j/queue/rq_affinity
done
## Charging 
echo "0" > /sys/kernel/fast_charge/force_fast_charge
sleep 1
start perfd
## Filesystem
#busybox mount -o remount,noatime,barrier=0,nodiratime /sys
#busybox mount -o remount,noatime,noauto_da_alloc,nodiratime,barrier=0,nobh /system
#busybox mount -o remount,noatime,noauto_da_alloc,nosuid,nodev,nodiratime,barrier=0,nobh /data
#busybox mount -o remount,noatime,noauto_da_alloc,nosuid,nodev,nodiratime,barrier=0,nobh /cache
fstrim -v /data
fstrim -v /cache
fstrim -v /system
fstrim -v /preload
echo ----------------------------------------------------
echo Settings Successfully Applied. You may now tweak them further in EX Kernel Manager
echo ----------------------------------------------------

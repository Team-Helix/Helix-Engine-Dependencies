#!/system/bin/sh
# AUTHOR: TEAM HELIX @ XDA-DEVELOPERS
# Template by @ZeroInfinity, adapted from @RogerF81, improved by @Asiier
# Helix-Engine profile script: Balanced

#Stune
echo 15 > /dev/stune/top-app/schedtune.boost
echo 0 > /dev/stune/background/schedtune.boost
echo 0 > /dev/stune/foreground/schedtune.boost
echo 0 > /dev/stune/schedtune.prefer_idle
echo 0 > /proc/sys/kernel/sched_child_runs_first
echo 0 > /dev/stune/background/schedtune.prefer_idle
echo 1 > /dev/stune/foreground/schedtune.prefer_idle
echo 1 > /dev/stune/top-app/schedtune.prefer_idle
echo 64 > /proc/sys/kernel/sched_nr_migrate
echo 0 > /proc/sys/kernel/sched_initial_task_util

#Cpuset
echo 0-1 > /dev/cpuset/background/cpus
echo 0-1 > /dev/cpuset/system-background/cpus

#Governor
if grep 'schedutil' /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors; then
	#LITTLE
	echo schedutil > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
	echo '1900800' > /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
	echo '518400' > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
	echo 500 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/up_rate_limit_us
	echo 20000 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/down_rate_limit_us
	echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/iowait_boost_enable
	echo 20 > /sys/module/cpu_boost/parameters/dynamic_stune_boost
	echo 1 > /proc/sys/kernel/sched_use_walt_task_util
	echo 1 > /proc/sys/kernel/sched_use_walt_cpu_util
	echo 15 > /proc/sys/kernel/sched_walt_init_task_load_pct
	echo 10000000 > /proc/sys/kernel/sched_walt_cpu_high_irqload
	#big
	echo schedutil > /sys/devices/system/cpu/cpufreq/policy4/scaling_governor
	echo '2457400' > /sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq
	echo '806400' > /sys/devices/system/cpu/cpufreq/policy4/scaling_min_freq
	echo 500 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/up_rate_limit_us
	echo 20000 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/down_rate_limit_us
	echo 0 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/iowait_boost_enable
else
	#LITTLE
	echo interactive > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
	echo '1900800' > /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
	echo '518400' > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
	echo 74 518400:78 672000:81 883200:83 1248000:85 1478400:86 1670400:90 1824000:95 > /sys/devices/system/cpu/cpufreq/policy0/interactive/target_loads
	echo 90000 > /sys/devices/system/cpu/cpufreq/policy0/interactive/timer_slack
	echo 15000 > /sys/devices/system/cpu/cpufreq/policy0/interactive/timer_rate
	echo 1555200 > /sys/devices/system/cpu/cpufreq/policy0/interactive/hispeed_freq
	echo 0 > /sys/devices/system/cpu/cpufreq/policy0/interactive/above_hispeed_delay
	echo 400 > /sys/devices/system/cpu/cpufreq/policy0/interactive/go_hispeed_load
	echo 20000 > /sys/devices/system/cpu/cpufreq/policy0/interactive/min_sample_time
	echo 79000 > /sys/devices/system/cpu/cpufreq/policy0/interactive/max_freq_hysteresis
	echo 0 > /sys/devices/system/cpu/cpufreq/policy0/interactive/boost
	echo 0 > /sys/devices/system/cpu/cpufreq/policy0/interactive/fast_ramp_down
	echo 1 > /sys/devices/system/cpu/cpufreq/policy0/interactive/use_sched_load
	echo 80000 > /sys/devices/system/cpu/cpufreq/policy0/interactive/boostpulse_duration
	echo 0 > /sys/devices/system/cpu/cpufreq/policy0/interactive/io_is_busy
	echo 0 > /sys/devices/system/cpu/cpufreq/policy0/interactive/enable_prediction
	#big
	echo interactive > /sys/devices/system/cpu/cpufreq/policy4/scaling_governor
	echo '2457400' > /sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq
	echo '806400' > /sys/devices/system/cpu/cpufreq/policy4/scaling_min_freq
	echo 78 652800:81 1056000:84 1344000:85 1651200:86 1958400:90 2342400:95 > /sys/devices/system/cpu/cpufreq/policy4/interactive/target_loads
	echo 90000 > /sys/devices/system/cpu/cpufreq/policy4/interactive/timer_slack
	echo 2361600 > /sys/devices/system/cpu/cpufreq/policy4/interactive/hispeed_freq
	echo 15000 > /sys/devices/system/cpu/cpufreq/policy4/interactive/timer_rate
	echo 0 979200:20000 1574400:40000 > /sys/devices/system/cpu/cpufreq/policy4/interactive/above_hispeed_delay
	echo 400 > /sys/devices/system/cpu/cpufreq/policy4/interactive/go_hispeed_load
	echo 20000 > /sys/devices/system/cpu/cpufreq/policy4/interactive/min_sample_time
	echo 79000 > /sys/devices/system/cpu/cpufreq/policy4/interactive/max_freq_hysteresis
	echo 0 > /sys/devices/system/cpu/cpufreq/policy4/interactive/boost
	echo 0 > /sys/devices/system/cpu/cpufreq/policy4/interactive/fast_ramp_down
	echo 1 > /sys/devices/system/cpu/cpufreq/policy4/interactive/use_sched_load
	echo 80000 > /sys/devices/system/cpu/cpufreq/policy4/interactive/boostpulse_duration
	echo 0 > /sys/devices/system/cpu/cpufreq/policy4/interactive/io_is_busy
	echo 0 > /sys/devices/system/cpu/cpufreq/policy4/interactive/enable_prediction
	#HMP tunables
	echo 40 > /proc/sys/kernel/sched_downmigrate
	echo 50 > /proc/sys/kernel/sched_group_downmigrate
	echo 70 > /proc/sys/kernel/sched_upmigrate
	echo 80 > /proc/sys/kernel/sched_group_upmigrate
	echo 5 > /proc/sys/kernel/sched_small_wakee_task_load
	echo 15 > /proc/sys/kernel/sched_init_task_load
	echo 1 > /proc/sys/kernel/sched_enable_power_aware
	echo 1 > /proc/sys/kernel/sched_enable_thread_grouping
	echo 20 > /proc/sys/kernel/sched_big_waker_task_load
	echo 2 > /proc/sys/kernel/sched_window_stats_policy
	echo 5 > /proc/sys/kernel/sched_ravg_hist_size
	echo 9 > /proc/sys/kernel/sched_upmigrate_min_nice
	echo 3 > /proc/sys/kernel/sched_spill_nr_run
	echo 60 > /proc/sys/kernel/sched_spill_load
	echo 1 > /proc/sys/kernel/sched_enable_thread_grouping
	echo 1 > /proc/sys/kernel/sched_restrict_cluster_spill
	echo 110 > /proc/sys/kernel/sched_wakeup_load_threshold
	echo 10 > /proc/sys/kernel/sched_rr_timeslice_ms
	echo 1 > /proc/sys/kernel/sched_enable_power_aware
	echo 1 > /proc/sys/kernel/sched_migration_fixup
	echo 0 > /proc/sys/kernel/sched_autogroup_enabled
	echo 100000 > /proc/sys/kernel/sched_freq_inc_notify
	echo 500000 > /proc/sys/kernel/sched_freq_dec_notify
	echo 2000 > /proc/sys/kernel/sched_select_prev_cpu_us
	#Input boost
	echo 1 > /sys/module/cpu_boost/parameters/input_boost_enabled
	echo 0:1094400 1:0 2:0 3:0 4:1056000 5:0 6:0 7:0 > /sys/module/cpu_boost/parameters/input_boost_freq
	echo 690 > /sys/module/cpu_boost/parameters/input_boost_ms
	echo N > /sys/module/msm_performance/parameters/touchboost/sched_boost_on_input
fi

#I/0
echo "cfq" > /sys/block/sda/queue/scheduler
echo 1024 > /sys/block/sda/queue/read_ahead_kb
echo 160 > /sys/block/sda/queue/nr_requests
echo 0 > /sys/block/sda/queue/add_random
echo 0 > /sys/block/sda/queue/iostats
echo 1 > /sys/block/sda/queue/nomerges
echo 0 > /sys/block/sda/queue/rotational
echo 1 > /sys/block/sda/queue/rq_affinity

#TCP
echo 0 > /proc/sys/net/ipv4/tcp_low_latency

#LMK
chown root /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
echo 0 > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
echo "8192,10240,12288,14336,24576,35840" > /sys/module/lowmemorykiller/parameters/minfree
echo 0 > /sys/module/lowmemorykiller/parameters/debug_level

#VM
echo 1500 > /proc/sys/vm/dirty_expire_centisecs
echo 1500 > /proc/sys/vm/dirty_writeback_centisecs
echo 0 > /proc/sys/vm/oom_kill_allocating_task
echo 3 > /proc/sys/vm/page-cluster
echo 0 > /proc/sys/vm/swappiness
echo 70 > /proc/sys/vm/vfs_cache_pressure
echo 15 > /proc/sys/vm/dirty_ratio
echo 10 > /proc/sys/vm/dirty_background_ratio
echo 1 > /proc/sys/vm/overcommit_memory
echo 50 > /proc/sys/vm/overcommit_ratio
echo 20480 > /proc/sys/vm/min_free_kbytes
echo 128 > /proc/sys/kernel/random/read_wakeup_threshold
echo 896 > /proc/sys/kernel/random/write_wakeup_threshold

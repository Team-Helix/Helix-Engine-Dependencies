#!/system/bin/sh
# AUTHOR: TEAM HELIX @ XDA-DEVELOPERS
# Template by @ZeroInfinity, adapted from @RogerF81, improved by @Asiier
# Helix-Engine profile script: Balanced

#Stune
echo 1 > /dev/stune/top-app/schedtune.boost
echo 0 > /dev/stune/background/schedtune.boost
echo 0 > /dev/stune/foreground/schedtune.boost
echo 0 > /dev/stune/schedtune.prefer_idle
echo 0 > /proc/sys/kernel/sched_child_runs_first
echo 0 > /dev/stune/background/schedtune.prefer_idle
echo 0 > /dev/stune/foreground/schedtune.prefer_idle
echo 1 > /dev/stune/top-app/schedtune.prefer_idle
echo 32 > /proc/sys/kernel/sched_nr_migrate
echo 0 > /proc/sys/kernel/sched_initial_task_util

#Cpuset
echo 0 > /dev/cpuset/background/cpus
echo 0-1 > /dev/cpuset/system-background/cpus

#Governor
if grep 'schedutil' /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors; then
	#LITTLE
	echo schedutil > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
	echo '1094400' > /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
	echo '518400' > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
	echo 2000 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/up_rate_limit_us
	echo 7000 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/down_rate_limit_us
	echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/iowait_boost_enable
	echo 0 > /sys/module/cpu_boost/parameters/dynamic_stune_boost
	echo 1 > /proc/sys/kernel/sched_use_walt_task_util
	echo 1 > /proc/sys/kernel/sched_use_walt_cpu_util
	echo 0 > /proc/sys/kernel/sched_walt_init_task_load_pct
	echo 10000000 > /proc/sys/kernel/sched_walt_cpu_high_irqload
	#big
	echo schedutil > /sys/devices/system/cpu/cpufreq/policy4/scaling_governor
	echo '1056000' > /sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq
	echo '806400' > /sys/devices/system/cpu/cpufreq/policy4/scaling_min_freq
	echo 2000 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/up_rate_limit_us
	echo 5000 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/down_rate_limit_us
	echo 0 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/iowait_boost_enable
else
	#LITTLE
	echo interactive > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
	echo '1094400' > /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
	echo '300000' > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
	echo 81 672000:85 883200:88 960000:92 1171200:96 > /sys/devices/system/cpu/cpufreq/policy0/interactive/target_loads
	echo 90000 > /sys/devices/system/cpu/cpufreq/policy0/interactive/timer_slack
	echo 50000 > /sys/devices/system/cpu/cpufreq/policy0/interactive/timer_rate
	echo 1171200 > /sys/devices/system/cpu/cpufreq/policy0/interactive/hispeed_freq
	echo 20000 883200:40000 1171200:60000 > /sys/devices/system/cpu/cpufreq/policy0/interactive/above_hispeed_delay
	echo 400 > /sys/devices/system/cpu/cpufreq/policy0/interactive/go_hispeed_load
	echo 5000 > /sys/devices/system/cpu/cpufreq/policy0/interactive/min_sample_time
	echo 0 > /sys/devices/system/cpu/cpufreq/policy0/interactive/max_freq_hysteresis
	echo 0 > /sys/devices/system/cpu/cpufreq/policy0/interactive/boost
	echo 1 > /sys/devices/system/cpu/cpufreq/policy0/interactive/fast_ramp_down
	echo 1 > /sys/devices/system/cpu/cpufreq/policy0/interactive/use_sched_load
	echo 0 > /sys/devices/system/cpu/cpufreq/policy0/interactive/boostpulse_duration
	echo 0 > /sys/devices/system/cpu/cpufreq/policy0/interactive/io_is_busy
	echo 0 > /sys/devices/system/cpu/cpufreq/policy0/interactive/enable_prediction
	#big
	echo interactive > /sys/devices/system/cpu/cpufreq/policy4/scaling_governor
	echo '1651200' > /sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq
	echo '300000' > /sys/devices/system/cpu/cpufreq/policy4/scaling_min_freq
	echo 82 652800:85 902400:89 1132800:92 1574400:96 > /sys/devices/system/cpu/cpufreq/policy4/interactive/target_loads
	echo 120000 > /sys/devices/system/cpu/cpufreq/policy4/interactive/timer_slack
	echo 1574400 > /sys/devices/system/cpu/cpufreq/policy4/interactive/hispeed_freq
	echo 60000 > /sys/devices/system/cpu/cpufreq/policy4/interactive/timer_rate
	echo 20000 902400:40000 1574400:80000 > /sys/devices/system/cpu/cpufreq/policy4/interactive/above_hispeed_delay
	echo 400 > /sys/devices/system/cpu/cpufreq/policy4/interactive/go_hispeed_load
	echo 5000 > /sys/devices/system/cpu/cpufreq/policy4/interactive/min_sample_time
	echo 0 > /sys/devices/system/cpu/cpufreq/policy4/interactive/max_freq_hysteresis
	echo 0 > /sys/devices/system/cpu/cpufreq/policy4/interactive/boost
	echo 1 > /sys/devices/system/cpu/cpufreq/policy4/interactive/fast_ramp_down
	echo 1 > /sys/devices/system/cpu/cpufreq/policy4/interactive/use_sched_load
	echo 0 > /sys/devices/system/cpu/cpufreq/policy4/interactive/boostpulse_duration
	echo 0 > /sys/devices/system/cpu/cpufreq/policy4/interactive/io_is_busy
	echo 0 > /sys/devices/system/cpu/cpufreq/policy4/interactive/enable_prediction
	#HMP tunables
	echo 70 > /proc/sys/kernel/sched_downmigrate
	echo 80 > /proc/sys/kernel/sched_group_downmigrate
	echo 95 > /proc/sys/kernel/sched_upmigrate
	echo 100 > /proc/sys/kernel/sched_group_upmigrate
	echo 15 > /proc/sys/kernel/sched_small_wakee_task_load
	echo 5 > /proc/sys/kernel/sched_init_task_load
	echo 1 > /proc/sys/kernel/sched_enable_power_aware
	echo 1 > /proc/sys/kernel/sched_enable_thread_grouping
	echo 30 > /proc/sys/kernel/sched_big_waker_task_load
	echo 3 > /proc/sys/kernel/sched_window_stats_policy
	echo 5 > /proc/sys/kernel/sched_ravg_hist_size
	echo 0 > /proc/sys/kernel/sched_upmigrate_min_nice
	echo 10 > /proc/sys/kernel/sched_spill_nr_run
	echo 95 > /proc/sys/kernel/sched_spill_load
	echo 1 > /proc/sys/kernel/sched_enable_thread_grouping
	echo 1 > /proc/sys/kernel/sched_restrict_cluster_spill
	echo 110 > /proc/sys/kernel/sched_wakeup_load_threshold
	echo 10 > /proc/sys/kernel/sched_rr_timeslice_ms
	echo 1 > /proc/sys/kernel/sched_enable_power_aware
	echo 1 > /proc/sys/kernel/sched_migration_fixup
	echo 1 > /proc/sys/kernel/sched_autogroup_enabled
	echo 400000 > /proc/sys/kernel/sched_freq_inc_notify
	echo 400000 > /proc/sys/kernel/sched_freq_dec_notify
	echo 0 > /proc/sys/kernel/sched_select_prev_cpu_us
	#Input boost
	echo 1 > /sys/module/cpu_boost/parameters/input_boost_enabled
	echo 0:518400 1:0 2:0 3:0 4:806400 5:0 6:0 7:0 > /sys/module/cpu_boost/parameters/input_boost_freq
	echo 230 > /sys/module/cpu_boost/parameters/input_boost_ms
	echo N > /sys/module/msm_performance/parameters/touchboost/sched_boost_on_input
fi

#Touchboost
echo 0 > /sys/module/msm_performance/parameters/touchboost

#I/0
echo "cfq" > /sys/block/sda/queue/scheduler
echo 1024 > /sys/block/sda/queue/read_ahead_kb
echo 128 > /sys/block/sda/queue/nr_requests
echo 0 > /sys/block/sda/queue/add_random
echo 0 > /sys/block/sda/queue/iostats
echo 1 > /sys/block/sda/queue/nomerges
echo 0 > /sys/block/sda/queue/rotational
echo 1 > /sys/block/sda/queue/rq_affinity

#TCP
echo 1 > /proc/sys/net/ipv4/tcp_low_latency

#LMK
chown root /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
echo 0 > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
echo "12288,15360,18432,21504,36864,53760" > /sys/module/lowmemorykiller/parameters/minfree
echo 0 > /sys/module/lowmemorykiller/parameters/debug_level

#VM
echo 1500 > /proc/sys/vm/dirty_expire_centisecs
echo 1500 > /proc/sys/vm/dirty_writeback_centisecs
echo 0 > /proc/sys/vm/oom_kill_allocating_task
echo 3 > /proc/sys/vm/page-cluster
echo 30 > /proc/sys/vm/swappiness
echo 70 > /proc/sys/vm/vfs_cache_pressure
echo 15 > /proc/sys/vm/dirty_ratio
echo 10 > /proc/sys/vm/dirty_background_ratio
echo 1 > /proc/sys/vm/overcommit_memory
echo 50 > /proc/sys/vm/overcommit_ratio
echo 20480 > /proc/sys/vm/min_free_kbytes
echo 32 > /proc/sys/kernel/random/read_wakeup_threshold
echo 896 > /proc/sys/kernel/random/write_wakeup_threshold

#!/system/bin/sh
#Original author: Alcolawl
#Settings By: RogerF81
#Device: OnePlus 5
#Codename: SoilWork UNIFIED
#SoC: Snapdragon 835
#Last Updated: 07/02/2018
#Credits: @Alcolawl @soniCron @Asiier @Freak07 @Mostafa Wael @Senthil360 @TotallyAnxious @RenderBroken @ZeroInfinity @Kyuubi10 @ivicask @RogerF81 @joshuous @boyd95 @ZeroKool76 @adanteon
codename=Soilwork
stype=battery
version=V3.0
cdate=$(date)

#Initializing log

#Disable BCL
if [ -e "/sys/devices/soc/soc:qcom,bcl/mode" ]; then
	chmod 644 /sys/devices/soc/soc:qcom,bcl/mode
	echo -n disable > /sys/devices/soc/soc:qcom,bcl/mode
fi

#Turn off core_control
echo 0 > /sys/module/msm_thermal/core_control/enabled

##Configuring stune & cpuset
if [ -d "/dev/stune" ]; then
	echo 1 > /dev/stune/schedtune.sched_boost_enabled
	echo 0 > /dev/stune/background/schedtune.boost
	echo 0 > /dev/stune/foreground/schedtune.boost
	echo 0 > /dev/stune/schedtune.prefer_idle
	echo 0 > /proc/sys/kernel/sched_child_runs_first
	echo 0 > /dev/stune/background/schedtune.prefer_idle
	echo 0 > /dev/stune/foreground/schedtune.prefer_idle
	echo 1 > /dev/stune/top-app/schedtune.prefer_idle
	if [ -e "/proc/sys/kernel/sched_boost" ]; then
		echo 0 > /proc/sys/kernel/sched_boost
	fi
fi
echo 32 > /proc/sys/kernel/sched_nr_migrate
echo 0 > /proc/sys/kernel/sched_initial_task_util

if [ -d "/dev/cpuset" ]; then
	echo 0 > /dev/cpuset/background/cpus
	echo 0-1 > /dev/cpuset/system-background/cpus
fi

if [ -e "/proc/sys/kernel/sched_autogroup_enabled" ]; then
	echo 1 > /proc/sys/kernel/sched_autogroup_enabled
fi


big_max_value=0
little_max_value=0
big_min_value=0
little_min_value=0

little_max_value=$(cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq);
big_max_value=$(cat /sys/devices/system/cpu/cpufreq/policy4/cpuinfo_max_freq);
little_min_value=$(cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq);
big_min_value=$(cat /sys/devices/system/cpu/cpufreq/policy4/cpuinfo_min_freq);

#Turn on all cores
chmod 644 /sys/devices/system/cpu/online
echo 0-7 > /sys/devices/system/cpu/online
chmod 444 /sys/devices/system/cpu/online
echo 1 > /sys/devices/system/cpu/cpu0/online
echo 1 > /sys/devices/system/cpu/cpu1/online
echo 1 > /sys/devices/system/cpu/cpu2/online
echo 1 > /sys/devices/system/cpu/cpu3/online
echo 1 > /sys/devices/system/cpu/cpu4/online
echo 1 > /sys/devices/system/cpu/cpu5/online
echo 1 > /sys/devices/system/cpu/cpu6/online
echo 1 > /sys/devices/system/cpu/cpu7/online

#Apply settings to LITTLE cluster

if [ -d /sys/devices/system/cpu/cpufreq/policy0 ]; then
	if [ -e /sys/devices/system/cpu/cpufreq/policy0 ]; then
		LGP=/sys/devices/system/cpu/cpufreq/policy0
	fi

	AGL=/sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors;

	if grep 'pwrutilx' $AGL; then
		if [ -e $AGL ]; then
			chmod 644 /sys/devices/system/cpu/cpufreq/policy0/pwrutilx/*
			chmod 644 $LGP/pwrutilx/*
			echo pwrutilx > $LGP/scaling_governor
			echo 1000 > $LGP/pwrutilx/up_rate_limit_us
			echo 10000 > $LGP/pwrutilx/down_rate_limit_us
			echo 15 > /sys/module/cpu_boost/parameters/dynamic_stune_boost
			echo 1 > /dev/stune/top-app/schedtune.boost
			echo 1 > $LGP/pwrutilx/iowait_boost_enable
			echo 1 > /proc/sys/kernel/sched_cstate_aware
			if [ -e "/proc/sys/kernel/sched_use_walt_task_util" ]; then
				echo 1 > /proc/sys/kernel/sched_use_walt_task_util
				echo 1 > /proc/sys/kernel/sched_use_walt_cpu_util
				echo 0 > /proc/sys/kernel/sched_walt_init_task_load_pct
				echo 10000000 > /proc/sys/kernel/sched_walt_cpu_high_irqload
			fi
			chmod 444 /sys/devices/system/cpu/cpufreq/policy0/pwrutilx/*
			chmod 444 $LGP/pwrutilx/*
		fi
	
	elif grep 'schedutil' $AGL; then
		if [ -e $AGL ]; then
			chmod 644 /sys/devices/system/cpu/cpufreq/policy0/schedutil/*
			chmod 644 $LGP/schedutil/*
			echo schedutil > $LGP/scaling_governor
			echo 2000 > $LGP/schedutil/up_rate_limit_us
			echo 7000 > $LGP/schedutil/down_rate_limit_us
			if [ -e "$LGP/schedutil/iowait_boost_enable" ]; then
				echo 0 > $LGP/schedutil/iowait_boost_enable
			fi
			echo 12 > /sys/module/cpu_boost/parameters/dynamic_stune_boost
			echo 0 > /dev/stune/top-app/schedtune.boost
			echo 1 > /proc/sys/kernel/sched_cstate_aware
			if [ -e "/proc/sys/kernel/sched_use_walt_task_util" ]; then
				echo 1 > /proc/sys/kernel/sched_use_walt_task_util
				echo 1 > /proc/sys/kernel/sched_use_walt_cpu_util
				echo 0 > /proc/sys/kernel/sched_walt_init_task_load_pct
				echo 10000000 > /proc/sys/kernel/sched_walt_cpu_high_irqload
			fi
			chmod 444 /sys/devices/system/cpu/cpufreq/policy0/schedutil/*
			chmod 444 $LGP/schedutil/*
		fi
	
	elif grep 'interactive' $AGL; then
		if [ -e $AGL ]; then
			echo 0 > /dev/stune/top-app/schedtune.boost
			echo 90 > /proc/sys/kernel/sched_upmigrate
			echo 100 > /proc/sys/kernel/sched_group_upmigrate
			echo 75 > /proc/sys/kernel/sched_downmigrate
			echo 85 > /proc/sys/kernel/sched_group_downmigrate
			echo 600000 > /proc/sys/kernel/sched_freq_inc_notify
			echo 200000 > /proc/sys/kernel/sched_freq_dec_notify
			echo 15 > /proc/sys/kernel/sched_small_wakee_task_load
			echo 5 > /proc/sys/kernel/sched_init_task_load
			if [ -e /proc/sys/kernel/sched_enable_power_aware ]; then
				echo 1 > /proc/sys/kernel/sched_enable_power_aware
			fi
			echo 1 > /proc/sys/kernel/sched_enable_thread_grouping
			echo 30 > /proc/sys/kernel/sched_big_waker_task_load
			echo 3 > /proc/sys/kernel/sched_window_stats_policy
			echo 5 > /proc/sys/kernel/sched_ravg_hist_size
			if [ -e /proc/sys/kernel/sched_upmigrate_min_nice ]; then
				echo 0 > /proc/sys/kernel/sched_upmigrate_min_nice
			fi
			echo 5 > /proc/sys/kernel/sched_spill_nr_run
			echo 100 > /proc/sys/kernel/sched_spill_load
			echo 1 > /proc/sys/kernel/sched_enable_thread_grouping
			echo 1 > /proc/sys/kernel/sched_restrict_cluster_spill
			if [ -e /proc/sys/kernel/sched_wakeup_load_threshold ]; then
				echo 110 > /proc/sys/kernel/sched_wakeup_load_threshold
			fi
			echo 10 > /proc/sys/kernel/sched_rr_timeslice_ms
			if [ -e "/proc/sys/kernel/sched_enable_power_aware" ]; then
				echo 1 > /proc/sys/kernel/sched_enable_power_aware
			fi
			if [ -e "/proc/sys/kernel/sched_migration_fixup" ]; then
				echo 1 > /proc/sys/kernel/sched_migration_fixup
			fi
			if [ -e "/sys/devices/system/cpu/cpufreq/policy0/interactive/powersave_bias" ]; then
				echo 1 > $LGP/interactive/powersave_bias
			fi
			echo interactive > $LGP/scaling_governor
			chmod 644 /sys/devices/system/cpu/cpufreq/policy0/interactive/*
			chmod 644 $LGP/interactive/*
			echo 80 883200:84 1324800:89 1555200:93 > $LGP/interactive/target_loads
			chmod 444 /sys/devices/system/cpu/cpufreq/policy0/interactive/target_loads
			echo 90000 > $LGP/interactive/timer_slack
			chmod 644 $LGP/interactive/timer_rate
			echo 40000 > $LGP/interactive/timer_rate
			echo 300000 > $LGP/interactive/hispeed_freq
			echo 20000 883200:40000 1478400:60000 > $LGP/interactive/above_hispeed_delay
			echo 400 > $LGP/interactive/go_hispeed_load
			echo 5000 > $LGP/interactive/min_sample_time
			chmod 444 /sys/devices/system/cpu/cpufreq/policy0/interactive/min_sample_time
			chmod 444 $LGP/interactive/hispeed_freq
			echo 0 > $LGP/interactive/max_freq_hysteresis
			echo 1 > $LGP/interactive/fast_ramp_down
			echo 1 > $LGP/interactive/use_sched_load
			echo 0 > $LGP/interactive/boostpulse_duration
			chmod 444 /sys/devices/system/cpu/cpufreq/policy0/interactive/*
			chmod 444 $LGP/interactive/*
		fi
	fi
fi


#Apply settings to big cluster

if [ -d /sys/devices/system/cpu/cpufreq/policy4 ]; then
	if [ -e /sys/devices/system/cpu/cpufreq/policy4 ]; then
		BGP=/sys/devices/system/cpu/cpufreq/policy4
	fi

	AGB=/sys/devices/system/cpu/cpufreq/policy4/scaling_available_governors;

	if grep 'pwrutilx' $AGB; then
		if [ -e $AGB ]; then
			chmod 644 /sys/devices/system/cpu/cpufreq/policy4/pwrutilx/*
			chmod 644 $BGP/pwrutilx/*
			echo pwrutilx > $BGP/scaling_governor
			echo 2000 > $BGP/pwrutilx/up_rate_limit_us
			echo 6000 > $BGP/pwrutilx/down_rate_limit_us
			echo 0 > $BGP/pwrutilx/iowait_boost_enable
			chmod 444 /sys/devices/system/cpu/cpufreq/policy4/pwrutilx/*
			chmod 444 $BGP/pwrutilx/*
		fi
	
	elif grep 'schedutil' $AGB; then
		if [ -e $AGB ]; then
			chmod 644 /sys/devices/system/cpu/cpufreq/policy4/schedutil/*
			chmod 644 $BGP/schedutil/*
			echo schedutil > $BGP/scaling_governor
			echo 2000 > $BGP/schedutil/up_rate_limit_us
			echo 5000 > $BGP/schedutil/down_rate_limit_us
			if [ -e "$BGP/schedutil/iowait_boost_enable" ]; then
				echo 0 > $BGP/schedutil/iowait_boost_enable
			fi
			chmod 444 /sys/devices/system/cpu/cpufreq/policy4/schedutil/*
			chmod 444 $BGP/schedutil/*
		fi
		
	elif grep 'interactive' $AGB; then
		if [ -e $AGB ]; then
			echo interactive > $BGP/scaling_governor
			chmod 644 /sys/devices/system/cpu/cpufreq/policy4/interactive/*
			chmod 644 $BGP/interactive/*
			echo 80 1132800:86 1574400:95 > $BGP/interactive/target_loads
			chmod 444 /sys/devices/system/cpu/cpufreq/policy4/interactive/target_loads
			echo 120000 > $BGP/interactive/timer_slack
			echo 300000 > $BGP/interactive/hispeed_freq
			chmod 644 $BGP/interactive/timer_rate
			echo 60000 > $BGP/interactive/timer_rate
			echo 10000 1132800:40000 1574400:80000 > $BGP/interactive/above_hispeed_delay
			echo 400 > $BGP/interactive/go_hispeed_load
			echo 5000 > $BGP/interactive/min_sample_time
			echo 0 > $BGP/interactive/max_freq_hysteresis
			echo 1 > $BGP/interactive/fast_ramp_down
			echo 1 > $BGP/interactive/use_sched_load
			echo 0 > $BGP/interactive/boostpulse_duration
			chmod 444 /sys/devices/system/cpu/cpufreq/policy4/interactive/*
			chmod 444 $BGP/interactive/*
		fi
	fi
fi



# #Tweak VoxPopuli -- Only on EAS kernels
# if [ -d /dev/voxpopuli/ ]; then
	# VOX_P=/dev/voxpopuli/
	# echo 1 > $VOX_P/enable_interaction_boost	#Main switch
	# echo 0 > $VOX_P/fling_min_boost_duration
	# echo 2500 > $VOX_P/fling_max_boost_duration
	# echo 10 > $VOX_P/fling_boost_topapp
	# echo 940 > $VOX_P/fling_min_freq_big	
	# echo 960 > $VOX_P/fling_min_freq_little
	# echo 200 > $VOX_P/touch_boost_duration
	# echo 5 > $VOX_P/touch_boost_topapp
	# echo 806 > $VOX_P/touch_min_freq_big
	# echo 960 > $VOX_P/touch_min_freq_little
# fi

# #Tweak input boost -- Only Sultanized ROMs
# if [ -e "/sys/kernel/cpu_input_boost" ]; then
	# chmod 644 /sys/kernel/cpu_input_boost/*
	# echo 1 > /sys/kernel/cpu_input_boost/enable
	# echo 66 > /sys/kernel/cpu_input_boost/ib_duration_ms
	# echo 537600 537600 > /sys/kernel/cpu_input_boost/ib_freqs
	# chmod 444 /sys/kernel/cpu_input_boost/*
# fi

# #Tweak cpu boost
if [ -e "/sys/module/cpu_boost" ]; then
	if [ -e "/sys/module/cpu_boost/parameters/input_boost_enabled" ]; then
		chmod 644 /sys/module/cpu_boost/parameters/input_boost_enabled
		echo 1 > /sys/module/cpu_boost/parameters/input_boost_enabled
	fi
	chmod 644 /sys/module/cpu_boost/parameters/input_boost_freq
	if grep 'schedutil' $AGL; then
		echo 0:0 1:0 2:0 3:0 4:0 5:0 6:0 7:0 > /sys/module/cpu_boost/parameters/input_boost_freq
		echo 0 > /sys/module/cpu_boost/parameters/input_boost_ms
	else
		echo 0:1036800 1:0 2:0 3:0 4:0 5:0 6:0 7:0 > /sys/module/cpu_boost/parameters/input_boost_freq
		echo 230 > /sys/module/cpu_boost/parameters/input_boost_ms
	fi
	if [ -e "/sys/module/msm_performance/parameters/touchboost/sched_boost_on_input " ]; then
		echo N > /sys/module/msm_performance/parameters/touchboost/sched_boost_on_input
	fi
fi


#I/0 Tweaks
if [ -d "/sys/block/sda/queue" ]; then
	Q_PATH=/sys/block/sda/queue/
	if grep 'maple' $Q_PATH/scheduler; then
		echo "maple" > $Q_PATH/scheduler
		echo 16 > $Q_PATH/iosched/fifo_batch
		echo 4 > $Q_PATH/iosched/writes_starved
		echo 10 > $Q_PATH/iosched/sleep_latency_multiple
		echo 200 > $Q_PATH/iosched/async_read_expire   ##default values
		echo 500 > $Q_PATH/iosched/async_write_expire   ##default values
		echo 100 > $Q_PATH/iosched/sync_read_expire   ##default values
		echo 350 > $Q_PATH/iosched/sync_write_expire   ##default values
		#echo 5 * HZ > $Q_PATH/iosched/async_read_expire  ##if CONFIG_HZ=1000
		#echo 5 * HZ > $Q_PATH/iosched/async_write_expire  ##if CONFIG_HZ=1000
		#echo HZ / 2 > $Q_PATH/iosched/sync_read_expire  ##if CONFIG_HZ=1000
		#echo HZ / 2 > $Q_PATH/iosched/sync_write_expire  ##if CONFIG_HZ=1000
		#echo 250 > $Q_PATH/iosched/async_read_expire  ##previously used values
		#echo 450 > $Q_PATH/iosched/async_write_expire  ##previously used values
		#echo 350 > $Q_PATH/iosched/sync_read_expire  ##previously used values
		#echo 550 > $Q_PATH/iosched/sync_write_expire  ##previously used values
		# echo 1500 > $Q_PATH/iosched/async_read_expire  ##previously used values, 2nd test
		# echo 1500 > $Q_PATH/iosched/async_write_expire  ##previously used values, 2nd test
		# echo 150 > $Q_PATH/iosched/sync_read_expire  ##previously used values, 2nd test
		# echo 150 > $Q_PATH/iosched/sync_write_expire  ##previously used values, 2nd test
	elif grep 'cfq' $Q_PATH/scheduler; then
		echo "cfq" > $Q_PATH/scheduler
		# echo 1 > $Q_PATH/iosched/back_seek_penalty
		# echo 16384 > $Q_PATH/iosched/back_seek_max
		# echo 120 > $Q_PATH/iosched/fifo_expire_sync
		# echo 250 > $Q_PATH/iosched/fifo_expire_async
		# echo 0 > $Q_PATH/iosched/slice_idle
		# echo 8 > $Q_PATH/iosched/group_idle
		# echo 1 > $Q_PATH/iosched/low_latency
		# echo 10 > $Q_PATH/iosched/quantum
		# echo 40 > $Q_PATH/iosched/slice_async
		# echo 2 > $Q_PATH/iosched/slice_async_rq
		# echo 100 > $Q_PATH/iosched/slice_sync
		# echo 300 > $Q_PATH/iosched/target_latency
	else
		echo "	-Error Code #03"
	fi
	echo 512 > $Q_PATH/read_ahead_kb
	echo 112 > $Q_PATH/nr_requests
	echo 0 > $Q_PATH/add_random
	echo 0 > $Q_PATH/iostats
	echo 1 > $Q_PATH/nomerges
	echo 0 > $Q_PATH/rotational
	echo 1 > $Q_PATH/rq_affinity
fi


#TCP tweaks
echo 1 > /proc/sys/net/ipv4/tcp_low_latency

# #Wakelocks
# if [ -e "/sys/module/bcmdhd/parameters/wlrx_divide" ]; then
	# echo 10 > /sys/module/bcmdhd/parameters/wlrx_divide
# fi
# if [ -e "/sys/module/bcmdhd/parameters/wlctrl_divide" ]; then
	# echo 10 > /sys/module/bcmdhd/parameters/wlctrl_divide
# fi
# if [ -e "/sys/module/wakeup/parameters/enable_bluetooth_timer" ]; then
	# echo Y > /sys/module/wakeup/parameters/enable_bluetooth_timer
# fi
# if [ -e "/sys/module/wakeup/parameters/enable_ipa_ws" ]; then 
	# echo N > /sys/module/wakeup/parameters/enable_ipa_ws
# fi
# if [ -e "/sys/module/wakeup/parameters/enable_netlink_ws" ]; then
	# echo N > /sys/module/wakeup/parameters/enable_netlink_ws
# fi
# if [ -e "/sys/module/wakeup/parameters/enable_netmgr_wl_ws" ]; then
	# echo N > /sys/module/wakeup/parameters/enable_netmgr_wl_ws
# fi
# if [ -e "/sys/module/wakeup/parameters/enable_qcom_rx_wakelock_ws" ]; then 
	# echo N > /sys/module/wakeup/parameters/enable_qcom_rx_wakelock_ws
# fi
# if [ -e "/sys/module/wakeup/parameters/enable_timerfd_ws" ]; then
	# echo N > /sys/module/wakeup/parameters/enable_timerfd_ws
# fi
# if [ -e "/sys/module/wakeup/parameters/enable_wlan_extscan_wl_ws" ]; then 
	# echo N > /sys/module/wakeup/parameters/enable_wlan_extscan_wl_ws
# fi
# if [ -e "/sys/module/wakeup/parameters/enable_wlan_wow_wl_ws" ]; then 
	# echo N > /sys/module/wakeup/parameters/enable_wlan_wow_wl_ws
# fi
# if [ -e "/sys/module/wakeup/parameters/enable_wlan_ws" ]; then
	# echo N > /sys/module/wakeup/parameters/enable_wlan_ws
# fi
# if [ -e "/sys/module/wakeup/parameters/enable_netmgr_wl_ws" ]; then
	# echo N > /sys/module/wakeup/parameters/enable_netmgr_wl_ws
# fi
# if [ -e "/sys/module/wakeup/parameters/enable_wlan_wow_wl_ws" ]; then
	# echo N > /sys/module/wakeup/parameters/enable_wlan_wow_wl_ws
# fi
# if [ -e "/sys/module/wakeup/parameters/enable_wlan_ipa_ws" ]; then
	# echo N > /sys/module/wakeup/parameters/enable_wlan_ipa_ws
# fi
# if [ -e "/sys/module/wakeup/parameters/enable_wlan_pno_wl_ws" ]; then
	# echo N > /sys/module/wakeup/parameters/enable_wlan_pno_wl_ws
# fi
# if [ -e "/sys/module/wakeup/parameters/enable_wcnss_filter_lock_ws" ]; then
	# echo N > /sys/module/wakeup/parameters/enable_wcnss_filter_lock_ws
# fi

# #GPU
echo "msm-adreno-tz" > /sys/devices/soc/5000000.qcom,kgsl-3d0/devfreq/5000000.qcom,kgsl-3d0/governor
GPU_FREQ=/sys/devices/soc/5000000.qcom,kgsl-3d0/devfreq/5000000.qcom,kgsl-3d0/max_freq
av_freq=/sys/devices/soc/5000000.qcom,kgsl-3d0/devfreq/5000000.qcom,kgsl-3d0/available_frequencies
if [ -e $GPU_FREQ ]; then
	if grep '710000000' $av_freq; then
		chmod 644 /sys/devices/soc/5000000.qcom,kgsl-3d0/devfreq/5000000.qcom,kgsl-3d0/max_freq
		echo 670000000 > /sys/devices/soc/5000000.qcom,kgsl-3d0/devfreq/5000000.qcom,kgsl-3d0/max_freq
		chmod 444 /sys/devices/soc/5000000.qcom,kgsl-3d0/devfreq/5000000.qcom,kgsl-3d0/max_freq
	else
	fi
	if grep '180000000' $av_freq; then
		chmod 644 /sys/devices/soc/5000000.qcom,kgsl-3d0/devfreq/5000000.qcom,kgsl-3d0/target_freq
		echo 257000000 > /sys/devices/soc/5000000.qcom,kgsl-3d0/devfreq/5000000.qcom,kgsl-3d0/target_freq
		echo 180000000 > /sys/devices/soc/5000000.qcom,kgsl-3d0/devfreq/5000000.qcom,kgsl-3d0/min_freq
		chmod 444 /sys/devices/soc/5000000.qcom,kgsl-3d0/devfreq/5000000.qcom,kgsl-3d0/target_freq
	else
		chmod 644 /sys/devices/soc/5000000.qcom,kgsl-3d0/devfreq/5000000.qcom,kgsl-3d0/target_freq
		echo 257000000 > /sys/devices/soc/5000000.qcom,kgsl-3d0/devfreq/5000000.qcom,kgsl-3d0/target_freq
		echo 257000000 > /sys/devices/soc/5000000.qcom,kgsl-3d0/devfreq/5000000.qcom,kgsl-3d0/min_freq
		chmod 444 /sys/devices/soc/5000000.qcom,kgsl-3d0/devfreq/5000000.qcom,kgsl-3d0/target_freq
	fi
	if [ -e "/sys/devices/soc/5000000.qcom,kgsl-3d0/devfreq/5000000.qcom,kgsl-3d0/adrenoboost" ]; then
		chmod 644 /sys/devices/soc/5000000.qcom,kgsl-3d0/devfreq/5000000.qcom,kgsl-3d0/adrenoboost
		echo 0 > /sys/devices/soc/5000000.qcom,kgsl-3d0/devfreq/5000000.qcom,kgsl-3d0/adrenoboost
	fi
fi



## Vibration
if [ -d "/sys/class/timed_output/vibrator/vtg_level" ]; then
	chmod 644 /sys/class/timed_output/vibrator/vtg_level
	echo 812 > /sys/class/timed_output/vibrator/vtg_level
fi

# # #File system
# echo 25 > /proc/sys/fs/lease-break-time

#LMK
if [ -e "/sys/module/lowmemorykiller/parameters/enable_adaptive_lmk" ]; then 
	chmod 664 /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
	chown root /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
	echo 1 > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
	chmod 444 /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
fi
if [ -e "/sys/module/lowmemorykiller/parameters/minfree" ]; then
	echo "18432,23040,27648,32256,73728,120960" > /sys/module/lowmemorykiller/parameters/minfree
fi
chmod 644 /sys/module/lowmemorykiller/parameters/debug_level
echo 0 > /sys/module/lowmemorykiller/parameters/debug_level
chmod 444 /sys/module/lowmemorykiller/parameters/debug_level

# # Enable bus-dcvs
# for cpubw in /sys/class/devfreq/*qcom,cpubw* ; do
    # echo "bw_hwmon" > $cpubw/governor
    # echo 50 > $cpubw/polling_interval
    # echo 1525 > $cpubw/min_freq
	# echo "1525 5195 11863 13763" > $cpubw/bw_hwmon/mbps_zones
    # echo 4 > $cpubw/bw_hwmon/sample_ms
    # echo 34 > $cpubw/bw_hwmon/io_percent
    # echo 20 > $cpubw/bw_hwmon/hist_memory
    # echo 10 > $cpubw/bw_hwmon/hyst_length
    # echo 0 > $cpubw/bw_hwmon/low_power_ceil_mbps
    # echo 34 > $cpubw/bw_hwmon/low_power_io_percent
    # echo 20 > $cpubw/bw_hwmon/low_power_delay
    # echo 0 > $cpubw/bw_hwmon/guard_band_mbps
    # echo 250 > $cpubw/bw_hwmon/up_scale
    # echo 1600 > $cpubw/bw_hwmon/idle_mbps
# done
# for memlat in /sys/class/devfreq/*qcom,memlat-cpu* ; do
    # echo "mem_latency" > $memlat/governor
    # echo 20 > $memlat/polling_interval
# done
# echo "cpufreq" > /sys/class/devfreq/soc:qcom,mincpubw/governor

#Virtual Memory
echo 400 > /proc/sys/vm/dirty_expire_centisecs
echo 1000 > /proc/sys/vm/dirty_writeback_centisecs
echo 0 > /proc/sys/vm/oom_kill_allocating_task
echo 2 > /proc/sys/vm/page-cluster
echo 20 > /proc/sys/vm/swappiness
echo 100 > /proc/sys/vm/vfs_cache_pressure
echo 20 > /proc/sys/vm/dirty_ratio
echo 10 > /proc/sys/vm/dirty_background_ratio
echo 1 > /proc/sys/vm/overcommit_memory
echo 25 > /proc/sys/vm/overcommit_ratio
echo 11093 > /proc/sys/vm/min_free_kbytes
echo 32 > /proc/sys/kernel/random/read_wakeup_threshold
echo 896 > /proc/sys/kernel/random/write_wakeup_threshold

#Turn off some cores while screen off
if grep 'schedutil' $AGL; then
	chmod 664 /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
	chmod 664 /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
	chmod 664 /sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq
	chmod 664 /sys/devices/system/cpu/cpufreq/policy4/scaling_min_freq
	echo 1747200 > /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
	echo $little_min_value > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
	echo 1728000 > /sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq
	echo $big_min_value > /sys/devices/system/cpu/cpufreq/policy4/scaling_min_freq
	chmod 644 /sys/devices/system/cpu/online
	echo "0-7" > /sys/devices/system/cpu/online
	chmod 444 /sys/devices/system/cpu/online
	chmod 644 /sys/devices/system/cpu/offline
	echo "" > /sys/devices/system/cpu/offline
	chmod 444 /sys/devices/system/cpu/offline
	chmod 644 /sys/devices/system/cpu/cpufreq/policy0/affected_cpus
	echo "0 1 2 3" > /sys/devices/system/cpu/cpufreq/policy0/affected_cpus
	chmod 444 /sys/devices/system/cpu/cpufreq/policy0/affected_cpus
	chmod 644 /sys/devices/system/cpu/cpufreq/policy4/affected_cpus
	echo "4 5 6 7" > /sys/devices/system/cpu/cpufreq/policy4/affected_cpus
	chmod 444 /sys/devices/system/cpu/cpufreq/policy4/affected_cpus
	echo 1 > /sys/devices/system/cpu/cpu0/online
	echo 1 > /sys/devices/system/cpu/cpu1/online
	echo 1 > /sys/devices/system/cpu/cpu2/online
	echo 1 > /sys/devices/system/cpu/cpu3/online
	echo 1 > /sys/devices/system/cpu/cpu4/online
	echo 1 > /sys/devices/system/cpu/cpu5/online
	echo 1 > /sys/devices/system/cpu/cpu6/online
	echo 1 > /sys/devices/system/cpu/cpu7/online
else
	chmod 664 /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
	chmod 664 /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
	chmod 664 /sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq
	chmod 664 /sys/devices/system/cpu/cpufreq/policy4/scaling_min_freq
	echo 1747200 > /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
	echo $little_min_value > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
	echo 1728000 > /sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq
	echo $big_min_value > /sys/devices/system/cpu/cpufreq/policy4/scaling_min_freq
	chmod 644 /sys/devices/system/cpu/online
	echo "0-7" > /sys/devices/system/cpu/online
	chmod 444 /sys/devices/system/cpu/online
	chmod 644 /sys/devices/system/cpu/offline
	echo "" > /sys/devices/system/cpu/offline
	chmod 444 /sys/devices/system/cpu/offline
	chmod 644 /sys/devices/system/cpu/cpufreq/policy0/affected_cpus
	echo "0 1 2 3" > /sys/devices/system/cpu/cpufreq/policy0/affected_cpus
	chmod 444 /sys/devices/system/cpu/cpufreq/policy0/affected_cpus
	chmod 644 /sys/devices/system/cpu/cpufreq/policy4/affected_cpus
	echo "4 5 6 7" > /sys/devices/system/cpu/cpufreq/policy4/affected_cpus
	chmod 444 /sys/devices/system/cpu/cpufreq/policy4/affected_cpus
	echo 1 > /sys/devices/system/cpu/cpu0/online
	echo 1 > /sys/devices/system/cpu/cpu1/online
	echo 1 > /sys/devices/system/cpu/cpu2/online
	echo 1 > /sys/devices/system/cpu/cpu3/online
	echo 1 > /sys/devices/system/cpu/cpu4/online
	echo 1 > /sys/devices/system/cpu/cpu5/online
	echo 1 > /sys/devices/system/cpu/cpu6/online
	echo 1 > /sys/devices/system/cpu/cpu7/online
fi

#Enable Core Control and Disable MSM Thermal Throttling allowing for longer sustained performance
if [ -e "/sys/module/msm_thermal/core_control/enabled" ]; then
# re-enable thermal hotplug
	# re-enable thermal and BCL hotplug
	if [ -e "/sys/devices/soc/soc:qcom,bcl/mode" ]; then
		echo -n disable > /sys/devices/soc/soc:qcom,bcl/mode
		echo $bcl_hotplug_mask > /sys/devices/soc/soc:qcom,bcl/hotplug_mask
		echo $bcl_soc_hotplug_mask > /sys/devices/soc/soc:qcom,bcl/hotplug_soc_mask
		echo -n enable > /sys/devices/soc/soc:qcom,bcl/mode
	fi
	echo N > /sys/module/msm_thermal/parameters/enabled
	echo 0 > /sys/module/msm_thermal/vdd_restriction/enabled
	echo 1 > /sys/module/msm_thermal/core_control/enabled
fi



cdate=$(date)

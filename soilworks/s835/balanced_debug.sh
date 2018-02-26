#!/system/bin/sh
#Original author: Alcolawl
#Original script By: RogerF81 + adanteon
#Settings By: RogerF81
#Device: OnePlus 5
#Codename: SoilWork UNIFIED
#SoC: Snapdragon 835
#Last Updated: 16/01/2018
#Credits: @Alcolawl @soniCron @Asiier @Freak07 @Mostafa Wael @Senthil360 @TotallyAnxious @RenderBroken @ZeroInfinity @Kyuubi10 @ivicask @RogerF81 @joshuous @boyd95 @ZeroKool76 @adanteon
codename=Soilwork
stype=balanced
version=V3.0
cdate=$(date)
DLL=/storage/emulated/0/soilwork_initiallog.txt

#Initializing log
echo "$cdate" > $DLL
echo "$codename $stype" >> $DLL
echo "*Searching CPU frequencies" >> $DLL
#Disable BCL
if [ -e "/sys/devices/soc/soc:qcom,bcl/mode" ]; then
	echo "*Disabling BCL" >> $DLL
	chmod 644 /sys/devices/soc/soc:qcom,bcl/mode
	echo -n disable > /sys/devices/soc/soc:qcom,bcl/mode
fi

#Turn off core_control
echo "	+Disabling core_control temporarily" >> $DLL
echo 0 > /sys/module/msm_thermal/core_control/enabled

##Configuring stune & cpuset
if [ -d "/dev/stune" ]; then
	echo "Configuring stune" >> $DLL
	echo 1 > /dev/stune/schedtune.sched_boost_enabled
	echo 0 > /dev/stune/background/schedtune.boost
	echo 0 > /dev/stune/foreground/schedtune.boost
	echo 0 > /dev/stune/schedtune.prefer_idle
	echo 0 > /proc/sys/kernel/sched_child_runs_first
	echo 0 > /dev/stune/background/schedtune.prefer_idle
	echo 1 > /dev/stune/foreground/schedtune.prefer_idle
	echo 1 > /dev/stune/top-app/schedtune.prefer_idle
	if [ -e "/proc/sys/kernel/sched_boost" ]; then
		echo 0 > /proc/sys/kernel/sched_boost
	fi
fi
echo 48 > /proc/sys/kernel/sched_nr_migrate
echo 0 > /proc/sys/kernel/sched_initial_task_util

if [ -d "/dev/cpuset" ]; then
	echo "Configuring cpuset" >> $DLL
	echo 0-1 > /dev/cpuset/background/cpus
	echo 0-1 > /dev/cpuset/system-background/cpus
fi

if [ -e "/proc/sys/kernel/sched_autogroup_enabled" ]; then
	echo 0 > /proc/sys/kernel/sched_autogroup_enabled
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
echo "*Turning on cores" >> $DLL
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
echo "*Applying LITTLE settings" >> $DLL
echo "	+Searching available governors" >> $DLL

if [ -d /sys/devices/system/cpu/cpufreq/policy0 ]; then
	if [ -e /sys/devices/system/cpu/cpufreq/policy0 ]; then
		LGP=/sys/devices/system/cpu/cpufreq/policy0
	fi

	AGL=/sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors;

	if grep 'pwrutilx' $AGL; then
		if [ -e $AGL ]; then
			echo "	+Applying & tuning pwrutilx" >> $DLL
			chmod 644 /sys/devices/system/cpu/cpufreq/policy0/pwrutilx/*
			chmod 644 $LGP/pwrutilx/*
			echo pwrutilx > $LGP/scaling_governor
			echo 500 > $LGP/pwrutilx/up_rate_limit_us
			echo 20000 > $LGP/pwrutilx/down_rate_limit_us
			echo 1 > $LGP/pwrutilx/iowait_boost_enable
			echo 18 > /sys/module/cpu_boost/parameters/dynamic_stune_boost
			echo 3 > /dev/stune/top-app/schedtune.boost
			echo 1 > /proc/sys/kernel/sched_cstate_aware
			if [ -e "/proc/sys/kernel/sched_use_walt_task_util" ]; then
				echo 1 > /proc/sys/kernel/sched_use_walt_task_util
				echo 1 > /proc/sys/kernel/sched_use_walt_cpu_util
				echo 10 > /proc/sys/kernel/sched_walt_init_task_load_pct
				echo 10000000 > /proc/sys/kernel/sched_walt_cpu_high_irqload
			fi
			chmod 444 /sys/devices/system/cpu/cpufreq/policy0/pwrutilx/*
			chmod 444 $LGP/pwrutilx/*
		fi
		echo "	+Tuning finished for pwrutilx" >> $DLL
	
	elif grep 'schedutil' $AGL; then
		if [ -e $AGL ]; then
			echo "	+Applying & tuning schedutil" >> $DLL
			chmod 644 /sys/devices/system/cpu/cpufreq/policy0/schedutil/*
			chmod 644 $LGP/schedutil/*
			echo schedutil > $LGP/scaling_governor
			echo 500 > $LGP/schedutil/up_rate_limit_us
			echo 10000 > $LGP/schedutil/down_rate_limit_us
			if [ -e "$LGP/schedutil/iowait_boost_enable" ]; then
				echo 0 > $LGP/schedutil/iowait_boost_enable
			fi
			echo 15 > /sys/module/cpu_boost/parameters/dynamic_stune_boost
			echo 1 > /dev/stune/top-app/schedtune.boost
			echo 1 > /proc/sys/kernel/sched_cstate_aware
			if [ -e "/proc/sys/kernel/sched_use_walt_task_util" ]; then
				echo 1 > /proc/sys/kernel/sched_use_walt_task_util
				echo 1 > /proc/sys/kernel/sched_use_walt_cpu_util
				echo 10 > /proc/sys/kernel/sched_walt_init_task_load_pct
				echo 10000000 > /proc/sys/kernel/sched_walt_cpu_high_irqload
			fi
			chmod 444 /sys/devices/system/cpu/cpufreq/policy0/schedutil/*
			chmod 444 $LGP/schedutil/*
		fi
		echo "	+Tuning finished for schedutil" >> $DLL
	
	elif grep 'interactive' $AGL; then
		if [ -e $AGL ]; then
			echo 1 > /dev/stune/top-app/schedtune.boost
			echo 85 > /proc/sys/kernel/sched_upmigrate
			echo 95 > /proc/sys/kernel/sched_group_upmigrate
			echo 65 > /proc/sys/kernel/sched_downmigrate
			echo 75 > /proc/sys/kernel/sched_group_downmigrate
			echo 10 > /proc/sys/kernel/sched_small_wakee_task_load
			echo 10 > /proc/sys/kernel/sched_init_task_load
			if [ -e /proc/sys/kernel/sched_enable_power_aware ]; then
				echo 1 > /proc/sys/kernel/sched_enable_power_aware
			fi
			echo 1 > /proc/sys/kernel/sched_enable_thread_grouping
			echo 30 > /proc/sys/kernel/sched_big_waker_task_load
			echo 2 > /proc/sys/kernel/sched_window_stats_policy
			echo 5 > /proc/sys/kernel/sched_ravg_hist_size
			if [ -e /proc/sys/kernel/sched_upmigrate_min_nice ]; then
				echo 9 > /proc/sys/kernel/sched_upmigrate_min_nice
			fi
			echo 5 > /proc/sys/kernel/sched_spill_nr_run
			echo 95 > /proc/sys/kernel/sched_spill_load
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
			if grep 'blu_active' $AGL; then
				if [ -e $AGL ]; then
					echo "	+Applying & tuning blu_active" >> $DLL
					echo blu_active > $LGP/scaling_governor
					chmod 644 /sys/devices/system/cpu/cpufreq/policy0/blu_active/*
					chmod 644 $LGP/blu_active/*
					echo 75 595200:79 883200:83 1324800:85 1555200:89 > $LGP/blu_active/target_loads
					chmod 444 /sys/devices/system/cpu/cpufreq/policy0/blu_active/target_loads
					echo 90000 > $LGP/blu_active/timer_slack
					chmod 644 $LGP/blu_active/timer_rate
					echo 20000 > $LGP/blu_active/timer_rate
					echo 1248000 > $LGP/blu_active/hispeed_freq
					echo 0 672000:20000 1401600:40000 > $LGP/blu_active/above_hispeed_delay
					echo 400 > $LGP/blu_active/go_hispeed_load
					echo 10000 > $LGP/blu_active/min_sample_time
					echo 1 > $LGP/blu_active/fastlane
					echo 50 > $LGP/blu_active/fastlane_threshold
					chmod 444 /sys/devices/system/cpu/cpufreq/policy0/blu_active/*
					chmod 444 $LGP/blu_active/*
				fi
				echo "	+Tuning finished for blu_active" >> $DLL
				
			else
				if [ -e $AGL ]; then
					echo "	+Applying & tuning interactive" >> $DLL
					echo interactive > $LGP/scaling_governor
					chmod 644 /sys/devices/system/cpu/cpufreq/policy0/interactive/*
					chmod 644 $LGP/interactive/*
					echo 75 595200:79 883200:83 1324800:85 1555200:89 > $LGP/interactive/target_loads
					chmod 444 /sys/devices/system/cpu/cpufreq/policy0/interactive/target_loads
					echo 90000 > $LGP/interactive/timer_slack
					chmod 644 $LGP/interactive/timer_rate
					echo 20000 > $LGP/interactive/timer_rate
					echo 1248000 > $LGP/interactive/hispeed_freq
					echo 0 672000:20000 1401600:40000 > $LGP/interactive/above_hispeed_delay
					echo 400 > $LGP/interactive/go_hispeed_load
					echo 10000 > $LGP/interactive/min_sample_time
					chmod 444 /sys/devices/system/cpu/cpufreq/policy0/interactive/min_sample_time
					chmod 444 $LGP/interactive/hispeed_freq
					echo 20000 > $LGP/interactive/max_freq_hysteresis
					echo 1 > $LGP/interactive/ignore_hispeed_on_notif
					echo 0 > $LGP/interactive/boost
					echo 0 > $LGP/interactive/fast_ramp_down
					echo 0 > $LGP/interactive/align_windows
					echo 1 > $LGP/interactive/use_migration_notif
					echo 1 > $LGP/interactive/use_sched_load
					echo 30000 > $LGP/interactive/boostpulse_duration
					echo 0 > $LGP/interactive/io_is_busy
					echo 0 > $LGP/interactive/enable_prediction
					chmod 444 /sys/devices/system/cpu/cpufreq/policy0/interactive/*
					chmod 444 $LGP/interactive/*
					echo "	+Tuning finished for interactive" >> $DLL
				fi
			fi
		fi
	else
		echo "	-The governor's path is wrong or mod is incompatible" >> $DLL
		echo "	-Error Code #01" >> $DLL
	fi
fi

echo "	*LITTLE settings finished" >> $DLL

#Apply settings to big cluster
echo "*Applying big settings" >> $DLL
echo "	+Searching available governors" >> $DLL

if [ -d /sys/devices/system/cpu/cpufreq/policy4 ]; then
	if [ -e /sys/devices/system/cpu/cpufreq/policy4 ]; then
		BGP=/sys/devices/system/cpu/cpufreq/policy4
	fi

	AGB=/sys/devices/system/cpu/cpufreq/policy4/scaling_available_governors;

	if grep 'pwrutilx' $AGB; then
		if [ -e $AGB ]; then
			echo "	+Applying pwrutilx" >> $DLL
			chmod 644 /sys/devices/system/cpu/cpufreq/policy4/pwrutilx/*
			chmod 644 $BGP/pwrutilx/*
			echo pwrutilx > $BGP/scaling_governor
			echo 1000 > $BGP/pwrutilx/up_rate_limit_us
			echo 10000 > $BGP/pwrutilx/down_rate_limit_us
			echo 1 > $BGP/pwrutilx/iowait_boost_enable
			chmod 444 /sys/devices/system/cpu/cpufreq/policy4/pwrutilx/*
			chmod 444 $BGP/pwrutilx/*
		fi
		echo "	+Tuning finished for pwrutilx" >> $DLL

	elif grep 'schedutil' $AGB; then
		if [ -e $AGB ]; then
			echo "	+Applying schedutil" >> $DLL
			chmod 644 /sys/devices/system/cpu/cpufreq/policy4/schedutil/*
			chmod 644 $BGP/schedutil/*
			echo schedutil > $BGP/scaling_governor
			echo 1000 > $BGP/schedutil/up_rate_limit_us
			echo 8000 > $BGP/schedutil/down_rate_limit_us
			if [ -e "$BGP/schedutil/iowait_boost_enable" ]; then
				echo 0 > $BGP/schedutil/iowait_boost_enable
			fi
			chmod 444 /sys/devices/system/cpu/cpufreq/policy4/schedutil/*
			chmod 444 $BGP/schedutil/*
		fi
		echo "	+Tuning finished for schedutil" >> $DLL
		
	elif grep 'blu_active' $AGB; then
		if [ -e $AGB ]; then
			echo "	Applying & tuning blu_active" >> $DLL
			echo blu_active > $BGP/scaling_governor
			chmod 644 /sys/devices/system/cpu/cpufreq/policy4/blu_active/*
			chmod 644 $BGP/blu_active/*
			echo 75 902400:81 1132800:86 1881600:91 2323200:95 > $BGP/blu_active/target_loads
			chmod 444 /sys/devices/system/cpu/cpufreq/policy4/blu_active/target_loads
			echo 90000 > $BGP/blu_active/timer_slack
			echo 2361600 > $BGP/blu_active/hispeed_freq
			chmod 644 $BGP/blu_active/timer_rate
			echo 20000 > $BGP/blu_active/timer_rate
			echo 0 > $BGP/blu_active/above_hispeed_delay
			echo 400 > $BGP/blu_active/go_hispeed_load
			echo 10000 > $BGP/blu_active/min_sample_time
			echo 1 > $BGP/blu_active/fastlane
			echo 60 > $BGP/blu_active/fastlane_threshold
			chmod 444 /sys/devices/system/cpu/cpufreq/policy4/blu_active/*
			chmod 444 $BGP/blu_active/*
			echo "	+Tuning finished for blu_active" >> $DLL
		fi

	elif grep 'interactive' $AGB; then
		if [ -e $AGB ]; then
			echo "	Applying & tuning interactive" >> $DLL
			echo interactive > $BGP/scaling_governor
			chmod 644 /sys/devices/system/cpu/cpufreq/policy4/interactive/*
			chmod 644 $BGP/interactive/*
			echo 75 902400:81 1132800:86 1881600:91 2323200:95 > $BGP/interactive/target_loads
			chmod 444 /sys/devices/system/cpu/cpufreq/policy4/interactive/target_loads
			echo 90000 > $BGP/interactive/timer_slack
			echo 1574400 > $BGP/interactive/hispeed_freq
			chmod 644 $BGP/interactive/timer_rate
			echo 20000 > $BGP/interactive/timer_rate
			echo 0 902400:20000 1881600:40000 > $BGP/interactive/above_hispeed_delay
			echo 400 > $BGP/interactive/go_hispeed_load
			echo 10000 > $BGP/interactive/min_sample_time
			chmod 444 /sys/devices/system/cpu/cpufreq/policy4/interactive/min_sample_time
			chmod 444 $BGP/interactive/hispeed_freq
			echo 20000 > $BGP/interactive/max_freq_hysteresis
			echo 1 > $BGP/interactive/ignore_hispeed_on_notif
			echo 0 > $BGP/interactive/boost
			echo 0 > $BGP/interactive/fast_ramp_down
			echo 0 > $BGP/interactive/align_windows
			echo 1 > $BGP/interactive/use_migration_notif
			echo 1 > $BGP/interactive/use_sched_load
			echo 30000 > $BGP/interactive/boostpulse_duration
			echo 0 > $BGP/interactive/io_is_busy
			echo 0 > $BGP/interactive/enable_prediction
			chmod 444 /sys/devices/system/cpu/cpufreq/policy4/interactive/*
			chmod 444 $BGP/interactive/*
			echo "	+Tuning finished for interactive" >> $DLL
		fi
	else
		echo "	-The governor's path is wrong or mod is incompatible" >> $DLL
		echo "	-Error Code #02" >> $DLL
	fi
fi

echo "	*big settings finished" >> $DLL


# # Turn on core_ctl module and tune parameters if kernel has core_ctl module
# if [ -e "/sys/devices/system/cpu/cpu4/core_ctl" ]; then
	# echo 0 > /sys/devices/system/cpu/cpu0/core_ctl/is_big_cluster
	# echo 4 > /sys/devices/system/cpu/cpu0/core_ctl/min_cpus
	# echo 4 > /sys/devices/system/cpu/cpu0/core_ctl/max_cpus
	# echo 1 > /sys/devices/system/cpu/cpu4/core_ctl/is_big_cluster
	# echo "55 55 55 55" > /sys/devices/system/cpu/cpu4/core_ctl/busy_down_thres
	# echo "80 80 80 80" > /sys/devices/system/cpu/cpu4/core_ctl/busy_up_thres
	# echo 2 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
	# echo 4 > /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
# fi

# #Tweak VoxPopuli -- Only on EAS kernels
# if [ -d /dev/voxpopuli/ ]; then
	# echo "*Tweaking Vox Populi PowerHal" >> $DLL
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
	# echo "*Tweaking input boost" >> $dll
	# chmod 644 /sys/kernel/cpu_input_boost/*
	# echo 1 > /sys/kernel/cpu_input_boost/enable
	# echo 66 > /sys/kernel/cpu_input_boost/ib_duration_ms
	# echo 537600 537600 > /sys/kernel/cpu_input_boost/ib_freqs
	# chmod 444 /sys/kernel/cpu_input_boost/*
# fi

# #Tweak cpu boost
if [ -e "/sys/module/cpu_boost" ]; then
	echo "*Tweaking CPU Boost" >> $DLL
	if [ -e "/sys/module/cpu_boost/parameters/input_boost_enabled" ]; then
		chmod 644 /sys/module/cpu_boost/parameters/input_boost_enabled
		echo 1 > /sys/module/cpu_boost/parameters/input_boost_enabled
	fi
	chmod 644 /sys/module/cpu_boost/parameters/input_boost_freq
	echo 0:1036800 1:0 2:0 3:0 4:0 5:0 6:0 7:0 > /sys/module/cpu_boost/parameters/input_boost_freq
	chmod 644 /sys/module/cpu_boost/parameters/input_boost_ms
	echo 750 > /sys/module/cpu_boost/parameters/input_boost_ms
	if [ -e "/sys/module/msm_performance/parameters/touchboost/sched_boost_on_input " ]; then
		echo N > /sys/module/msm_performance/parameters/touchboost/sched_boost_on_input
	fi
fi


#I/0 Tweaks
if [ -d "/sys/block/sda/queue" ]; then
	echo "*Applying I/O tweaks" >> $DLL
	Q_PATH=/sys/block/sda/queue/
	if grep 'cfq' $Q_PATH/scheduler; then
		echo "cfq" > $Q_PATH/scheduler
		echo "	+Using cfq with tuned values" >> $DLL
	else
		echo "	-Something went wrong while changing I/O Scheduler." >> $DLL
		echo "	-Error Code #03"
	fi
	echo 1024 > $Q_PATH/read_ahead_kb
	echo 128 > $Q_PATH/nr_requests
	echo 0 > $Q_PATH/add_random
	echo 0 > $Q_PATH/iostats
	echo 1 > $Q_PATH/nomerges
	echo 0 > $Q_PATH/rotational
	echo 1 > $Q_PATH/rq_affinity
fi

echo "	*Finished tuning I/O scheduler" >> $DLL

#TCP tweaks
echo "*Tuning TCP" >> $DLL
echo 1 > /proc/sys/net/ipv4/tcp_low_latency
echo "	*Finished tuning TCP" >> $DLL

# #Wakelocks
# echo "*Blocking wakelocks" >> $DLL
# if [ -e "/sys/module/bcmdhd/parameters/wlrx_divide" ]; then
	# echo 4 > /sys/module/bcmdhd/parameters/wlrx_divide
# fi
# if [ -e "/sys/module/bcmdhd/parameters/wlctrl_divide" ]; then
	# echo 4 > /sys/module/bcmdhd/parameters/wlctrl_divide
# fi
# if [ -e "/sys/module/wakeup/parameters/enable_bluetooth_timer" ]; then
	# echo Y > /sys/module/wakeup/parameters/enable_bluetooth_timer
# fi
# if [ -e "/sys/module/wakeup/parameters/enable_ipa_ws" ]; then
	# echo N > /sys/module/wakeup/parameters/enable_ipa_ws
# fi
# if [ -e "/sys/module/wakeup/parameters/enable_netlink_ws" ]; then
	# echo Y > /sys/module/wakeup/parameters/enable_netlink_ws
# fi
# if [ -e "/sys/module/wakeup/parameters/enable_netmgr_wl_ws" ]; then
	# echo Y > /sys/module/wakeup/parameters/enable_netmgr_wl_ws
# fi
# if [ -e "/sys/module/wakeup/parameters/enable_qcom_rx_wakelock_ws" ]; then
	# echo N > /sys/module/wakeup/parameters/enable_qcom_rx_wakelock_ws
# fi
# if [ -e "/sys/module/wakeup/parameters/enable_timerfd_ws" ]; then
	# echo Y > /sys/module/wakeup/parameters/enable_timerfd_ws
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

#GPU
echo "msm-adreno-tz" > /sys/devices/soc/5000000.qcom,kgsl-3d0/devfreq/5000000.qcom,kgsl-3d0/governor
GPU_FREQ=/sys/devices/soc/5000000.qcom,kgsl-3d0/devfreq/5000000.qcom,kgsl-3d0/max_freq
av_freq=/sys/devices/soc/5000000.qcom,kgsl-3d0/devfreq/5000000.qcom,kgsl-3d0/available_frequencies
if [ -e $GPU_FREQ ]; then
	echo "*Applying GPU tweaks" >> $DLL
	if grep '710000000' $av_freq; then
		chmod 644 /sys/devices/soc/5000000.qcom,kgsl-3d0/devfreq/5000000.qcom,kgsl-3d0/max_freq
		echo 710000000 > /sys/devices/soc/5000000.qcom,kgsl-3d0/devfreq/5000000.qcom,kgsl-3d0/max_freq
		chmod 444 /sys/devices/soc/5000000.qcom,kgsl-3d0/devfreq/5000000.qcom,kgsl-3d0/max_freq
	else
		echo "Patoka! - Banana?" >> $DLL
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
		echo 1 > /sys/devices/soc/5000000.qcom,kgsl-3d0/devfreq/5000000.qcom,kgsl-3d0/adrenoboost
	fi
	echo "	+GPU tuned" >> $DLL
fi

echo "	*GPU tweaks finished" >> $DLL

echo "*Applying minor tweaks" >> $DLL

## Vibration
if [ -d "/sys/class/timed_output/vibrator/vtg_level" ]; then
	chmod 644 /sys/class/timed_output/vibrator/vtg_level
	echo 1740 > /sys/class/timed_output/vibrator/vtg_level
fi

# # #File system
# echo "	+File system tweaks" >> $DLL
# echo 45 > /proc/sys/fs/lease-break-time

##LMK
if [ -e "/sys/module/lowmemorykiller/parameters/enable_adaptive_lmk" ]; then
	chmod 664 /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
	chown root /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
	echo 0 > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
	chmod 444 /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
fi
if [ -e "/sys/module/lowmemorykiller/parameters/minfree" ]; then
	echo "18432,23040,27648,32256,55296,80640" > /sys/module/lowmemorykiller/parameters/minfree
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
    # echo 10 > $memlat/polling_interval
# done
# echo "cpufreq" > /sys/class/devfreq/soc:qcom,mincpubw/governor

#Virtual Memory
echo "	+Virtual memory tweaks" >> $DLL
echo 200 > /proc/sys/vm/dirty_expire_centisecs
echo 300 > /proc/sys/vm/dirty_writeback_centisecs
echo 0 > /proc/sys/vm/oom_kill_allocating_task
echo 3 > /proc/sys/vm/page-cluster
echo 0 > /proc/sys/vm/swappiness
echo 60 > /proc/sys/vm/vfs_cache_pressure
echo 40 > /proc/sys/vm/dirty_ratio
echo 20 > /proc/sys/vm/dirty_background_ratio
echo 1 > /proc/sys/vm/overcommit_memory
echo 10 > /proc/sys/vm/overcommit_ratio
echo 41943 > /proc/sys/vm/min_free_kbytes
echo 64 > /proc/sys/kernel/random/read_wakeup_threshold
echo 896 > /proc/sys/kernel/random/write_wakeup_threshold

#Turn on cores
echo "*Turning on all cores" >> $DLL
if grep 'schedutil' $AGL; then
	chmod 664 /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
	chmod 664 /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
	chmod 664 /sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq
	chmod 664 /sys/devices/system/cpu/cpufreq/policy4/scaling_min_freq
	echo $little_max_value > /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
	echo $little_min_value > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
	echo 2361600 > /sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq
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
	echo $little_max_value > /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
	echo $little_min_value > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
	echo 2361600 > /sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq
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
echo "	+Re-enable core_control and disable msm_thermal" >> $DLL
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

echo "	*Minor tweaks applied" >> $DLL

echo "#####   COMPLETED    #####" >> $DLL

cdate=$(date)
echo "$cdate" >> $DLL

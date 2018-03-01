#!/system/bin/sh
# AUTHOR: TEAM HELIX @ XDA-DEVELOPERS
# Template by @ZeroInfinity, adapted from @RogerF81
# Helix-Engine profile script: Powersave

EAS='0'
HMP='0'
SCHED_PATH='/proc/sys/kernel'
CPU='/sys/devices/system/cpu'

LITTLE_CLUSTER='/sys/devices/system/cpu/cpufreq/policy0'
LITTLE_MAX_VALUE="$(cat ${LITTLE_CLUSTER}/cpuinfo_max_freq)"
LITTLE_MIN_VALUE="$(cat ${LITTLE_CLUSTER}/cpuinfo_min_freq)"
LITTLE_AVAIL_GOVS="${LITTLE_CLUSTER}/scaling_available_governors"

BIG_CLUSTER='/sys/devices/system/cpu/cpufreq/policy4'
BIG_MAX_VALUE="$(cat ${BIG_CLUSTER}/cpuinfo_max_freq)"
BIG_MIN_VALUE="$(cat ${BIG_CLUSTER}/cpuinfo_min_freq)"
BIG_AVAIL_GOVS="${BIG_CLUSTER}/scaling_available_governors"

kernel_detection() {
	if grep 'schedutil' ${LITTLE_AVAIL_GOVS}; then
		EAS=1
	elif grep 'interactive' ${LITTLE_AVAIL_GOVS}; then
		HMP=1
	fi
}

EAS_tweaks() {
	local STUNE='/dev/stune'
	
	#General EAS tweaks
	echo "0" > ${STUNE}/top-app/schedtune.boost
	echo "0" > ${STUNE}/top-app/schedtune.prefer_idle
	
	echo "-25" > ${STUNE}/foreground/schedtune.boost
	echo "0" > ${STUNE}/foreground/schedtune.prefer_idle
	
	echo "-50" > ${STUNE}/background/schedtune.boost
	echo "0" > ${STUNE}/background/schedtune.prefer_idle
	
	echo "0" > ${STUNE}/schedtune.boost
	echo "0" > ${STUNE}/schedtune.prefer_idle
	
	echo "18" > ${SCHED_PATH}/sched_nr_migrate
	
	#Little cluster governor tweaks
	if grep 'pwrutilx' ${LITTLE_AVAIL_GOVS}; then
		if [[ -e ${LITTLE_AVAIL_GOVS} ]]; then
			chmod 644 ${LITTLE_CLUSTER}/pwrutilx/*
			
			echo "pwrutilx" > ${LITTLE_CLUSTER}/scaling_governor
			echo "10000" > ${LITTLE_CLUSTER}/pwrutilx/up_rate_limit_us
			echo "1000" > ${LITTLE_CLUSTER}/pwrutilx/down_rate_limit_us
			echo "0" > ${LITTLE_CLUSTER}/pwrutilx/iowait_boost_enable
			echo "5" > /sys/module/cpu_boost/parameters/dynamic_stune_boost
			
			chmod 444 ${LITTLE_CLUSTER}/pwrutilx/*
		fi
	elif grep 'schedutil' ${LITTLE_AVAIL_GOVS}; then
		if [[ -e ${LITTLE_AVAIL_GOVS} ]]; then
			chmod 644 ${LITTLE_CLUSTER}/schedutil/*
			
			echo "schedutil" > ${LITTLE_CLUSTER}/scaling_governor
			echo "10000" > ${LITTLE_CLUSTER}/schedutil/up_rate_limit_us
			echo "500" > ${LITTLE_CLUSTER}/schedutil/down_rate_limit_us
			
			if [[ -e ${LITTLE_CLUSTER}/schedutil/iowait_boost_enable ]]; then
				echo "0" > ${LITTLE_CLUSTER}/schedutil/iowait_boost_enable
			fi
			
			echo "3" > /sys/module/cpu_boost/parameters/dynamic_stune_boost
			
			chmod 444 ${LITTLE_CLUSTER}/schedutil/*
		fi
	fi
	
	#Big cluster governor tweaks
	if grep 'pwrutilx' ${BIG_AVAIL_GOVS}; then
		if [[ -e ${BIG_AVAIL_GOVS} ]]; then
			chmod 644 ${BIG_CLUSTER}/pwrutilx/*
			
			echo "pwrutilx" > ${BIG_CLUSTER}/scaling_governor
			echo "10000" > ${BIG_CLUSTER}/pwrutilx/up_rate_limit_us
			echo "1000" > ${BIG_CLUSTER}/pwrutilx/down_rate_limit_us
			echo "0" > ${BIG_CLUSTER}/pwrutilx/iowait_boost_enable
			
			chmod 444 ${BIG_CLUSTER}/pwrutilx/*
		fi
		
	elif grep 'schedutil' ${BIG_AVAIL_GOVS}; then
		if [[ -e ${BIG_AVAIL_GOVS} ]]; then
			chmod 644 ${BIG_CLUSTER}/schedutil/*
			
			echo "schedutil" > ${BIG_CLUSTER}/scaling_governor
			echo "20000" > ${BIG_CLUSTER}/schedutil/up_rate_limit_us
			echo "500" > ${BIG_CLUSTER}/schedutil/down_rate_limit_us
			
			if [[ -e "${BIG_CLUSTER}/schedutil/iowait_boost_enable" ]]; then
				echo "0" > ${BIG_CLUSTER}/schedutil/iowait_boost_enable
			fi
			
			chmod 444 ${BIG_CLUSTER}/schedutil/*
		fi
	fi
	
	chmod 664 ${LITTLE_CLUSTER}/scaling_max_freq
	chmod 664 ${LITTLE_CLUSTER}/scaling_min_freq
	echo "1248000" > ${LITTLE_CLUSTER}/scaling_max_freq
	echo "${LITTLE_MIN_VALUE}" > ${LITTLE_CLUSTER}/scaling_min_freq
	
	chmod 664 ${BIG_CLUSTER}/scaling_max_freq
	chmod 664 ${BIG_CLUSTER}/scaling_min_freq
	echo "1267200" > ${BIG_CLUSTER}/scaling_max_freq
	echo "${BIG_MIN_VALUE}" > ${BIG_CLUSTER}/scaling_min_freq
	
	chmod 644 ${CPU}/online
	echo "0-3" > ${CPU}/online
	chmod 444 ${CPU}/online
	
	chmod 644 ${CPU}/offline
	echo "4-7" > ${CPU}/offline
	chmod 444 ${CPU}/offline
	
	chmod 644 ${LITTLE_CLUSTER}/affected_cpus
	echo "0 1 2 3" > ${LITTLE_CLUSTER}/affected_cpus
	chmod 444 ${LITTLE_CLUSTER}/affected_cpus
	
	chmod 644 ${BIG_CLUSTER}/affected_cpus
	echo "" > ${BIG_CLUSTER}/affected_cpus
	chmod 444 ${BIG_CLUSTER}/affected_cpus

	echo "1" > ${CPU}/cpu0/online
	echo "1" > ${CPU}/cpu1/online
	echo "1" > ${CPU}/cpu2/online
	echo "1" > ${CPU}/online
	
	echo "0" > ${CPU}/online
	echo "0" > ${CPU}/online
	echo "0" > ${CPU}/online
	echo "0" > ${CPU}/online
}

HMP_tweaks() {
	#General HMP tweaks
	echo "100" > ${SCHED_PATH}/sched_upmigrate
	echo "100" > ${SCHED_PATH}/sched_group_upmigrate
	echo "90" > ${SCHED_PATH}/sched_downmigrate
	echo "95" > ${SCHED_PATH}/sched_group_downmigrate
	echo "20" > ${SCHED_PATH}/sched_small_wakee_task_load
	echo "0" > ${SCHED_PATH}/sched_init_task_load
	
	if [[ -e ${SCHED_PATH}/sched_enable_power_aware ]]; then
		echo "1" > ${SCHED_PATH}/sched_enable_power_aware
	fi
	
	echo "1" > ${SCHED_PATH}/sched_enable_thread_grouping
	echo "40" > ${SCHED_PATH}/sched_big_waker_task_load
	echo "3" > ${SCHED_PATH}/sched_window_stats_policy
	echo "5" > ${SCHED_PATH}/sched_ravg_hist_size
	
	if [[ -e ${SCHED_PATH}/sched_upmigrate_min_nice ]]; then
		echo "0" > ${SCHED_PATH}/sched_upmigrate_min_nice
	fi
	
	echo "5" > ${SCHED_PATH}/sched_spill_nr_run
	echo "100" > ${SCHED_PATH}/sched_spill_load
	echo "1" > ${SCHED_PATH}/sched_enable_thread_grouping
	echo "1" > ${SCHED_PATH}/sched_restrict_cluster_spill
	
	if [[ -e ${SCHED_PATH}/sched_wakeup_load_threshold ]]; then
		echo "110" > ${SCHED_PATH}/sched_wakeup_load_threshold
	fi
	
	echo "10" > ${SCHED_PATH}/sched_rr_timeslice_ms
	
	if [[ -e "$SCHED_PATH/sched_enable_power_aware" ]]; then
		echo "1" > ${SCHED_PATH}/sched_enable_power_aware
	fi
	
	if [[ -e "$SCHED_PATH/sched_migration_fixup" ]]; then
		echo "1" > ${SCHED_PATH}/sched_migration_fixup
	fi
	
	#Little cluster governor tweaks
	if grep 'interactive' ${LITTLE_AVAIL_GOVS}; then
		if [[ -e ${LITTLE_AVAIL_GOVS} ]]; then
			chmod 644 ${LITTLE_CLUSTER}/interactive/*
			
			echo "interactive" > ${LITTLE_CLUSTER}/scaling_governor
		
			if [[ -e "${LITTLE_CLUSTER}/interactive/powersave_bias" ]]; then
				echo "1" > ${LITTLE_CLUSTER}/interactive/powersave_bias
			fi
			
			echo "90 1401600:95" > ${LITTLE_CLUSTER}/interactive/target_loads
			echo "120000" > ${LITTLE_CLUSTER}/interactive/timer_slack
			echo "60000" > ${LITTLE_CLUSTER}/interactive/timer_rate
			echo "300000" > ${LITTLE_CLUSTER}/interactive/hispeed_freq
			echo "50000 883200:75000 1401600:100000" > ${LITTLE_CLUSTER}/interactive/above_hispeed_delay
			echo "400" > ${LITTLE_CLUSTER}/interactive/go_hispeed_load
			echo "0" > ${LITTLE_CLUSTER}/interactive/min_sample_time
			echo "0" > ${LITTLE_CLUSTER}/interactive/max_freq_hysteresis
			echo "1" > ${LITTLE_CLUSTER}/interactive/fast_ramp_down
			echo "0" > ${LITTLE_CLUSTER}/interactive/use_sched_load
			echo "0" > ${LITTLE_CLUSTER}/interactive/boostpulse_duration
			
			chmod 444 ${LITTLE_CLUSTER}/interactive/*
		fi
	fi
	
	#Big cluster governor tweaks
	if grep 'interactive' ${BIG_AVAIL_GOVS}; then
		if [[ -e ${BIG_AVAIL_GOVS} ]]; then		
			chmod 644 ${BIG_CLUSTER}/interactive/*

			echo "interactive" > ${BIG_CLUSTER}/scaling_governor
			echo "90 1132800:95" > ${BIG_CLUSTER}/interactive/target_loads
			echo "120000" > ${BIG_CLUSTER}/interactive/timer_slack
			echo "300000" > ${BIG_CLUSTER}/interactive/hispeed_freq
			echo "100000" > ${BIG_CLUSTER}/interactive/timer_rate
			echo "60000 1132800:100000" > ${BIG_CLUSTER}/interactive/above_hispeed_delay
			echo "400" > ${BIG_CLUSTER}/interactive/go_hispeed_load
			echo "0" > ${BIG_CLUSTER}/interactive/min_sample_time
			echo "0" > ${BIG_CLUSTER}/interactive/max_freq_hysteresis
			echo "1" > ${BIG_CLUSTER}/interactive/fast_ramp_down
			echo "0" > ${BIG_CLUSTER}/interactive/use_sched_load
			echo "0" > ${BIG_CLUSTER}/interactive/boostpulse_duration
			
			chmod 444 ${BIG_CLUSTER}/interactive/*
		fi
	fi
	
	#Disable TouchBoost
	if [[ -e /sys/module/msm_performance/parameters/touchboost ]]; then
		chmod 644 /sys/module/msm_performance/parameters/touchboost
		echo "0" > /sys/module/msm_performance/parameters/touchboost
	fi
	
	chmod 664 ${LITTLE_CLUSTER}/scaling_max_freq
	chmod 664 ${LITTLE_CLUSTER}/scaling_min_freq
	echo "1248000" > ${LITTLE_CLUSTER}/scaling_max_freq
	echo "${LITTLE_MIN_VALUE}" > ${LITTLE_CLUSTER}/scaling_min_freq
	
	chmod 664 ${BIG_CLUSTER}/scaling_max_freq
	chmod 664 ${BIG_CLUSTER}/scaling_min_freq
	echo "1267200" > ${BIG_CLUSTER}/scaling_max_freq
	echo "${BIG_MIN_VALUE}" > ${BIG_CLUSTER}/scaling_min_freq
	
	chmod 644 ${CPU}/online
	echo "0-3" > ${CPU}/online
	chmod 444 ${CPU}/online
	
	chmod 644 ${CPU}/offline
	echo "4-7" > ${CPU}/offline
	chmod 444 ${CPU}/offline
	
	chmod 644 ${LITTLE_CLUSTER}/affected_cpus
	echo "0 1 2 3" > ${LITTLE_CLUSTER}/affected_cpus
	chmod 444 ${LITTLE_CLUSTER}/affected_cpus
	
	chmod 644 ${BIG_CLUSTER}/affected_cpus
	echo "" > ${BIG_CLUSTER}/affected_cpus
	chmod 444 ${BIG_CLUSTER}/affected_cpus

	echo "1" > ${CPU}/cpu0/online
	echo "1" > ${CPU}/cpu1/online
	echo "1" > ${CPU}/cpu2/online
	echo "1" > ${CPU}/cpu3/online
	
	echo "0" > ${CPU}/cpu4/online
	echo "0" > ${CPU}/cpu5/online
	echo "0" > ${CPU}/cpu6/online
	echo "0" > ${CPU}/cpu7/online
}

extras() {
	local CPU_BOOST='/sys/module/cpu_boost/parameters'
	local NET='/proc/sys/net/ipv4'
	
	echo "0" > /dev/cpuset/background/cpus
	echo "0" > /dev/cpuset/system-background/cpus
	
	#Tweak cpu boost
	if [[ -e /sys/module/cpu_boost ]]; then
		if [[ -e ${CPU_BOOST}/input_boost_enabled ]]; then
			chmod 644 ${CPU_BOOST}/input_boost_enabled
			echo "1" > ${CPU_BOOST}/input_boost_enabled
		fi
		
		chmod 644 ${CPU_BOOST}/input_boost_freq
		echo "0:0 1:0 2:0 3:0 4:0 5:0 6:0 7:0" > ${CPU_BOOST}/input_boost_freq
		
		chmod 644 ${CPU_BOOST}/input_boost_ms
		echo "0" > ${CPU_BOOST}/input_boost_ms
		
		if [[ -e /sys/module/msm_performance/parameters/touchboost/sched_boost_on_input ]]; then
			echo "N" > /sys/module/msm_performance/parameters/touchboost/sched_boost_on_input
		fi
	fi
	
	#TCP tweaks
	if grep 'westwood' ${NET}/tcp_available_congestion_control; then
		echo "westwood" > ${NET}/tcp_congestion_control
	else 
		echo "cubic" > ${NET}/tcp_congestion_control
	fi
	
	echo "1" > ${NET}/tcp_low_latency
}

IO_tweaks() {
	local Q_PATH='/sys/block/sda/queue/'
	
	if [[ -d ${Q_PATH} ]]; then
		if grep 'noop' ${Q_PATH}/scheduler; then
			echo "noop" > ${Q_PATH}/scheduler
		elif grep 'maple' ${Q_PATH}/scheduler; then
			echo "maple" > ${Q_PATH}/scheduler
			echo "16" > ${Q_PATH}/iosched/fifo_batch
			echo "4" > ${Q_PATH}/iosched/writes_starved
			echo "10" > ${Q_PATH}/iosched/sleep_latency_multiple
			echo "200" > ${Q_PATH}/iosched/async_read_expire   ##default values
			echo "500" > ${Q_PATH}/iosched/async_write_expire   ##default values
			echo "100" > ${Q_PATH}/iosched/sync_read_expire   ##default values
			echo "350" > ${Q_PATH}/iosched/sync_write_expire   ##default values
		elif grep 'cfq' ${Q_PATH}/scheduler; then
			echo "cfq" > ${Q_PATH}/scheduler
		else
			echo "	-Error Code #03"
		fi
		
		echo "512" > ${Q_PATH}/read_ahead_kb
		echo "96" > ${Q_PATH}/nr_requests
		echo "0" > ${Q_PATH}/add_random
		echo "0" > ${Q_PATH}/iostats
		echo "1" > ${Q_PATH}/nomerges
		echo "0" > ${Q_PATH}/rotational
		echo "1" > ${Q_PATH}/rq_affinity
	fi
}

GPU_tweaks() {
	local GPU_PATH='/sys/devices/soc/5000000.qcom,kgsl-3d0/devfreq/5000000.qcom,kgsl-3d0'
	local MAX_FREQ="$GPU_PATH/max_freq"
	local MIN_FREQ="$GPU_PATH/min_freq"
	local TARGET_FREQ="$GPU_PATH/target_freq"
	local AVAIL_FREQS="$GPU_PATH/available_frequencies"
	
	echo "powersave" > ${GPU_PATH}/governor
	
	if [[ -e ${GPU_FREQ} ]]; then
		if grep '710000000' ${AVAIL_FREQS}; then
			chmod 644 ${GPU_FREQ}
			echo 596000000 > ${GPU_FREQ}
			chmod 444 ${GPU_FREQ}
		fi
		
		if grep '180000000' ${AVAIL_FREQS}; then
			chmod 644 ${TARGET_FREQ}
			echo 180000000 > ${TARGET_FREQ}
			chmod 444 ${TARGET_FREQ}
			
			echo 180000000 > ${MIN_FREQ}
		else
			chmod 644 ${TARGET_FREQ}
			echo 257000000 > ${TARGET_FREQ}
			chmod 444 ${TARGET_FREQ}
			
			echo 257000000 > ${MIN_FREQ}
		fi
		
		if [[ -e "${GPU_PATH}/adrenoboost" ]]; then
			chmod 644 ${GPU_PATH}/adrenoboost
			echo "0" > ${GPU_PATH}/adrenoboost
		fi
	fi
}

memory_tweaks() {
	local VM_PATH='/proc/sys/vm'
	local LMK_PATH='/sys/module/lowmemorykiller/parameters'

	chmod 664 ${LMK_PATH}/enable_adaptive_lmk
	chown root ${LMK_PATH}/enable_adaptive_lmk
	echo "1" > ${LMK_PATH}/enable_adaptive_lmk
	chmod 444 ${LMK_PATH}/enable_adaptive_lmk
	
	echo "18432,23040,27648,32256,82944,161280" > ${LMK_PATH}/minfree
	
	chmod 644 ${LMK_PATH}/debug_level
	echo "0" > ${LMK_PATH}/debug_level
	chmod 444 ${LMK_PATH}/debug_level

	#Virtual Memory
	echo "2000" > ${VM_PATH}/dirty_expire_centisecs
	echo "5000" > ${VM_PATH}/dirty_writeback_centisecs
	echo "0" > ${VM_PATH}/oom_kill_allocating_task
	echo "0" > ${VM_PATH}/page-cluster
	echo "60" > ${VM_PATH}/swappiness
	echo "150" > ${VM_PATH}/vfs_cache_pressure
	echo "15" > ${VM_PATH}/dirty_ratio
	echo "5" > ${VM_PATH}/dirty_background_ratio
	echo "11093" > ${VM_PATH}/min_free_kbytes
	echo "1" > ${VM_PATH}/overcommit_memory
	echo "50" > ${VM_PATH}/overcommit_ratio
	
	#Entropy
	echo "16" > ${SCHED_PATH}/random/read_wakeup_threshold
	echo "32" > ${SCHED_PATH}/random/write_wakeup_threshold
}

main() {
	kernel_detection  #Detect whether the kernel is EAS or HMP
	
	if [ "${EAS}" -eq "1" ]; then
		EAS_tweaks #If EAS is detected, apply EAS specific tweaks
	elif [ "${HMP}" -eq "1" ]; then
		HMP_tweaks #If HMP is detected, apply HMP specific tweaks
	fi
	
	GPU_tweaks #Apply GPU tweaks
	IO_tweaks #Apply IO tweaks
	extras #Apply extra kernel tweaks
}

main #Execute main

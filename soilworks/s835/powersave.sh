#!/system/bin/sh
# AUTHOR: TEAM HELIX @ XDA-DEVELOPERS
# Template by @ZeroInfinity, adapted from @RogerF81, improved by @Asiier
# Helix-Engine profile script: Powersave
LITTLE_CLUSTER='/sys/devices/system/cpu/cpufreq/policy0'
LITTLE_MAX_VALUE="$(cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq)"
LITTLE_MIN_VALUE="$(cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq)"
LITTLE_AVAIL_GOVS="${LITTLE_CLUSTER}/scaling_available_governors"

BIG_CLUSTER='/sys/devices/system/cpu/cpufreq/policy4'
BIG_MAX_VALUE="$(cat /sys/devices/system/cpu/cpufreq/policy4/cpuinfo_max_freq)"
BIG_MIN_VALUE="$(cat /sys/devices/system/cpu/cpufreq/policy4/cpuinfo_min_freq)"
BIG_AVAIL_GOVS="${BIG_CLUSTER}/scaling_available_governors"

##################################
# Energy-Aware Scheduling Tweaks #
##################################

#Schedtune tunables
TA_BOOST='0'
TA_PREF_IDLE='0'
FG_BOOST='-50'
FG_PREF_IDLE='0'
BG_BOOST='-50'
BG_PREF_IDLE='0'
GEN_BOOST='0'
GEN_PREF_IDLE='0'

#EAS tunables
SCHED_NR_MIGRATE='18'

#schedutil gov tweaks
SCHEDUTIL_UP_RATE_LITTLE='10000'
SCHEDUTIL_DOWN_RATE_LITTLE='500'
SCHEDUTIL_IOWAIT_BOOST_LITTLE='0'
SCHEDUTIL_UP_RATE_BIG='20000'
SCHEDUTIL_DOWN_RATE_BIG='500'
SCHEDUTIL_IOWAIT_BOOST_BIG='0'
SCHEDUTIL_DYN_STUNE='0'

#Generic CPU settings
EAS_BIG_MAX_FREQ='1574400'
EAS_BIG_MIN_FREQ="${BIG_MIN_VALUE}"
EAS_LITTLE_MAX_FREQ='1555200'
EAS_LITTLE_MIN_FREQ="${LITTLE_MIN_VALUE}"
EAS_CPU0_ONLINE='1'
EAS_CPU1_ONLINE='1'
EAS_CPU2_ONLINE='0'
EAS_CPU3_ONLINE='0'
EAS_CPU4_ONLINE='1'
EAS_CPU5_ONLINE='1'
EAS_CPU6_ONLINE='0'
EAS_CPU7_ONLINE='0'
##################################
# Energy-Aware Scheduling Tweaks #
##################################

#########################################
# Heterogeneous Multi-Processing Tweaks #
#########################################

#HMP tunables
SCHED_DOWNMIGRATE='85'
SCHED_GROUP_DOWNMIGRATE='95'
SCHED_UPMIGRATE='99'
SCHED_GROUP_UPMIGRATE='100'
SCHED_SMALL_TASK_WAKEE_TASK_LOAD='20'
SCHED_INIT_TASK_LOAD='0'
SCHED_ENABLE_POWER_AWARE='1'
SCHED_ENABLE_THREAD_GROUPING='1'
SCHED_BIG_WAKER_TASK_LOAD='40'
SCHED_WINDOW_STATS_POLICY='3'
SCHED_RAVG_HIST_SIZE='5'
SCHED_UPMIGRATE_MIN_NICE='0'
SCHED_SPILL_NR_RUN='15'
SCHED_SPILL_LOAD='100'
SCHED_RESTRICT_CLUSTER_SPILL='1'
SCHED_WAKEUP_LOAD_THRESHOLD='110'
SCHED_RR_TIMESLICE_MS='10'
SCHED_MIGRATION_FIXUP='1'
SCHED_AUTOGROUP_ENABLED='1'
SCHED_FREQ_INC_NOTIFY='600000'
SCHED_FREQ_DEC_NOTIFY='200000'
SCHED_SELECT_PREV_CPU_US='0'

#Interactive gov tweaks
TARGET_LOADS_LITTLE='90 1401600:95'
TIMER_SLACK_LITTLE='120000'
TIMER_RATE_LITTLE='60000'
HISPEED_FREQ_LITTLE='300000'
ABOVE_HISPEED_DELAY_LITTLE='50000 883200:75000 1401600:100000'
GO_HISPEED_LOAD_LITTLE='400'
MIN_SAMPLE_TIME_LITTLE='0'
MAX_FREQ_HYSTERESIS_LITTLE='0'
FAST_RAMP_DOWN_LITTLE='1'
USE_SCHED_LOAD_LITTLE='0'
BOOSTPULSE_DURATION_LITTLE='0'

TARGET_LOADS_BIG='93 1132800:97'
TIMER_SLACK_BIG='120000'
TIMER_RATE_BIG='100000'
HISPEED_FREQ_BIG='300000'
ABOVE_HISPEED_DELAY_BIG='60000 1132800:100000'
GO_HISPEED_LOAD_BIG='400'
MIN_SAMPLE_TIME_BIG='0'
MAX_FREQ_HYSTERESIS_BIG='0'
FAST_RAMP_DOWN_BIG='1'
USE_SCHED_LOAD_BIG='0'
BOOSTPULSE_DURATION_BIG='0'

#Generic CPU settings
TOUCHBOOST='0'
HMP_BIG_MAX_FREQ='1574400'
HMP_BIG_MIN_FREQ="${BIG_MIN_VALUE}"
HMP_LITTLE_MAX_FREQ='1555200'
HMP_LITTLE_MIN_FREQ="${LITTLE_MIN_VALUE}"
HMP_CPU0_ONLINE='1'
HMP_CPU1_ONLINE='1'
HMP_CPU2_ONLINE='0'
HMP_CPU3_ONLINE='0'
HMP_CPU4_ONLINE='1'
HMP_CPU5_ONLINE='1'
HMP_CPU6_ONLINE='0'
HMP_CPU7_ONLINE='0'

#########################################
# Heterogeneous Multi-Processing Tweaks #
#########################################

###############
# Misc Tweaks #
###############

CPUSET_BG='0'
CPUSET_SYSBG='0'

INPUT_BOOST_ENABLED='1'
INPUT_BOOST_FREQ='0:0 1:0 2:0 3:0 4:0 5:0 6:0 7:0'
INPUT_BOOST_MS='0'
SCHED_BOOST_ON_INPUT='N'

TCP_CONTROL='westwood'
TCP_LOW_LATENCY='1'

###############
# Misc Tweaks #
###############

#############
# IO Tweaks #
#############

#TODO: Re-do IO tweaks so they aren't restricted by conditions

#############
# IO Tweaks #
#############

##############
# GPU Tweaks #
##############

GPU_MAX_FREQ='515000000'
GPU_GOV='powersave'
ADRENOBOOST='0'

##############
# GPU Tweaks #
##############

#################
# Memory Tweaks #
#################

ENABLE_ADAPTIVE_LMK='1'
MINFREE='18432,23040,27648,32256,73728,120960'
DEBUG_LEVEL='0'

DIRTY_EXPIRE_CENTISECS='3000'
DITRY_WRITEBACK_CENTISECS='1500'
OOM_KILL_ALLOCATING_TASK='0'
PAGE_CLUSTER='2'
SWAPPINESS='30'
VFS_CACHE_PRESSURE='70'
DIRTY_RATIO='15'
DIRTY_BACKGROUND_RATIO='10'
MIN_FREE_KBYTES='11093'
OVERCOMMIT_MEMORY='1'
OVERCOMMIT_RATIO='50'

READ_WAKUP_THRESHOLD='16'
WRITE_WAKEUP_THRESHOLD='32'

#################
# Memory Tweaks #
#################

EAS='0'
HMP='0'
SCHED_PATH='/proc/sys/kernel'
CPU='/sys/devices/system/cpu'

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
	echo "${TA_BOOST}" > ${STUNE}/top-app/schedtune.boost
	echo "${TA_PREF_IDLE}" > ${STUNE}/top-app/schedtune.prefer_idle
	
	echo "${FG_BOOST}" > ${STUNE}/foreground/schedtune.boost
	echo "${FG_PREF_IDLE}" > ${STUNE}/foreground/schedtune.prefer_idle
	
	echo "${BG_BOOST}" > ${STUNE}/background/schedtune.boost
	echo "${BG_PREF_IDLE}" > ${STUNE}/background/schedtune.prefer_idle
	
	echo "${GEN_BOOST}" > ${STUNE}/schedtune.boost
	echo "${GEN_PREF_IDLE}" > ${STUNE}/schedtune.prefer_idle
	
	echo "${SCHED_NR_MIGRATE}" > ${SCHED_PATH}/sched_nr_migrate
	
	#Little cluster governor tweaks
	chmod 644 ${LITTLE_CLUSTER}/schedutil/*
	echo "schedutil" > ${LITTLE_CLUSTER}/scaling_governor
	echo "${SCHEDUTIL_UP_RATE_LITTLE}" > ${LITTLE_CLUSTER}/schedutil/up_rate_limit_us
	echo "${SCHEDUTIL_DOWN_RATE_LITTLE}" > ${LITTLE_CLUSTER}/schedutil/down_rate_limit_us

	if [[ -e ${LITTLE_CLUSTER}/schedutil/iowait_boost_enable ]]; then
		echo "${SCHEDUTIL_IOWAIT_BOOST_LITTLE}" > ${LITTLE_CLUSTER}/schedutil/iowait_boost_enable
	fi
	
	echo "${SCHEDUTIL_DYN_STUNE}" > /sys/module/cpu_boost/parameters/dynamic_stune_boost
	chmod 444 ${LITTLE_CLUSTER}/schedutil/*
	
	chmod 644 ${BIG_CLUSTER}/schedutil/*
	echo "schedutil" > ${BIG_CLUSTER}/scaling_governor
	echo "${SCHEDUTIL_UP_RATE_BIG}" > ${BIG_CLUSTER}/schedutil/up_rate_limit_us
	echo "${SCHEDUTIL_DOWN_RATE_BIG}" > ${BIG_CLUSTER}/schedutil/down_rate_limit_us
	
	if [[ -e "${BIG_CLUSTER}/schedutil/iowait_boost_enable" ]]; then
		echo "${SCHEDUTIL_IOWAIT_BOOST_BIG}" > ${BIG_CLUSTER}/schedutil/iowait_boost_enable
	fi
	
	chmod 444 ${BIG_CLUSTER}/schedutil/*
	
	chmod 664 ${LITTLE_CLUSTER}/scaling_max_freq
	chmod 664 ${LITTLE_CLUSTER}/scaling_min_freq
	echo "${EAS_LITTLE_MAX_FREQ}" > ${LITTLE_CLUSTER}/scaling_max_freq
	echo "${EAS_LITTLE_MIN_FREQ}" > ${LITTLE_CLUSTER}/scaling_min_freq
	
	chmod 664 ${BIG_CLUSTER}/scaling_max_freq
	chmod 664 ${BIG_CLUSTER}/scaling_min_freq
	echo "${EAS_BIG_MAX_FREQ}" > ${BIG_CLUSTER}/scaling_max_freq
	echo "${EAS_BIG_MIN_FREQ}" > ${BIG_CLUSTER}/scaling_min_freq

	echo "${EAS_CPU0_ONLINE}" > ${CPU}/cpu0/online
	echo "${EAS_CPU1_ONLINE}" > ${CPU}/cpu1/online
	echo "${EAS_CPU2_ONLINE}" > ${CPU}/cpu2/online
	echo "${EAS_CPU3_ONLINE}" > ${CPU}/cpu3/online
	echo "${EAS_CPU4_ONLINE}" > ${CPU}/cpu4/online
	echo "${EAS_CPU5_ONLINE}" > ${CPU}/cpu5/online
	echo "${EAS_CPU6_ONLINE}" > ${CPU}/cpu6/online
	echo "${EAS_CPU7_ONLINE}" > ${CPU}/cpu7/online
}

HMP_tweaks() {
	#General HMP tweaks
	echo "${SCHED_DOWNMIGRATE}" > ${SCHED_PATH}/sched_downmigrate
	echo "${SCHED_GROUP_DOWNMIGRATE}" > ${SCHED_PATH}/sched_group_downmigrate
	echo "${SCHED_UPMIGRATE}" > ${SCHED_PATH}/sched_upmigrate
	echo "${SCHED_GROUP_UPMIGRATE}" > ${SCHED_PATH}/sched_group_upmigrate
	echo "${SCHED_SMALL_TASK_WAKEE_TASK_LOAD}" > ${SCHED_PATH}/sched_small_wakee_task_load
	echo "${SCHED_INIT_TASK_LOAD}" > ${SCHED_PATH}/sched_init_task_load
	echo "${SCHED_AUTOGROUP_ENABLED}" > ${SCHED_PATH}/sched_autogroup_enabled 
	
	if [[ -e ${SCHED_PATH}/sched_enable_power_aware ]]; then
		echo "${SCHED_ENABLE_POWER_AWARE}" > ${SCHED_PATH}/sched_enable_power_aware
	fi
	
	echo "${SCHED_ENABLE_THREAD_GROUPING}" > ${SCHED_PATH}/sched_enable_thread_grouping
	echo "${SCHED_BIG_WAKER_TASK_LOAD}" > ${SCHED_PATH}/sched_big_waker_task_load
	echo "${SCHED_WINDOW_STATS_POLICY}" > ${SCHED_PATH}/sched_window_stats_policy
	echo "${SCHED_RAVG_HIST_SIZE}" > ${SCHED_PATH}/sched_ravg_hist_size
	
	if [[ -e ${SCHED_PATH}/sched_upmigrate_min_nice ]]; then
		echo "${SCHED_UPMIGRATE_MIN_NICE}" > ${SCHED_PATH}/sched_upmigrate_min_nice
	fi
	
	echo "${SCHED_SPILL_NR_RUN}" > ${SCHED_PATH}/sched_spill_nr_run
	echo "${SCHED_SPILL_LOAD}" > ${SCHED_PATH}/sched_spill_load
	echo "${SCHED_RESTRICT_CLUSTER_SPILL}" > ${SCHED_PATH}/sched_restrict_cluster_spill
	
	if [[ -e ${SCHED_PATH}/sched_wakeup_load_threshold ]]; then
		echo "${SCHED_WAKEUP_LOAD_THRESHOLD}" > ${SCHED_PATH}/sched_wakeup_load_threshold
	fi
	
	echo "${SCHED_RR_TIMESLICE_MS}" > ${SCHED_PATH}/sched_rr_timeslice_ms
	
	if [[ -e "$SCHED_PATH/sched_migration_fixup" ]]; then
		echo "${SCHED_MIGRATION_FIXUP}" > ${SCHED_PATH}/sched_migration_fixup
	fi
	echo "${SCHED_FREQ_INC_NOTIFY}" > ${SCHED_PATH}/sched_freq_inc_notify
	echo "${SCHED_FREQ_DEC_NOTIFY}" > ${SCHED_PATH}/sched_freq_dec_notify
	echo "${SCHED_SELECT_PREV_CPU_US}" > ${SCHED_PATH}/sched_select_prev_cpu_us
	
	#Little cluster governor tweaks
	echo "interactive" > ${LITTLE_CLUSTER}/scaling_governor

	echo "${TARGET_LOADS_LITTLE}" > ${LITTLE_CLUSTER}/interactive/target_loads
	echo "${TIMER_SLACK_LITTLE}" > ${LITTLE_CLUSTER}/interactive/timer_slack
	echo "${TIMER_RATE_LITTLE}" > ${LITTLE_CLUSTER}/interactive/timer_rate
	echo "${HISPEED_FREQ_LITTLE}" > ${LITTLE_CLUSTER}/interactive/hispeed_freq
	echo "${ABOVE_HISPEED_DELAY_LITTLE}" > ${LITTLE_CLUSTER}/interactive/above_hispeed_delay
	echo "${GO_HISPEED_LOAD_LITTLE}" > ${LITTLE_CLUSTER}/interactive/go_hispeed_load
	echo "${MIN_SAMPLE_TIME_LITTLE}" > ${LITTLE_CLUSTER}/interactive/min_sample_time
	echo "${MAX_FREQ_HYSTERESIS_LITTLE}" > ${LITTLE_CLUSTER}/interactive/max_freq_hysteresis
	echo "${FAST_RAMP_DOWN_LITTLE}" > ${LITTLE_CLUSTER}/interactive/fast_ramp_down
	echo "${USE_SCHED_LOAD_LITTLE}" > ${LITTLE_CLUSTER}/interactive/use_sched_load
	echo "${BOOSTPULSE_DURATION_LITTLE}" > ${LITTLE_CLUSTER}/interactive/boostpulse_duration
	chmod 444 ${LITTLE_CLUSTER}/interactive/*

	#Big cluster governor tweaks
	echo "interactive" > ${BIG_CLUSTER}/scaling_governor
	
	chmod 644 ${BIG_CLUSTER}/interactive/*
	echo "${TARGET_LOADS_BIG}" > ${BIG_CLUSTER}/interactive/target_loads
	echo "${TIMER_SLACK_BIG}" > ${BIG_CLUSTER}/interactive/timer_slack
	echo "${TIMER_RATE_BIG}" > ${BIG_CLUSTER}/interactive/timer_rate
	echo "${HISPEED_FREQ_BIG}" > ${BIG_CLUSTER}/interactive/hispeed_freq
	echo "${ABOVE_HISPEED_DELAY_BIG}" > ${BIG_CLUSTER}/interactive/above_hispeed_delay
	echo "${GO_HISPEED_LOAD_BIG}" > ${BIG_CLUSTER}/interactive/go_hispeed_load
	echo "${MIN_SAMPLE_TIME_BIG}" > ${BIG_CLUSTER}/interactive/min_sample_time
	echo "${MAX_FREQ_HYSTERESIS_BIG}" > ${BIG_CLUSTER}/interactive/max_freq_hysteresis
	echo "${FAST_RAMP_DOWN_BIG}" > ${BIG_CLUSTER}/interactive/fast_ramp_down
	echo "${USE_SCHED_LOAD_BIG}" > ${BIG_CLUSTER}/interactive/use_sched_load
	echo "${BOOSTPULSE_DURATION_BIG}" > ${BIG_CLUSTER}/interactive/boostpulse_duration
			
	chmod 444 ${BIG_CLUSTER}/interactive/*
	
	#Disable TouchBoost
	if [[ -e /sys/module/msm_performance/parameters/touchboost ]]; then
		chmod 644 /sys/module/msm_performance/parameters/touchboost
		echo "${TOUCHBOOST}" > /sys/module/msm_performance/parameters/touchboost
	fi
	
	chmod 664 ${LITTLE_CLUSTER}/scaling_max_freq
	chmod 664 ${LITTLE_CLUSTER}/scaling_min_freq
	echo "{$HMP_LITTLE_MAX_FREQ}" > ${LITTLE_CLUSTER}/scaling_max_freq
	echo "${HMP_LITTLE_MIN_FREQ}" > ${LITTLE_CLUSTER}/scaling_min_freq
	
	chmod 664 ${BIG_CLUSTER}/scaling_max_freq
	chmod 664 ${BIG_CLUSTER}/scaling_min_freq
	echo "${HMP_BIG_MAX_FREQ}" > ${BIG_CLUSTER}/scaling_max_freq
	echo "${HMP_BIG_MIN_FREQ}" > ${BIG_CLUSTER}/scaling_min_freq
	
	echo "${HMP_CPU0_ONLINE}" > ${CPU}/cpu0/online
	echo "${HMP_CPU1_ONLINE}" > ${CPU}/cpu1/online
	echo "${HMP_CPU2_ONLINE}" > ${CPU}/cpu2/online
	echo "${HMP_CPU3_ONLINE}" > ${CPU}/cpu3/online
	echo "${HMP_CPU4_ONLINE}" > ${CPU}/cpu4/online
	echo "${HMP_CPU5_ONLINE}" > ${CPU}/cpu5/online
	echo "${HMP_CPU6_ONLINE}" > ${CPU}/cpu6/online
	echo "${HMP_CPU7_ONLINE}" > ${CPU}/cpu7/online
}

extras() {
	local CPU_BOOST='/sys/module/cpu_boost/parameters'
	local NET='/proc/sys/net/ipv4'
	
	echo "${CPUSET_BG}" > /dev/cpuset/background/cpus
	echo "${CPUSET_SYSBG}" > /dev/cpuset/system-background/cpus
	
	#Tweak cpu boost
	if [[ -e /sys/module/cpu_boost ]]; then
		if [[ -e ${CPU_BOOST}/input_boost_enabled ]]; then
			chmod 644 ${CPU_BOOST}/input_boost_enabled
			echo "${INPUT_BOOST_ENABLED}" > ${CPU_BOOST}/input_boost_enabled
		fi
		
		chmod 644 ${CPU_BOOST}/input_boost_freq
		echo "${INPUT_BOOST_FREQ}" > ${CPU_BOOST}/input_boost_freq
		
		chmod 644 ${CPU_BOOST}/input_boost_ms
		echo "${INPUT_BOOST_MS}" > ${CPU_BOOST}/input_boost_ms
		
		if [[ -e /sys/module/msm_performance/parameters/touchboost/sched_boost_on_input ]]; then
			echo "${SCHED_BOOST_ON_INPUT}" > /sys/module/msm_performance/parameters/touchboost/sched_boost_on_input
		fi
	fi
	
	#TCP tweaks
	echo "${TCP_CONTROL}" > ${NET}/tcp_congestion_control
	echo "${TCP_LOW_LATENCY}" > ${NET}/tcp_low_latency
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
		echo "112" > ${Q_PATH}/nr_requests
		echo "0" > ${Q_PATH}/add_random
		echo "0" > ${Q_PATH}/iostats
		echo "1" > ${Q_PATH}/nomerges
		echo "0" > ${Q_PATH}/rotational
		echo "1" > ${Q_PATH}/rq_affinity
	fi
}

GPU_tweaks() {
	local GPU_PATH='/sys/devices/soc/5000000.qcom,kgsl-3d0/devfreq/5000000.qcom,kgsl-3d0'
	local MAX_FREQ="${GPU_PATH}/max_freq"
	
	echo "${GPU_GOV}" > ${GPU_PATH}/governor
	
	chmod 644 ${MAX_FREQ}
	echo "${GPU_MAX_FREQ}" > ${MAX_FREQ}
	chmod 444 ${MAX_FREQ}
	
	if [[ -e ${GPU_PATH}/adrenoboost ]]; then
		chmod 644 ${GPU_PATH}/adrenoboost
		echo "${ADRENOBOOST}" > ${GPU_PATH}/adrenoboost
	fi
}

memory_tweaks() {
	local VM_PATH='/proc/sys/vm'
	local LMK_PATH='/sys/module/lowmemorykiller/parameters'

	chmod 664 ${LMK_PATH}/enable_adaptive_lmk
	chown root ${LMK_PATH}/enable_adaptive_lmk
	echo "${ENABLE_ADAPTIVE_LMK}" > ${LMK_PATH}/enable_adaptive_lmk
	chmod 444 ${LMK_PATH}/enable_adaptive_lmk
	
	echo "${MINFREE}" > ${LMK_PATH}/minfree
	
	chmod 644 ${LMK_PATH}/debug_level
	echo "${DEBUG_LEVEL}" > ${LMK_PATH}/debug_level
	chmod 444 ${LMK_PATH}/debug_level

	#Virtual Memory
	echo "${DIRTY_EXPIRE_CENTISECS}" > ${VM_PATH}/dirty_expire_centisecs
	echo "${DITRY_WRITEBACK_CENTISECS}" > ${VM_PATH}/dirty_writeback_centisecs
	echo "${OOM_KILL_ALLOCATING_TASK}" > ${VM_PATH}/oom_kill_allocating_task
	echo "${PAGE_CLUSTER}" > ${VM_PATH}/page-cluster
	echo "${SWAPPINESS}" > ${VM_PATH}/swappiness
	echo "${VFS_CACHE_PRESSURE}" > ${VM_PATH}/vfs_cache_pressure
	echo "${DIRTY_RATIO}" > ${VM_PATH}/dirty_ratio
	echo "${DIRTY_BACKGROUND_RATIO}" > ${VM_PATH}/dirty_background_ratio
	echo "${MIN_FREE_KBYTES}" > ${VM_PATH}/min_free_kbytes
	echo "${OVERCOMMIT_MEMORY}" > ${VM_PATH}/overcommit_memory
	echo "${OVERCOMMIT_RATIO}" > ${VM_PATH}/overcommit_ratio
	
	#Entropy
	echo "${READ_WAKUP_THRESHOLD}" > ${SCHED_PATH}/random/read_wakeup_threshold
	echo "${WRITE_WAKEUP_THRESHOLD}" > ${SCHED_PATH}/random/write_wakeup_threshold
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
	memory_tweaks #Apply memory tweaks
	extras #Apply extra kernel tweaks
}

main #Execute main

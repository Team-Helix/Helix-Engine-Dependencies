#!/system/bin/sh
# AUTHOR: TEAM HELIX @ XDA-DEVELOPERS
# Template by @ZeroInfinity, adapted from @RogerF81, improved by @Asiier
# Helix-Engine profile script: Performance
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
TA_BOOST='10'
TA_PREF_IDLE='1'
FG_BOOST='0'
FG_PREF_IDLE='1'
BG_BOOST='0'
BG_PREF_IDLE='0'
GEN_BOOST='0'
GEN_PREF_IDLE='0'

#EAS tunables
SCHED_NR_MIGRATE='64'

#schedutil gov tweaks
SCHEDUTIL_UP_RATE_LITTLE='500'
SCHEDUTIL_DOWN_RATE_LITTLE='20000'
SCHEDUTIL_IOWAIT_BOOST_LITTLE='1'
SCHEDUTIL_UP_RATE_BIG='500'
SCHEDUTIL_DOWN_RATE_BIG='20000'
SCHEDUTIL_IOWAIT_BOOST_BIG='1'
SCHEDUTIL_DYN_STUNE='15'

#Generic CPU settings
EAS_BIG_MAX_FREQ='${BIG_MAX_VALUE}'
EAS_BIG_MIN_FREQ="${BIG_MIN_VALUE}"
EAS_LITTLE_MAX_FREQ="${LITTLE_MAX_VALUE}"
EAS_LITTLE_MIN_FREQ="${LITTLE_MIN_VALUE}"
EAS_CPU0_ONLINE='1'
EAS_CPU1_ONLINE='1'
EAS_CPU2_ONLINE='1'
EAS_CPU3_ONLINE='1'
EAS_CPU4_ONLINE='1'
EAS_CPU5_ONLINE='1'
EAS_CPU6_ONLINE='1'
EAS_CPU7_ONLINE='1'
EAS_LITTLE_AFFECTED_CPUS='1 2 3 4'
EAS_BIG_AFFECTED_CPUS='4 5 6 7'
##################################
# Energy-Aware Scheduling Tweaks #
##################################

#########################################
# Heterogeneous Multi-Processing Tweaks #
#########################################

#HMP tunables
SCHED_DOWNMIGRATE='40'
SCHED_GROUP_DOWNMIGRATE='50'
SCHED_UPMIGRATE='70'
SCHED_GROUP_UPMIGRATE='80'
SCHED_SMALL_TASK_WAKEE_TASK_LOAD='5'
SCHED_INIT_TASK_LOAD='15'
SCHED_ENABLE_POWER_AWARE='1'
SCHED_ENABLE_THREAD_GROUPING='0'
SCHED_BIG_WAKER_TASK_LOAD='20'
SCHED_WINDOW_STATS_POLICY='2'
SCHED_RAVG_HIST_SIZE='5'
SCHED_UPMIGRATE_MIN_NICE='9'
SCHED_SPILL_NR_RUN='3'
SCHED_SPILL_LOAD='60'
SCHED_RESTRICT_CLUSTER_SPILL='0'
SCHED_WAKEUP_LOAD_THRESHOLD='110'
SCHED_RR_TIMESLICE_MS='10'
SCHED_MIGRATION_FIXUP='1'
SCHED_AUTOGROUP_ENABLED='0'
SCHED_FREQ_INC_NOTIFY='100000'
SCHED_FREQ_DEC_NOTIFY='500000'
SCHED_SELECT_PREV_CPU_US='2000'

#Interactive gov tweaks
TARGET_LOADS_LITTLE='75 595200:78 883200:83 1324800:85 1555200:89'
TIMER_SLACK_LITTLE='90000'
TIMER_RATE_LITTLE='15000'
HISPEED_FREQ_LITTLE='1555200'
ABOVE_HISPEED_DELAY_LITTLE='0'
GO_HISPEED_LOAD_LITTLE='400'
MIN_SAMPLE_TIME_LITTLE='20000'
MAX_FREQ_HYSTERESIS_LITTLE='79000'
FAST_RAMP_DOWN_LITTLE='0'
USE_SCHED_LOAD_LITTLE='1'
BOOSTPULSE_DURATION_LITTLE='80000'

TARGET_LOADS_BIG='76 652800:79 1651200:86 2035200:91 2323200:95'
TIMER_SLACK_BIG='90000'
TIMER_RATE_BIG='15000'
HISPEED_FREQ_BIG='2361600'
ABOVE_HISPEED_DELAY_BIG='0'
GO_HISPEED_LOAD_BIG='400'
MIN_SAMPLE_TIME_BIG='20000'
MAX_FREQ_HYSTERESIS_BIG='79000'
FAST_RAMP_DOWN_BIG='0'
USE_SCHED_LOAD_BIG='1'
BOOSTPULSE_DURATION_BIG='80000'

#Generic CPU settings
TOUCHBOOST='0'
HMP_BIG_MAX_FREQ='${BIG_MAX_VALUE}'
HMP_BIG_MIN_FREQ="${BIG_MIN_VALUE}"
HMP_LITTLE_MAX_FREQ='${LITTLE_MAX_VALUE}'
HMP_LITTLE_MIN_FREQ="${LITTLE_MIN_VALUE}"
HMP_CPU0_ONLINE='1'
HMP_CPU1_ONLINE='1'
HMP_CPU2_ONLINE='1'
HMP_CPU3_ONLINE='1'
HMP_CPU4_ONLINE='1'
HMP_CPU5_ONLINE='1'
HMP_CPU6_ONLINE='1'
HMP_CPU7_ONLINE='1'
HMP_LITTLE_AFFECTED_CPUS='1 2 3 4'
HMP_BIG_AFFECTED_CPUS='4 5 6 7'

#########################################
# Heterogeneous Multi-Processing Tweaks #
#########################################

###############
# Misc Tweaks #
###############

CPUSET_BG='0-1'
CPUSET_SYSBG='0-1'

INPUT_BOOST_ENABLED='1'
INPUT_BOOST_FREQ='0:1036800 1:0 2:0 3:0 4:1132800 5:0 6:0 7:0'
INPUT_BOOST_MS='750'
SCHED_BOOST_ON_INPUT='N'

TCP_CONTROL='westwood'
TCP_LOW_LATENCY='0'

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

GPU_MAX_FREQ='710000000'
GPU_GOV='msm-adreno-tz'
ADRENOBOOST='2'

##############
# GPU Tweaks #
##############

#################
# Memory Tweaks #
#################

ENABLE_ADAPTIVE_LMK='0'
MINFREE='12288,15360,18432,21504,36864,53760'
DEBUG_LEVEL='0'

DIRTY_EXPIRE_CENTISECS='1500'
DITRY_WRITEBACK_CENTISECS='1500'
OOM_KILL_ALLOCATING_TASK='0'
PAGE_CLUSTER='3'
SWAPPINESS='30'
VFS_CACHE_PRESSURE='70'
DIRTY_RATIO='15'
DIRTY_BACKGROUND_RATIO='10'
MIN_FREE_KBYTES='41943'
OVERCOMMIT_MEMORY='1'
OVERCOMMIT_RATIO='50'

READ_WAKUP_THRESHOLD='128'
WRITE_WAKEUP_THRESHOLD='896'

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
	echo "${EAS_LITTLE_AFFECTED_CPUS}" > ${CPU}/cpufreq/policy0/affected_cpus
	echo "${EAS_BIG_AFFECTED_CPUS}" > ${CPU}/cpufreq/policy4/affected_cpus
}

HMP_tweaks() {
	#General HMP tweaks
	echo "${SCHED_UPMIGRATE}" > ${SCHED_PATH}/sched_upmigrate
	echo "${SCHED_GROUP_UPMIGRATE}" > ${SCHED_PATH}/sched_group_upmigrate
	echo "${SCHED_DOWNMIGRATE}" > ${SCHED_PATH}/sched_downmigrate
	echo "${SCHED_GROUP_DOWNMIGRATE}" > ${SCHED_PATH}/sched_group_downmigrate
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
	echo "${HMP_LITTLE_AFFECTED_CPUS}" > ${CPU}/cpufreq/policy0/affected_cpus
	echo "${HMP_BIG_AFFECTED_CPUS}" > ${CPU}/cpufreq/policy4/affected_cpus
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
		if grep 'cfq' ${Q_PATH}/scheduler; then
			echo "cfq" > ${Q_PATH}/scheduler
		else
			echo "	-Error Code #03"
		fi
		
		echo "1024" > ${Q_PATH}/read_ahead_kb
		echo "160" > ${Q_PATH}/nr_requests
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

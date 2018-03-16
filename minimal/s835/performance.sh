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

#schedutil gov tweaks
SCHEDUTIL_UP_RATE_LITTLE='500'
SCHEDUTIL_DOWN_RATE_LITTLE='20000'
SCHEDUTIL_IOWAIT_BOOST_LITTLE='1'
SCHEDUTIL_UP_RATE_BIG='500'
SCHEDUTIL_DOWN_RATE_BIG='20000'
SCHEDUTIL_IOWAIT_BOOST_BIG='1'
SCHEDUTIL_DYN_STUNE='0'

#Generic CPU settings
EAS_BIG_MAX_FREQ='2457400'
EAS_BIG_MIN_FREQ='806400'
EAS_LITTLE_MAX_FREQ="${LITTLE_MAX_VALUE}"
EAS_LITTLE_MIN_FREQ='518400'
##################################
# Energy-Aware Scheduling Tweaks #
##################################

#########################################
# Heterogeneous Multi-Processing Tweaks #
#########################################

#Interactive gov tweaks
TARGET_LOADS_LITTLE='74 518400:78 672000:81 883200:83 1248000:85 1478400:86 1670400:90 1824000:95'
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

TARGET_LOADS_BIG='78 652800:81 1056000:84 1344000:85 1651200:86 1958400:90 2342400:95'
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
HMP_BIG_MAX_FREQ="${BIG_MAX_VALUE}"
HMP_BIG_MIN_FREQ='806400'
HMP_LITTLE_MAX_FREQ="${LITTLE_MAX_VALUE}"
HMP_LITTLE_MIN_FREQ='518400'

#########################################
# Heterogeneous Multi-Processing Tweaks #
#########################################

###############
# Misc Tweaks #
###############

CPUSET_BG='0-3'
CPUSET_SYSBG='0-3'

INPUT_BOOST_ENABLED='0'
INPUT_BOOST_FREQ='0:0 1:0 2:0 3:0 4:0 5:0 6:0 7:0'
INPUT_BOOST_MS='0'

TCP_LOW_LATENCY='0'

###############
# Misc Tweaks #
###############

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
	
	#Little cluster governor tweaks
	echo "schedutil" > ${LITTLE_CLUSTER}/scaling_governor
	echo "schedutil" > ${BIG_CLUSTER}/scaling_governor
	
	echo "${SCHEDUTIL_UP_RATE_LITTLE}" > ${LITTLE_CLUSTER}/schedutil/up_rate_limit_us
	echo "${SCHEDUTIL_DOWN_RATE_LITTLE}" > ${LITTLE_CLUSTER}/schedutil/down_rate_limit_us
	echo "${SCHEDUTIL_IOWAIT_BOOST_LITTLE}" > ${LITTLE_CLUSTER}/schedutil/iowait_boost_enable
	
	echo "${SCHEDUTIL_UP_RATE_BIG}" > ${BIG_CLUSTER}/schedutil/up_rate_limit_us
	echo "${SCHEDUTIL_DOWN_RATE_BIG}" > ${BIG_CLUSTER}/schedutil/down_rate_limit_us
	echo "${SCHEDUTIL_IOWAIT_BOOST_BIG}" > ${BIG_CLUSTER}/schedutil/iowait_boost_enable
	
	echo "${SCHEDUTIL_DYN_STUNE}" > /sys/module/cpu_boost/parameters/dynamic_stune_boost
	
	echo "${EAS_LITTLE_MAX_FREQ}" > ${LITTLE_CLUSTER}/scaling_max_freq
	echo "${EAS_LITTLE_MIN_FREQ}" > ${LITTLE_CLUSTER}/scaling_min_freq
	echo "${EAS_BIG_MAX_FREQ}" > ${BIG_CLUSTER}/scaling_max_freq
	echo "${EAS_BIG_MIN_FREQ}" > ${BIG_CLUSTER}/scaling_min_freq
}

HMP_tweaks() {
	#Little cluster governor tweaks
	echo "interactive" > ${LITTLE_CLUSTER}/scaling_governor
	echo "interactive" > ${BIG_CLUSTER}/scaling_governor

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

	#Big cluster governor tweaks
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
	
	#Disable TouchBoost
	echo "${TOUCHBOOST}" > /sys/module/msm_performance/parameters/touchboost
	
	echo "${HMP_LITTLE_MAX_FREQ}" > ${LITTLE_CLUSTER}/scaling_max_freq
	echo "${HMP_LITTLE_MIN_FREQ}" > ${LITTLE_CLUSTER}/scaling_min_freq
	echo "${HMP_BIG_MAX_FREQ}" > ${BIG_CLUSTER}/scaling_max_freq
	echo "${HMP_BIG_MIN_FREQ}" > ${BIG_CLUSTER}/scaling_min_freq
}

extras() {
	local CPU_BOOST='/sys/module/cpu_boost/parameters'
	local NET='/proc/sys/net/ipv4'
	
	echo "${CPUSET_BG}" > /dev/cpuset/background/cpus
	echo "${CPUSET_SYSBG}" > /dev/cpuset/system-background/cpus
	
	#Tweak cpu boost
	echo "${INPUT_BOOST_ENABLED}" > ${CPU_BOOST}/input_boost_enabled
	echo "${INPUT_BOOST_FREQ}" > ${CPU_BOOST}/input_boost_freq
	echo "${INPUT_BOOST_MS}" > ${CPU_BOOST}/input_boost_ms

	#TCP tweaks
	echo "${TCP_LOW_LATENCY}" > ${NET}/tcp_low_latency
}

main() {
	kernel_detection  #Detect whether the kernel is EAS or HMP
	
	chmod 664 ${LITTLE_CLUSTER}/scaling_max_freq # set correct perm to access this tunable
	
	if [ "${EAS}" -eq "1" ]; then
		EAS_tweaks #If EAS is detected, apply EAS specific tweaks
	elif [ "${HMP}" -eq "1" ]; then
		HMP_tweaks #If HMP is detected, apply HMP specific tweaks
	fi
	
	extras #Apply extra kernel tweaks
}

main #Execute main

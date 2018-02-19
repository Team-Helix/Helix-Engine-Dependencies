#!/system/bin/sh
#Original author: Alcolawl
#Original script By: RogerF81 + adanteon
#Settings By: RogerF81
#Device: OnePlus 5
#Codename: SoilWork UNIFIED
#SoC: Snapdragon 835
#Last Updated: 05/02/2018
#Credits: @Alcolawl @soniCron @Asiier @Freak07 @Mostafa Wael @Senthil360 @TotallyAnxious @RenderBroken @ZeroInfinity @Kyuubi10 @ivicask @RogerF81 @joshuous @boyd95 @ZeroKool76 @adanteon
codename=Soilwork
stype=boot
version=V3.0
cdate=$(date)
#Initializing log


#Disable BCL
if [ -e "/sys/devices/soc/soc:qcom,bcl/mode" ]; then
	chmod 644 /sys/devices/soc/soc:qcom,bcl/mode
	echo -n disable > /sys/devices/soc/soc:qcom,bcl/mode
fi

#Stopping perfd
if [ -e "/data/vendor/perfd" ]; then
	stop perfd
	#rm /data/vendor/perfd/default_values
fi

#Turn off core_control
echo 0 > /sys/module/msm_thermal/core_control/enabled


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


#Enable work queue to be power efficient
if [ -e /sys/module/workqueue/parameters/power_efficient ]; then
	chmod 644 /sys/module/workqueue/parameters/power_efficient
	echo Y > /sys/module/workqueue/parameters/power_efficient
	chmod 444 /sys/module/workqueue/parameters/power_efficient
fi

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

#Disable TouchBoost	-- HMP only
if [ -e "/sys/module/msm_performance/parameters/touchboost" ]; then
	chmod 644 /sys/module/msm_performance/parameters/touchboost
	echo 0 > /sys/module/msm_performance/parameters/touchboost
fi

#TCP tweaks
if grep 'westwood' /proc/sys/net/ipv4/tcp_available_congestion_control; then
	echo westwood > /proc/sys/net/ipv4/tcp_congestion_control
else
	echo cubic > /proc/sys/net/ipv4/tcp_congestion_control
fi
echo 2 > /proc/sys/net/ipv4/tcp_ecn
echo 1 > /proc/sys/net/ipv4/tcp_dsack
echo 1 > /proc/sys/net/ipv4/tcp_low_latency
echo 1 > /proc/sys/net/ipv4/tcp_timestamps
echo 1 > /proc/sys/net/ipv4/tcp_sack
echo 1 > /proc/sys/net/ipv4/tcp_window_scaling


# #Wakelocks
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

##LMK
if [ -e "/sys/module/lowmemorykiller/parameters/enable_adaptive_lmk" ]; then
	chmod 664 /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
	chown root /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
	echo 0 > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
	chmod 444 /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
fi

chmod 644 /sys/module/lowmemorykiller/parameters/debug_level
echo 0 > /sys/module/lowmemorykiller/parameters/debug_level
chmod 444 /sys/module/lowmemorykiller/parameters/debug_level

if [ -e "/sys/module/lowmemorykiller/parameters/minfree" ]; then
	echo "18432,23040,27648,32256,55296,80640" > /sys/module/lowmemorykiller/parameters/minfree
fi

# Low Power Modes ## EXPERIMENTAL
echo N > /sys/module/lpm_levels/parameters/sleep_disabled
# On debuggable builds, enable console_suspend if uart is enabled to save power
# Otherwise, disable console_suspend to get better logging for kernel crashes
# if [[ $(getprop ro.debuggable) == "1" && ! -e /sys/class/tty/ttyHS0 ]]
# then
    # echo Y > /sys/module/printk/parameters/console_suspend
# fi

# Disable Gentle Fair Sleepers ##EXPERIMENTAL
if [ -e "/sys/kernel/debug/sched_features" ]; then
	echo NO_GENTLE_FAIR_SLEEPERS > /sys/kernel/debug/sched_features
	echo NO_NEW_FAIR_SLEEPERS >> /sys/kernel/debug/sched_features
	echo NO_NORMALIZED_SLEEPER >> /sys/kernel/debug/sched_features
fi

#loop tweaks
for i in /sys/block/loop*; do
   echo 0 > $i/queue/add_random
   echo 0 > $i/queue/iostats
   echo 1 > $i/queue/nomerges
   echo 0 > $i/queue/rotational
   echo 1 > $i/queue/rq_affinity
done

#ram tweaks
for j in /sys/block/ram*; do
   echo 0 > $j/queue/add_random
   echo 0 > $j/queue/iostats
   echo 1 > $j/queue/nomerges
   echo 0 > $j/queue/rotational
   echo 1 > $j/queue/rq_affinity
done

#Turn on cores
chmod 664 /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
chmod 664 /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
chmod 664 /sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq
chmod 664 /sys/devices/system/cpu/cpufreq/policy4/scaling_min_freq
echo $little_max_value > /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
echo $little_min_value > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
echo $big_max_value > /sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq
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

#Starting perfd
if [ -e "/data/vendor/perfd" ]; then
	start perfd
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

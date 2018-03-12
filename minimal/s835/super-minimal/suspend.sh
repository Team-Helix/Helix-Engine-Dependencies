#!/system/bin/sh
# AUTHOR: TEAM HELIX @ XDA-DEVELOPERS
# Template by @ZeroInfinity, adapted from @RogerF81, improved by @Asiier
# Helix-Engine profile script: Balanced

echo '1056000' > /sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq
echo '300000' > /sys/devices/system/cpu/cpufreq/policy4/scaling_min_freq
echo '1036800' > /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
echo '300000' > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
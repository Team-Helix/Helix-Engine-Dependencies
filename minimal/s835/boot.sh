#!/system/bin/sh
# AUTHOR: TEAM HELIX @ XDA-DEVELOPERS
# Template by @ZeroInfinity, adapted from @RogerF81, improved by @Asiier
# Helix-Engine profile script: Boot

NET='/proc/sys/net/ipv4'
TCP_CONTROL='westwood'

echo "${TCP_CONTROL}" > ${NET}/tcp_congestion_control

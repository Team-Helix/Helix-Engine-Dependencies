#!/system/bin/sh
# AUTHOR: TEAM HELIX @ XDA-DEVELOPERS
# Template by @ZeroInfinity, adapted from @RogerF81, improved by @Asiier
# Helix-Engine profile script: Boot
MEMTOTAL="$(< /proc/meminfo grep MemTotal | cut -d ":" -f2 | awk '{ print $1 }')"
NET='/proc/sys/net/ipv4'
LMK='/sys/module/lowmemorykiller/parameters/minfree'

TCP_CONTROL='westwood'

chmod 664 ${LMK}
chmod 664 ${NET}/tcp_congestion_control

if [ "${MEMTOTAL}" -gt "7361536" ] && [ "${MEMTOTAL}" -lt "8388608" ]; then
	echo '8192,10240,12288,14336,24576,35840' > ${LMK}
elif [ "${MEMTOTAL}" -gt "5242880" ] && [ "${MEMTOTAL}" -lt "6291456" ]; then
	echo '12288,15360,18432,21504,36864,53760' > ${LMK}
elif [ "${MEMTOTAL}" -gt "3145728" ] && [ "${MEMTOTAL}" -lt "4378624" ]; then
	echo '18432,23040,27648,32256,55296,80640' > ${LMK}
elif [ "${MEMTOTAL}" -gt "2097152" ] && [ "${MEMTOTAL}" -lt "3145728" ]; then
	echo '16662,20828,24993,29159,45600,67650' > ${LMK}
elif [ "${MEMTOTAL}" -gt "1048576" ] && [ "${MEMTOTAL}" -lt "2097152" ]; then
	echo '14746,18432,22118,25805,40000,55000' > ${LMK}
fi

echo "${TCP_CONTROL}" > ${NET}/tcp_congestion_control

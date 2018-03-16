#!/system/bin/sh
# AUTHOR: TEAM HELIX @ XDA-DEVELOPERS
# Template by @ZeroInfinity, adapted from @RogerF81, improved by @Asiier
# Helix-Engine profile script: Boot
MEMTOTAL="$(< /proc/meminfo grep MemTotal | cut -d ":" -f2 | awk '{ print $1 }')"
LMK='/sys/module/lowmemorykiller/parameters'

chmod 644 ${LMK}/enable_adaptive_lmk
chmod 664 ${LMK}/minfree

echo '0' > ${LMK}/enable_adaptive_lmk

if [ "${MEMTOTAL}" -gt "7361536" ] && [ "${MEMTOTAL}" -lt "8388608" ]; then
	echo '55296,82944,96768,144756,168750,243750' > ${LMK}/minfree
	echo '80' > /proc/sys/vm/overcommit_ratio
elif [ "${MEMTOTAL}" -gt "5242880" ] && [ "${MEMTOTAL}" -lt "6291456" ]; then
	echo '41472,62208,72576,108567,126562,182812' > ${LMK}/minfree
	echo '70' > /proc/sys/vm/overcommit_ratio
elif [ "${MEMTOTAL}" -gt "3145728" ] && [ "${MEMTOTAL}" -lt "4378624" ]; then
	echo '27648,41472,48384,72378,84375,121875' > ${LMK}/minfree
	echo '60' > /proc/sys/vm/overcommit_ratio
elif [ "${MEMTOTAL}" -gt "2097152" ] && [ "${MEMTOTAL}" -lt "3145728" ]; then
	echo '19662,28828,24993,29159,45600,67650' > ${LMK}/minfree
	echo '50' > /proc/sys/vm/overcommit_ratio
elif [ "${MEMTOTAL}" -gt "1048576" ] && [ "${MEMTOTAL}" -lt "2097152" ]; then
	echo '14746,12432,22118,25805,40000,55000' > ${LMK}/minfree
	echo '50' > /proc/sys/vm/overcommit_ratio
fi

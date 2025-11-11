# generate dynamic part of conky config
# Accepts three positional arguments:
#   category name color
#   data name color
#   third field color

# Number of days since some important event with thousand separator
LC_ALL=lv_LV.UTF-8 printf "${1}===  Day %'.f   ===\n" $(( ($(date +%s) - $(date -d "1990-06-16" +%s)) / (60 * 60 * 24) +1))
echo ""
echo "${1}----\${nodename}----"
echo "${2}Linux:\${color} \${kernel}"
echo "${2}Since:\${color} $(stat -c '%y' /etc/hostname | sed -r 's/\..*$//')"
echo "${2}Uptime:\${color} \${uptime}"
echo ""
echo "${2}CPU temp:\${color} \${acpitemp}°C"
echo "${2}RAM:\${color} \${mem} / \${memmax} ${3}\${memperc}%"
echo "${2}SWAP:\${color} \${swap} / \${swapmax} ${3}\${swapperc}%"
echo "${2}Battery:\${color} \${battery_time} ${3}\${battery_short}"

echo ""
lsblk --pairs --output='MOUNTPOINT' | while IFS='' read -r line
do
  eval $line
  if [[ ! -d "${MOUNTPOINT}" || -z "${MOUNTPOINT}" ]]
  then
    continue
  fi
  dir=`dirname ${MOUNTPOINT} | sed -r 's|/([^/]{,2})[^/]*|/\1|g'`
  base="`basename ${MOUNTPOINT}`"
  echo -n ${2}`echo "${dir}/${base}" | sed -r 's|/{2,}|/|g'`
  echo ":\${color} \${fs_used ${MOUNTPOINT}} / \${fs_size ${MOUNTPOINT}} ${3}\${fs_used_perc ${MOUNTPOINT}}%"
done

echo ""
for iface in $(ip -j -p link | jq -r '.[1:] | .[] | .ifname')
do
  echo "${2}${iface}:\${color} \${if_up ${iface}}\${addr ${iface}}\${endif}"
done

echo ""
echo "${1}----Mails----"

#sed -r '/^virtual-mailboxes/!d; s/^.*\s+"(.*)"\s+"notmuch:\/\/\?query=(.*)"/'"${2}"'\1: ${color}${execi 15 "notmuch count tag:unread and \2"}/' .config/mutt/personal
sed -r 's/^([^=]*)=(.*)/'"${2}"'\1: ${color}${execi 15 "notmuch count tag:unread and \2"}/' .config/aerc/tags.conf

#echo ""
#echo "${1}----Events----\${color}"
#remind -h -g ~/.config/remind/init.rem | awk 'NR > 2 && NF > 0 { if ($1 == "on") {print substr($0, 4)} else {print}}'

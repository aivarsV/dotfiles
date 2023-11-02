# generate dynamic part of conky config
# Accepts three positional arguments:
#   category name color
#   data name color
#   third field color

echo ""
echo "${1}----Mounts----"
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
echo "${1}----Addresses----"
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

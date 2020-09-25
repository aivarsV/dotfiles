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
maildir=`sed -r '1,1s/^[^=]* = //1;2,$d' ~/.mailboxes`
sed -r '1d; 2s/^mailboxes "\+(.*)"$/\1/; s/" "\+/\n/g' ~/.mailboxes | while IFS='' read -r box
do
  echo -n "${2}`echo ${box} | sed -r 's|^([^/]*).*/([^/]*)$|\1/\2|'`: "
  echo "\${color}\${unseen_mails ${maildir}${box}}"
done

if [[ -z "$1" ]]
then
  query="not tag:newsletters"
else
  query="from:'$1' and not tag:newsletters"
fi
notmuch address --deduplicate=address ${query} | awk '{if (NF == 1) {print; } else { gsub("[<,>]","",$NF); printf "%s\t", $NF; for (i=1; i<NF; i++) { gsub("\"", "", $i); printf("%s%s", $i, (i<NF-1 ? OFS : ORS)); }}}'

gpg --decrypt --output - ~/.mail_addreses 2>/dev/null | awk '{if ($0 ~ "'${1}'") {gsub("\036", "\t", $0); print;}}'

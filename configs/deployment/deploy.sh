#!/bin/sh
set -eu

# Retrieve information about the operating system
while IFS= read -r LINE; do
  eval "$LINE"
done < /etc/os-release

ID1=`echo $ID | awk '{ string=substr($0, 1, 1); print string; }' | tr '[:lower:]' '[:upper:]'`
ID2=`echo $ID | awk -v len=${#ID} '{ string=substr($0, 2, len - 1); print string; }' | tr '[:upper:]' '[:lower:]'`
ID=${ID1}${ID2}
unset ID1 ID2

# Determine available web transfer tool
if type wget >&-; then
  _WGET=`command -v wget`
  alias GETCMD="${_WGET} -qO-"
  unset _WGET
elif type curl >&-; then
  _CURL=`command -v curl`
  alias GETCMD="${_CURL} -sSo-"
fi

if [ -z ${GETCMD:-} ]; then
  echo "No webtool found. Install curl/wget and try again."
  exit 1
fi

# Get available deployment scripts
$GETCMD https://api.github.com/repos/phenonymous/linux/contents/configs/deployment | grep -Po '(?!["name": "].+(?="))' |\
while IFS= read -r JSON_NAME; do
  [ $ID = $JSON_NAME ] && OS_MATCH=1
done

if [ ${OS_MATCH:-} -ne 1 ]; then
  echo "No deployment script found for this OS"
  exit 1
fi

$GETCMD https://api.github.com/repos/phenonymous/linux/contents/configs/deployment/$ID | grep -Po '(?!["name": "].+(?="))' |\
while IFS= read -r JSON_NAME; do
  [ $VERSION = $JSON_NAME ] && VERSION_MATCH=1
done

if [ ${VERSION_MATCH:-} -ne 1 ]; then
  echo "No deployment script found for this OS-version"
  exit 1
fi

exec $SH_AVAILABLE -c 'eval $(command curl -sSo- "https://raw.githubusercontent.com/phenonymous/linux/master/configs/deployment/'$ID'/'$VERSION'/deploy.sh")'

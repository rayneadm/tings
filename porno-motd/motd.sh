#!/bin/bash
make_gradient_line() {
  local text="$1"
  local colors=(71 107 143 179 215 216 217 218 219 183 147 111 75)
  local out=""
  local len=${#text}
  local clen=${#colors[@]}
  for ((i=0; i<len; i++)); do
    color=${colors[i*clen/len]}
    out+="$(tput setaf "$color")${text:i:1}"
  done
  out+="$(tput sgr0)"
  echo "$out"
}
make_gradient_sep() {
  local text="$1"
  local colors=( 22 28 34 40 112 118 154)
  local out=""
  local len=${#text}
  local clen=${#colors[@]}
  for ((i=0; i<len; i++)); do
    color=${colors[i*clen/len]}
    out+="$(tput setaf "$color")${text:i:1}"
  done
  out+="$(tput sgr0)"
  echo "$out"
}
make_gradient_fqdn() {
  local text="$1"
  local colors=(80 81 117 153 189 188 187 223 222 221 215 214 208 202)
  local out=""
  local len=${#text}
  local clen=${#colors[@]}
  for ((i=0; i<len; i++)); do
    color=${colors[i*clen/len]}
    out+="$(tput setaf "$color")${text:i:1}"
  done
  out+="$(tput sgr0)"
  echo "$out"
}

RESET="\033[0m"
OS_C="\033[38;5;52m"
KRL_C="\033[38;5;88m"
IP_C="\033[38;5;196m"
UPT_C="\033[38;5;88m"
LOD_C="\033[38;5;124m"
MEM_C="\033[38;5;166m"
DIS_C="\033[38;5;208m"
DD_C="\033[38;5;74m"
DRP_C="\033[38;5;12m"
BLK_C="\033[38;5;196m"
TTL_C="\033[38;5;111m"

LINE_TEXT="============================================================"
LINE="$(make_gradient_line "$LINE_TEXT")"
LINE_SEP="------------------------------------------------------------"
SEP="$(make_gradient_sep "$LINE_SEP")"

HOSTNAME_FQDN="$(make_gradient_fqdn "$(hostname -f 2>/dev/null || hostname)")"
OS_NAME="$(lsb_release -ds 2>/dev/null || grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')"
KERNEL="$(uname -r)"
IP_ADDR="$(hostname -I | awk '{print $1}')"
UPTIME="$(uptime -p)"
## Debian LOAD="$(cut -d' ' -f1-3 /proc/loadavg)"
LOAD="$(cat /proc/loadavg)" ## RHEL
MEMORY="$(free -h | awk '/Mem:/ {print $3 "/" $2}')"
DISK_ROOT="$(df -h / | awk 'NR==2 {print $3 "/" $2 " (" $5 ")"}')"



echo "$LINE"

printf "${TTL_C} Hostname ${DD_C}: %s$HOSTNAME_FQDN\n"
printf "${TTL_C} OS       ${DD_C}: ${OS_C}%s${RESET}\n" "$OS_NAME"
printf "${TTL_C} Kernel   ${DD_C}: ${KRL_C}%s${RESET}\n" "$KERNEL"
printf "${TTL_C} IP       ${DD_C}: ${IP_C}%s${RESET}\n" "$IP_ADDR"

echo "$SEP"

printf "${TTL_C} Uptime   ${DD_C}: ${UPT_C}%s${RESET}\n" "$UPTIME"
printf "${TTL_C} Load     ${DD_C}: ${LOD_C}%s${RESET}\n" "$LOAD"
printf "${TTL_C} Memory   ${DD_C}: ${MEM_C}%s${RESET}\n" "$MEMORY"
printf "${TTL_C} Disk /   ${DD_C}: ${DIS_C}%s${RESET}\n" "$DISK_ROOT"

echo "$LINE"

printf "%b\n" "$RESET"


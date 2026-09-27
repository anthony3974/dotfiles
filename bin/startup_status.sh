#!/bin/bash

# version 1.2

load=$(uptime | awk -F'load average: ' '{ print $2 }' | cut -d, -f1)
processes=$(ps ax | wc -l)
disk_usage=$(df -h / | awk 'NR==2 { print $5 " of " $2 }')
users=$(who | wc -l)
mem_used=$(free | awk '/Mem/ { printf("%.0f", $3/$2 * 100) }')
swap_used=$(free | awk '/Swap/ { if ($2 == 0) print "0"; else printf("%.0f", $3/$2 * 100) }')
ip_address=$(ip -4 addr show scope global | awk '/inet / {print $2}' | cut -d/ -f1 | head -n1)
ip_addressvpn=$(ip -4 addr show dev tailscale0 2>/dev/null | awk '/inet / {print $2}' | cut -d/ -f1)

mem_used_gb=$(free -g | awk '/Mem/ {print $3 "G"}')
mem_total_gb=$(free -g | awk '/Mem/ {print $2 "G"}')

swap_used_gb=$(free -g | awk '/Swap/ {print $3 "G"}')
swap_total_gb=$(free -g | awk '/Swap/ {print $2 "G"}')

printf "  System load:  %-20s Processes:             %s\n" "$load" "$processes"
printf "  Usage of /:   %-20s Users logged in:       %s\n" "$disk_usage" "$users"
#printf "  Memory usage: %-20s IPv4 address for eth0: %s\n" "${mem_used}%" "$ip_address"
#printf "  Swap usage:   %-20s IPv4 address for tail: %s\n" "$swap_used"% "$ip_addressvpn"

printf "  Memory usage: %-20s IPv4 address for eth0: %s\n" \
"${mem_used}% (${mem_used_gb}/${mem_total_gb})" "$ip_address"

printf "  Swap usage:   %-20s IPv4 address for tail: %s\n" \
"${swap_used}% (${swap_used_gb}/${swap_total_gb})" "$ip_addressvpn"

#!/usr/bin/env bash

clear

if [[ $(id -u) -ne 0 ]]; then
    echo "This script must be run as superuser."
    exit 99
fi

LOGDIR="/var/log/performance-monitor"
LOGFILE="$LOGDIR/status"

LINE1="##########################################################################################"
LINE2="=========================================================================================="
LINE3='>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
mkdir -p $LOGDIR

# install/update required apps
apt install lm-sensors iperf3 -qq

main() {
    echo $LINE1
    echo "##"
    echo "## [:S:] STARTING ON $(date)"
    echo "##"
    echo $LINE1
    echo
    
    echo $LINE2
    echo "## SENSORS"
    echo $LINE2
    sensors
    echo
    
    echo $LINE2
    echo "## TOP - SORT BY CPU"
    echo $LINE2
    top -bcn1 -o +%CPU -w 512 | head -n20
    echo
    
    echo $LINE2
    echo "## TOP - SORT BY MEMORY"
    echo $LINE2
    top -bcn1 -o +%MEM -w 512 | head -n20
    echo
    
    echo $LINE2
    echo "## MEMORY USAGE"
    echo $LINE2
    free -h
    echo
    
    echo $LINE2
    echo "## MOUNT LIST"
    echo $LINE2
    mount
    echo
    
    echo $LINE2
    echo "## LIST GANGLIA & MOOSE"
    echo $LINE2
    ls /ganglia /moose
    echo
    
    #echo $LINE2
    #echo "## CONNECTION TO NETWORK SPEEDTEST"
    #echo $LINE2
    #iperf3 -c kabila
    #echo
    
    echo $LINE2
    echo "## LAST 20 LINES FROM SYSLOG"
    echo $LINE2
    grep -v "CRON" /var/log/syslog | tail -n20
    echo
    
    echo -e "${LINE3}${LINE3}"
    echo ; echo
}

if [[ -z $TERM ]]; then
    main 2>&1 >> $LOGFILE
else
    main 2>&1 | tee -a $LOGFILE
fi

exit 0

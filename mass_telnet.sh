#!/usr/bin/sh

#----------------------------------------------------------------------#
#       Script:         mass_telnet.sh
#       Description:    Check if server have telnet to specific port for IP list.
#       Author:         Krasimir Petrov
#       Usage:          Only on Unix Platforms
#                       For linux you have to add "-e" to echo
#----------------------------------------------------------------------#

if [ -z "$1" ] || [ -z "$2" ]
then

echo "Please specify IP list and port for testing."
echo "Example : # mass_telnet.sh /full/path/to/list <port>"

else

## Set timeout for telnet
TIMEOUT=5

IP_list="$1"
PORT="$2"
SCRIPTPATH=$(dirname $0)
TMP_TXT="$SCRIPTPATH/mass_telnet.tmp"
RESULTS="$SCRIPTPATH/mass_telnet_results"
TMP_LOG="$SCRIPTPATH/mass_telnet.log"
> $TMP_LOG
> $RESULTS

### For Unix
echo "\035" > $TMP_TXT

### For Linux
#echo -e "\035" > $TMP_TXT

        echo "---------------------" >> $RESULTS
        echo "IP       | Port: $PORT" >> $RESULTS
        echo "---------------- ----" >> $RESULTS
        echo "Processing ...."
        echo "Please wait"

        cat $IP_list | while read ip

        do
        #Check if target IP is reachable via specific port.

        telnet $ip $PORT < $TMP_TXT >> $TMP_LOG& sleep $TIMEOUT ; kill $! >> $TMP_LOG 2>&1

                if [ $? = 0 ]
                then
                telnetStatus="FAIL"
                else
                telnetStatus="OK"
                fi

        printf "%-16s %-4s\n" $ip $telnetStatus >> $RESULTS
        done

cat $RESULTS

fi

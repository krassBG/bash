#!/bin/bash


for i in $( cat /var/opt/OV/conf/OpC/ps_mon.cfg|grep -v ^$|grep -v ^#|grep -v '^\[' |grep -i linux|awk '{print $1}' ) ;
        do
                case "$i" in
                "syslogd") sed -i '/^syslogd /a *ACTION service syslog restart' /var/opt/OV/conf/OpC/ps_mon.cfg
                        ;;
                "ntpd") sed -i '/^ntpd  /a *ACTION service ntpd restart' /var/opt/OV/conf/OpC/ps_mon.cfg
                        ;;
                "python") sed -i   '/^"*PATH /opt/opsware/agent/bin/" /a *ACTION /etc/init.d/opsware-agent restart ' /var/opt/OV/conf/OpC/ps_mon.cfg
                        ;;
                "rsyslogd")     sed -i '/^rsyslogd  /a *ACTION service rsyslog restart' /var/opt/OV/conf/OpC/ps_mon.cfg
                        ;;
                esac
        done;
for j in $( cat /var/opt/OV/conf/OpC/ps_mon.cfg|grep -v ^$|grep -v ^#|grep -v '^\[' |grep -i mwa|awk '{print $1}' ) ;
        do
                case "$j" in
                "midaemon") sed -i '/^midaemon /a *ACTION /opt/OV/bin/OpC/opcagt -stop && /opt/perf/bin/ovpa stop && /opt/OV/bin/ovc -kill && /opt/perf/bin/ttd -k&&/opt/OV/bin/ovc -start && /opt/OV/bin/OpC/opcagt -start && /opt/perf/bin/ovpa start' /var/opt/OV/conf/OpC/ps_mon.cfg
                        ;;
                "scopeux") sed -i '/^scopeux /a *ACTION /opt/OV/bin/OpC/opcagt -stop && /opt/perf/bin/ovpa stop && /opt/OV/bin/ovc -kill && /opt/perf/bin/ttd -k&&/opt/OV/bin/ovc -start && /opt/OV/bin/OpC/opcagt -start && /opt/perf/bin/ovpa start' /var/opt/OV/conf/OpC/ps_mon.cfg
                        ;;
                "ttd") sed -i '/^ttd /a *ACTION /opt/OV/bin/OpC/opcagt -stop && /opt/perf/bin/ovpa stop && /opt/OV/bin/ovc -kill && /opt/perf/bin/ttd -k&&/opt/OV/bin/ovc -start && /opt/OV/bin/OpC/opcagt -start && /opt/perf/bin/ovpa start' /var/opt/OV/conf/OpC/ps_mon.cfg
                        ;;
                "perfalarm") sed -i '/^perfalarm /a *ACTION /opt/OV/bin/OpC/opcagt -stop && /opt/perf/bin/ovpa stop && /opt/OV/bin/ovc -kill && /opt/perf/bin/ttd -k&&/opt/OV/bin/ovc -start && /opt/OV/bin/OpC/opcagt -start && /opt/perf/bin/ovpa start' /var/opt/OV/conf/OpC/ps_mon.cfg
                       ;;
                        esac
        done;
exit 0

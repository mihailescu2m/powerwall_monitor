#!/bin/sh
# Start/stop cookieproxy
#
### BEGIN INIT INFO
# Provides:          cron
# Required-Start:    $network
# Required-Stop:     $network
# Default-Start:     2 3 4 5
# Default-Stop:
# Short-Description: CookieProxy is used to proxy telegraf connections with cookies
# Description:       Telegraf doesn't work well with connecitons that need
#                    cookies. CookieProxy can work as a shim to proxy through to
#                    hosts that need cookies.
### END INIT INFO


PATH=/bin:/usr/bin:/sbin:/usr/sbin
DESC="cookieproxy"
NAME=cookieproxy
DAEMON=/cookieproxy
PIDFILE=/var/run/cookieproxy.pid
SCRIPTNAME=/etc/init.d/"$NAME"
EXTRA_OPTS="-cookiejar /tmp/cookies/powerwall.txt"
STDOUT=/dev/null
STDERR=/dev/null

test -f $DAEMON || exit 0

. /lib/lsb/init-functions

case "$1" in
start)  log_daemon_msg "Starting Telegraf cookie aware proxy" "cookieproxy"
        start-stop-daemon --start --quiet --pidfile $PIDFILE --exec $DAEMON -- $EXTRA_OPTS >>$STDOUT 2>>$STDERR &
        log_end_msg $?
        ;;
stop)   log_daemon_msg "Stopping Telegraf cookie aware proxy" "cookieproxy"
        killproc -p $PIDFILE $DAEMON
        RETVAL=$?
        [ $RETVAL -eq 0 ] && [ -e "$PIDFILE" ] && rm -f $PIDFILE
        log_end_msg $RETVAL
        ;;
restart) log_daemon_msg "Restarting Telegraf cookie aware proxy" "cookieproxy"
        $0 stop
        $0 start
        ;;
reload|force-reload) log_daemon_msg "Reloading configuration files for Telegraf cookie aware proxy" "cookieproxy"
        # there is no real way to reload cookieproxy right now
	$0 stop
	$0 start
        ;;
status)
        status_of_proc -p $PIDFILE $DAEMON $NAME && exit 0 || exit $?
        ;;
*)      log_action_msg "Usage: /etc/init.d/cookieproxy {start|stop|status|restart|reload|force-reload}"
        exit 2
        ;;
esac
exit 0


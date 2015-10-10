#!/bin/bash

 ### BEGIN INIT INFO
 # Provides:   asset_server
 # Required-Start: $local_fs $remote_fs
 # Required-Stop:  $local_fs $remote_fs
 # Should-Start:   $network
 # Should-Stop:    $network
 # Default-Start:  2 3 4 5
 # Default-Stop:   0 1 6
 # Short-Description:    Asset Server
 # Description:    Exposes /opt/assets as a file share over HTTP.
 ### END INIT INFO
 
 #Settings
 SERVICE='python -m SimpleHTTPServer'
 
start_serving() {
  cd /opt/assets
  $SERVICE
}

stop_serving() {
  
}

 #Start-Stop here
 case "$1" in
   start)
     start_serving
     ;;
   stop)
     stop_serving
     ;;
   restart)
     stop_serving
     start_serving
     ;;
   status)
     if pgrep -u $USERNAME -f $SERVICE > /dev/null
     then
       echo "$SERVICE is running."
     else
       echo "$SERVICE is not running."
     fi
     ;;
   command)
     if [ $# -gt 1 ]; then
       shift
       mc_command "$*"
     else
       echo "Must specify server command (try 'help'?)"
     fi
     ;;
 
   *)
   echo "Usage: $0 {start|stop|status|restart|}"
   exit 1
   ;;
 esac
 
 exit 0
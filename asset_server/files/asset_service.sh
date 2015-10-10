#!/bin/bash

# Credit to https://github.com/psobko/PythonSimpleHTTPServerStart/blob/master/startServer.sh
# this is partially based on that code.


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
 
start_serving() {
  echo "-----Starting python SimpleHTTPServer-----"

  #check for existing process and error if found
  existing_pid=$(ps aux | grep '[p]ython -m SimpleHTTPServer' | awk '{print $2}')
  if [[ ! -z "$existing_pid" ]]
  then
    echo "Existing SimpleHTTPServer found - Exiting."
  fi
  #set the current dir as the working directory
  cd /opt/assets
  python -m SimpleHTTPServer 8081 > /dev/null 2&>1&

  #get the PID for the process
  server_pid=$!
  echo $server_pid > /opt/processes/SimpleHTTPServer.pid
  echo "   Serving HTTP on http://0.0.0.0:8081"

  #prompt to open in browser
}

stop_serving() {
  kill -9 `cat /opt/processes/SimpleHTTPServer.pid`
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
   command)
     if [ $# -gt 1 ]; then
       shift
       mc_command "$*"
     else
       echo "Must specify server command (try 'help'?)"
     fi
     ;;
 
   *)
   echo "Usage: $0 {start|stop|restart}"
   exit 1
   ;;
 esac
 
 exit 0
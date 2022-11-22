#!/bin/bash
start() {
    echo -e "\nSwapping out application config file\n"
    ln -s /etc/hosts link
}

stop () {
    echo -e "\nRemoving config files\n"
    rm link
}

case "$1" in
    start)
      start
      ;;

    stop)
      stop
      ;;

    *)
      echo -e "\n--------------------\n\"$1\" is an uknown parameter. \nUsage: $0 {start|stop}\n--------------------\n"
      ;;
esac
exit 0

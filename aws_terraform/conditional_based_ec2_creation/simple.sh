#!/bin/bash
echo "Script execution time at:" $(date '+%Y-%m-%d %H:%M:%S')
echo ""
EXECUTOR_NAME=$(whoami)
echo "Executor name is:" $EXECUTOR_NAME
sleep 2
SCRIPT_DIR=$(pwd)
echo "Script directory is:" $SCRIPT_DIR
sleep 2
echo "Listing the files in the dir $SCRIPT_DIR "
ls -lrt $SCRIPT_DIR
sleep 2
exit 0

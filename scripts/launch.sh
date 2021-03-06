#!/bin/bash

#sudo chmod 777 /dev/ttyACM*

IP=`ifconfig wlan2 2>/dev/null|awk '/inet addr:/ {print $2}'|sed 's/addr://'`

export ROS_HOSTNAME=$IP
export ROS_MASTER_URI=http://$IP:11311

[[ ":$PYTHONPATH:" != *"threespace"* ]] && export PYTHONPATH="${PYTHONPATH}:~/myocp/myo/src/threespace/threespace"


#PID=`ps aux | grep '[r]ecognizer.py'`
#if [[ "" !=  "$PID" ]]; then
#  echo "killing speech recognizer process $PID"
#  kill -9 $PID
#fi

#source ~/myocp/myo/devel/setup.bash

NODE=`rosnode list | grep record`
if [[ "" !=  "$NODE" ]]; then
  echo "killing rosbag node"
  rosnode kill $NODE
fi

mkdir -p user_data

roslaunch exercise_interface interface.launch

rosnode kill -a
ps -aux |grep gnome-terminal | awk '{print $2}' | xargs kill


#!/bin/bash
set -e

ttk='--->'
WORKDIR=$(pwd)

#echo "${ttk} WORKDIR (${WORKDIR})content"
#ls -lah ${WORKDIR}

echo "${ttk} Check artifact presence"
ls -lah ../ros2_ws/install

#ls -lah /builds/sl/ros2_ws/install/zed_interfaces/share/zed_interfaces/
#ls -lah /builds/sl/ros2_ws/install/zed_components/share/zed_components/
#ls -lah /builds/sl/ros2_ws/install/zed_wrapper/share/zed_wrapper/
#ls -lah /builds/sl/ros2_ws/install/zed_ros2/share/zed_ros2/

echo "${ttk} Initialize local ROS2 environment"
cd ${WORKDIR}
source ../ros2_ws/install/local_setup.bash
env | grep COLCON
env | grep ROS

echo "${ttk} Check ROS2 installation"
ros2 doctor -r

echo "${ttk} Check ZED ROS2 packages presence"
ros2 pkg list | grep zed

echo "${ttk} USB peripherals"
lsusb

echo "${ttk} Test node running for 20 seconds"
timeout --signal=SIGINT 15s ros2 launch zed_wrapper zed2.launch.py

exit 0

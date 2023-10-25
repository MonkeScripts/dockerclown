#!/bin/bash
#set -e

function ros_source_env() 
{
	if [ -f "$1" ]; then
		echo "sourcing   $1"
		source "$1"
	else
		echo "notfound   $1"
	fi	
}
source "/opt/ros/humble/setup.bash"
# ros_source_env "$ROS_ROOThumble/setup.bash"

	#echo "ROS_PACKAGE_PATH   $ROS_PACKAGE_PATH"
	#echo "COLCON_PREFIX_PATH $COLCON_PREFIX_PATH"
	#echo "AMENT_PREFIX_PATH  $AMENT_PREFIX_PATH"
	#echo "CMAKE_PREFIX_PATH  $CMAKE_PREFIX_PATH"

echo "ROS_DISTRO $ROS_DISTRO"
echo "ROS_ROOT   $ROS_ROOT"

exec "$@"
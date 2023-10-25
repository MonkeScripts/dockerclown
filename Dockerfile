ARG UBUNTU_DISTRO_NAME=jammy
ARG FROM_IMAGE=ubuntu:$UBUNTU_DISTRO_NAME
ARG ROS_VERSION=humble
ARG ROS_PACKAGE=ros_base
# Download base image ubuntu 22.04
FROM $FROM_IMAGE
ENV ROS_DISTRO=${ROS_VERSION}
ENV ROS_ROOT=/opt/ros/${ROS_DISTRO}
ENV ROS_PYTHON_VERSION=3
ENV DEBIAN_FRONTEND=noninteractive
ENV SHELL /bin/bash
# SHELL ["/bin/bash", "-c"] 
# LABEL about the custom image
LABEL maintainer="shaolianghe0.0@gmail.com"
LABEL version="0.1"
LABEL description="custom docker image for drone sbc"
WORKDIR /tmp

# change the locale from POSIX to UTF-8
RUN apt-get clean && apt-get update 
RUN apt-get install -y locales 
RUN locale-gen en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

ENV LANG=en_US.UTF-8
ENV PYTHONIOENCODING=utf-8

# RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1

COPY ros2_build.sh ros2_build.sh
RUN ./ros2_build.sh

ENV RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
COPY ros2_entrypoint.sh /ros2_entrypoint.sh

ENTRYPOINT ["/ros2_entrypoint.sh"]
CMD ["/bin/bash"]

WORKDIR /

RUN apt-get update \
    &&  apt-get install -y \
    build-essential \
    cmake \
    gdb \
    git \
    libpython3-dev \
    libbullet-dev \
    python3-colcon-common-extensions \
    python3-flake8 \
    python3-pip \
    python3-pytest-cov \
    python3-rosdep \
    python3-vcstool \
    wget \
    && rm -rf /var/lib/apt/lists/*

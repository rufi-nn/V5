#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/zrx/catkin_turtlebot3/src/turtlebot3/turtlebot3_teleop"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/zrx/catkin_turtlebot3/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/zrx/catkin_turtlebot3/install/lib/python3/dist-packages:/home/zrx/catkin_turtlebot3/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/zrx/catkin_turtlebot3/build" \
    "/usr/bin/python3" \
    "/home/zrx/catkin_turtlebot3/src/turtlebot3/turtlebot3_teleop/setup.py" \
     \
    build --build-base "/home/zrx/catkin_turtlebot3/build/turtlebot3/turtlebot3_teleop" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/zrx/catkin_turtlebot3/install" --install-scripts="/home/zrx/catkin_turtlebot3/install/bin"

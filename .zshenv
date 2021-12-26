if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi


export GOOGLE_APPLICATION_CREDENTIALS="/home/dyens/Ambra AI-5756a39a92a9.json"
export PATH=/home/dyens/.local/bin:$PATH


source /home/dyens/ros_catkin_ws/install_isolated/setup.zsh
export CMAKE_PREFIX_PATH=$PATH:/home/dyens/ros_catkin_ws/install_isolated:/home/dyens/Qt/6.2.0/gcc_64/lib/cmake

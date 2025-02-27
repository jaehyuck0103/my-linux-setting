echo_red() {
    tput setaf 1
    echo "$*"
    tput sgr0
}
echo_barrier() { for _ in $(seq $1); do echo -n -; done; }
echo_title() {
    echo ""
    echo_red $(echo_barrier $((${#*} + 10)))
    echo_red "---- $* ----"
    echo_red $(echo_barrier $((${#*} + 10)))
}
echo_and_run() {
    echo_red "\$ $*"
    "$@"
}

echo_red "Step1: Essential utils, NVIDIA Driver"
echo_red "Step2: my-linux-setting"
echo_red "Step3: Install Python"
echo_red "Step4: Install Python Packages"
echo_red "Step5: Neovim"
echo_red "Step6: Dropbox"
echo_red "Step7: clangd, clang-format"
echo_red "Step8: Install node by nvm"
echo_red "Step9: Install OpenCV"
echo_red "Step10: Install Syncthing"
read -p "$(echo_red "Which step?")" STEP

if [ "$STEP" = "1" ]; then

    echo_title "Basic Update"
    echo_and_run sudo apt update
    echo_and_run sudo apt upgrade

    echo_title "Essential Utils"
    echo_and_run sudo apt install build-essential git openssh-server tmux cmake
    echo_and_run sudo apt install libglfw3-dev libtbb-dev

    read -p "$(echo_red "Install Google Chrome (y/n)?")" CONT
    if [ "$CONT" = "y" ]; then
        echo_title "Google Chrome"
        echo_and_run wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        echo_and_run sudo apt install ./google-chrome-stable_current_amd64.deb
        echo_and_run rm ./google-chrome-stable_current_amd64.deb
    fi

    read -p "$(echo_red "Install Nvidia Driver (y/n)?")" CONT
    if [ "$CONT" = "y" ]; then
        echo_title "Install Nvidia Driver"
        echo_and_run wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb
        echo_and_run sudo dpkg -i cuda-keyring_1.1-1_all.deb
        echo_and_run sudo apt update
        echo_and_run sudo apt install nvidia-open
        echo_red "System Reboot Recommended"

        read -p "$(echo_red "Install CUDA (y/n)?")" CONT
        if [ "$CONT" = "y" ]; then
            echo_title "Install CUDA"
            echo_and_run sudo apt install cuda-toolkit
        fi
    fi

elif [ "$STEP" = "2" ]; then

    echo_title "Make Utils Folder"
    echo_and_run mkdir Utils

    echo_title "Install my-linux-setting"
    echo_and_run git clone https://github.com/jaehyuck0103/my-linux-setting.git ~/Utils/my-linux-setting
    echo_and_run cd ~/Utils/my-linux-setting
    echo_and_run sh install.sh
    echo_and_run cd -

elif [ "$STEP" = "3" ]; then

    echo_title "Install Python3.12"
    echo_and_run sudo add-apt-repository ppa:deadsnakes/ppa
    echo_and_run sudo apt update
    echo_and_run sudo apt install python3.12-dev python3.12-venv
    echo_and_run python3.12 -m venv ~/Utils/python_venvs/base --upgrade-deps
    echo_red "Reopen Terminal Required"

elif [ "$STEP" = "4" ]; then

    echo_title "Install PythonPackages"
    echo_and_run pip install pip setuptools wheel cmake --upgrade
    echo_and_run pip install ruff black isort cmakelang --upgrade
    echo_and_run pip install numpy scipy matplotlib pydantic python-box typer tensorboard --upgrade
    echo_and_run pip install pandas scikit-learn scikit-image --upgrade
    echo_and_run pip install opencv-contrib-python albumentations imagecodecs --upgrade
    echo_and_run pip install pynvim --upgrade
    echo_and_run pip install torch torchvision torchmetrics kornia mmengine --upgrade

    # echo_and_run pip install openmim --upgrade
    # echo_and_run mim install mmengine --upgrade
    # pip xarray requests bs4 seaborn xgboost imbalanced-learn tqdm

elif [ "$STEP" = "5" ]; then

    echo_title "Neovim (stable ver, appimage, by Zap)"

    echo_and_run sudo apt update
    echo_and_run sudo apt install jq
    curl https://raw.githubusercontent.com/srevinsaju/zap/main/install.sh | bash -s

    echo_and_run zap install --github --from neovim/neovim

    echo_and_run pip install pynvim --upgrade

elif [ "$STEP" = "6" ]; then

    echo_title "Dropbox"
    echo_and_run sudo apt install dropbox python3-gpg

elif [ "$STEP" = "7" ]; then # https://apt.llvm.org/

    echo_title "Install clangd, clang-format"

    UBUNTU_CODENAME=$(grep "UBUNTU_CODENAME=" /etc/os-release | cut -d "=" -f2)
    echo_red "UBUNTU_CODENAME: ${UBUNTU_CODENAME}"

    REPO_NAME="deb http://apt.llvm.org/${UBUNTU_CODENAME}/   llvm-toolchain-${UBUNTU_CODENAME}  main"
    echo_and_run sudo add-apt-repository "${REPO_NAME}"
    wget -qO- https://apt.llvm.org/llvm-snapshot.gpg.key | sudo tee /etc/apt/trusted.gpg.d/apt.llvm.org.asc  # echo_and_run 붙이면 안되서 제외.
    echo_and_run sudo apt update
    echo_and_run sudo apt install clangd clang-format

elif [ "$STEP" = "8" ]; then
    echo_title "Install node by nvm"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    echo_and_run nvm install --lts

elif [ "$STEP" = "9" ]; then
    echo_title "Install OpenCV"
    echo_and_run sudo apt install libgtk-3-dev
    echo_and_run mkdir -p ~/Utils/opencv
    echo_and_run cd ~/Utils/opencv

    echo_and_run wget -O opencv.zip https://github.com/opencv/opencv/archive/master.zip
    echo_and_run wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/master.zip
    echo_and_run unzip opencv.zip
    echo_and_run unzip opencv_contrib.zip
    echo_and_run mkdir -p build && cd build

    echo_and_run cmake -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib-master/modules -DOPENCV_ENABLE_NONFREE=ON ../opencv-master
    echo_and_run make -j`nproc`
    echo_and_run sudo make install

elif [ "$STEP" = "10" ]; then
    echo_title "Install Syncthing"
    # Add the release PGP keys:
    sudo curl -o /usr/share/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
    # Add the "stable" channel to your APT sources:
    echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
    # Update and install syncthing:
    sudo apt-get update
    sudo apt-get install syncthing

    # Starting Syncthing Automatically
    systemctl enable "syncthing@${USER}.service"
    systemctl start "syncthing@${USER}.service"
fi

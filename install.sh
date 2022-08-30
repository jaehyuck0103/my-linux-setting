ln -sf $(realpath ./nvim) ~/.config/

# mkdir -p ~/.pip
# ln -sf $(realpath ./pip/pip.conf) ~/.pip/

ln -sf $(realpath ./tmux/tmux.conf) ~/.tmux.conf

# ln -sf $(realpath ./libinput-gestures/libinput-gestures.conf) ~/.config/

mkdir -p ~/Projects
ln -sf $(realpath ./pylint/pylintrc) ~/.pylintrc
ln -sf $(realpath ./pylint/pylintrc) ~/Projects/.pylintrc
ln -sf $(realpath ./clang-format/clang-format) ~/.clang-format
ln -sf $(realpath ./clang-format/clang-format) ~/Projects/.clang-format


if grep -q "# source my-linux-setting" ~/.bashrc; then
    echo "The bashrc already contains my-linux-setting."
else
    echo "Add my-linux-setting to bashrc."

    echo "" >> ~/.bashrc
    echo "" >> ~/.bashrc
    echo "# source my-linux-setting" >> ~/.bashrc
    echo "source ~/Utils/my-linux-setting/bash/bashrc" >> ~/.bashrc
fi

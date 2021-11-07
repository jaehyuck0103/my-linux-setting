ln -sf $(realpath ./nvim) ~/.config/

# mkdir -p ~/.pip
# ln -sf $(realpath ./pip/pip.conf) ~/.pip/

ln -sf $(realpath ./tmux/tmux.conf) ~/.tmux.conf

ln -sf $(realpath ./libinput-gestures/libinput-gestures.conf) ~/.config/

ln -sf $(realpath ./pylint/pylintrc) ~/.pylintrc
ln -sf $(realpath ./pylint/pylintrc) ~/Projects/.pylintrc
ln -sf $(realpath ./clang-format/clang-format) ~/.clang-format
ln -sf $(realpath ./clang-format/clang-format) ~/Projects/.clang-format

cat ./bash/bashrc >> ~/.bashrc

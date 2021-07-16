mkdir -p ~/.config/nvim
ln -s $(realpath ./vim/vimrc) ~/.config/nvim/init.vim
ln -s $(realpath ./vim/coc-settings.json) ~/.config/nvim/

mkdir -p ~/.pip
ln -s $(realpath ./pip/pip.conf) ~/.pip/

ln -s $(realpath ./tmux/tmux.conf) ~/.tmux.conf

ln -s $(realpath ./libinput-gestures/libinput-gestures.conf) ~/.config/

ln -s $(realpath ./pylint/pylintrc) ~/.pylintrc
ln -s $(realpath ./pylint/pylintrc) ~/Projects/.pylintrc
ln -s $(realpath ./clang-format/clang-format) ~/.clang-format
ln -s $(realpath ./clang-format/clang-format) ~/Projects/.clang-format

cat ./bash/bashrc >> ~/.bashrc

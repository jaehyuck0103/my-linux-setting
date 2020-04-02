mkdir -p ~/.config/nvim
ln -s $(realpath ./vim/vimrc) ~/.config/nvim/init.vim
ln -s $(realpath ./vim/coc-settings.json) ~/.config/nvim/

mkdir -p ~/.pip
ln -s $(realpath ./pip/pip.conf) ~/.pip/

ln -s $(realpath ./tmux/tmux.conf) ~/.tmux.conf

ln -s $(realpath ./flake8/flake8) ~/.config/flake8

ln -s $(realpath ./libinput-gestures/libinput-gestures.conf) ~/.config/

ln -s $(realpath ./pylint/pylintrc) ~/.pylintrc

cat ./bash/bashrc >> ~/.bashrc

mkdir -p ~/.config/nvim
ln -s $(realpath ./vim/vimrc) ~/.config/nvim/init.vim

mkdir -p ~/.pip
ln -s $(realpath ./pip/pip.conf) ~/.pip/

ln -s $(realpath ./tmux/tmux.conf) ~/.tmux.conf

ln -s $(realpath ./flake8/flake8) ~/.config/flake8

cat ./bash/bashrc >> ~/.bashrc

INSTALL
=======

* Install vim and other nescessary: sudo apt-get install vim vim-gnome openjdk-6-jdk ctags libreadline6-dev ack
* git clone git://github.com/skyeagle/vim-submodules.git ~/.vim
* cd ~/.vim
* git submodule update --init
* Install RSence
** Go to http://cx4a.org/software/rsense/ then download latest version
** Install Rsense http://cx4a.org/software/rsense/manual.html#Installation
* Compile command-T:
** rvm install ree && rvm ree
** cd ~/.vim/bundle/command-T && rake make
* Create symlink: ls -s ~/.vim/vimrc ~/.vimrc






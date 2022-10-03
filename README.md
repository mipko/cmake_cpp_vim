# cmake_cpp_vim
template CPP project for vim. Includes .vimrc, CMakelists.txt, boileprplate code for app and shered lib

# plugin manager for vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

- backup your ~/.vimrc
- copy vim/.vimrc file to ~/.vimrc


# install plugins - within vim; vim will complain a lot at this first startup
:PlugInstall

# compile YcmdMeCompleter engine

cd ~/.vim/plugged/YouCompleteMe/
./install.py --clang-completer

# To start your project
- remove .git folder
- rename _PROJECT_NAME_ variable within the CMakeLists.txt file to your project name, ##CLOSE## vim 
- rename root dir to your project dir
- open VIM within your project ROOT folder where ROOT CmakeLists.txt file is

# To compile DEBUG version within the vim
- C-M bd

# To compile RELEASE version within the vim
- C-M br

# To run DEBUG version within the vim
- F6

# To run RELEASE version within the vim
- F7

# COMPILE DATABASE
- it is generated automatically for each build/build type

# WIP 
- debugging (gdb integration) within the VIM

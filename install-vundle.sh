#!/usr/bin/env bash

vim -v --startuptime /dev/stdout +qall

mkdir -p ~/.vim/bundle
[[ ! -d ~/.vim/bundle/Vundle.vim ]] \
  && git clone --depth 1 https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim


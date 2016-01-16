#!/bin/sh

cp -i <(echo "exec zsh") ~/.profile
cp -i <(echo "source ~/.zsh/.zshrc") ~/.zshrc
cp -i <(echo "source ~/.zsh/.zshenv") ~/.zshenv


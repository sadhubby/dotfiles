#
# ~/.bashrc
#


fastfetch --kitty-direct /home/moonberry/Downloads/caitvibetter_big.png 

echo ""

eval "$(starship init bash)"
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

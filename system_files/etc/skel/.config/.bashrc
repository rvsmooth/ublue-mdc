#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '
#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

eval "$(starship init bash)"

#!/bin/zsh

HISTCONTROL=ignoredups:ignorespace
HISTSIZE=900000
HISTFILESIZE=$HISTSIZE
HISTTIMEFORMAT="%s "
history_db_file=$HOME/.hist/zsh_history.db
hist_counter=0

_history_sync() {
    rc="$?" # to do first !!
    if [ $hist_counter -eq "0" ]; then hist_counter=$((hist_counter+1)); return ;fi
    regex="[0-9]+_([a-z]+)_[0-9a-z]*"
    timestamp=$(date +%s)
    cmd=$(history -1)    
    pid="$$"
	#$HOME/.local/bin/history.py --dbfile $history_db_file -c $cmd -t $timestamp --rc $rc --pid $pid -p $PWD -s $SHELL insert
	history.py --dbfile $history_db_file -c $cmd -t $timestamp --rc $rc --pid $pid -p $PWD -s $SHELL insert > /dev/null 2>&1
    return $rc
}

precmd_functions+=(_history_sync)

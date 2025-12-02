function setrclonepasswd {
  #echo "Provide rclone config password"
  #read -s RCLONE_CONFIG_PASS
	#export RCLONE_CONFIG_PASS
  export RCLONE_CONFIG_PASS=$(pass backup/RCLONE_CONFIG_PASS )
}
function setresticpasswd {
    echo "Provide restic password"
    read -s RESTIC_PASSWORD
	export RESTIC_PASSWORD
}
function setbackuppasswd {
    echo "Provide rclone config password"
    read -s RCLONE_CONFIG_PASS
    echo "Provide restic password"
    read -s RESTIC_PASSWORD
	export RCLONE_CONFIG_PASS
	export RESTIC_PASSWORD
}

function open_with_tmux() {
    local command_to_run="$1"
    local session_name='apps'

    # Check if tmux session exists
    if tmux has-session -t "$session_name" &> /dev/null; then
        # If session exists, create a new window with thunar
        tmux new-window -t "$session_name" -n "$command_to_run"
        tmux send-keys -t "$session_name" "$command_to_run" Enter
    else
        # If session doesn't exist, create a new session with thunar
        tmux new-session -d -s "$session_name" -n "$command_to_run" "$command_to_run"
    fi
}

function pacinstall() {
  local pac_file="$HOME/.packages/pacman.txt"
  
  if sudo pacman -S "$@"; then
    for param in "$@"; do
      echo "$param" | tr -d ' ' >> "${pac_file}"
    done
    sort -u "${pac_file}" -o "${pac_file}"
  else
    echo "Erreur : l'installation de certains paquets a échoué." >&2
    return 1
  fi
}

function bkp() {
    if [ -d ~/.venv ]; then
      bash -c "source ~/.venv/bin/activate && bkp \"$@\""
    else
      echo "Virtual environment not found at ~/.venv"
      return 1
    fi
}


#function bkp() {
#    if [ -d ~/.venv ]; then
#        source ~/.venv/bin/activate || { echo "Failed to activate virtualenv"; return 1; }
#        bkp || { echo "bkp command failed"; deactivate; return 1; }
#        deactivate || { echo "Failed to deactivate virtualenv"; return 1; }
#    else
#        echo "Virtual environment not found at ~/.venv"
#        return 1
#    fi
#}


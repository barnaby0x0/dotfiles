# Extract many archive types
extract () {
  if [ -f "$1" ] ; then
  case $1 in
    *.tar.bz2)   tar xjf "$1"     ;;
    *.tar.gz)    tar xzf "$1"     ;;
    *.tar.xz)    tar xJf "$1"     ;;
    *.bz2)       bunzip2 "$1"     ;;
    *.rar)       unrar e "$1"     ;;
    *.gz)        gunzip "$1"      ;;
    *.tar)       tar xf "$1"      ;;
    *.tbz2)      tar xjf "$1"     ;;
    *.tgz)       tar xzf "$1"     ;;
    *.zip)       unzip "$1"       ;;
    *.Z)         uncompress "$1"  ;;
    *.7z)        7z x "$1"        ;;
    *)     echo "'$1' cannot be extracted via extract()" ;;
  esac
  else
    echo "'$1' is not a valid file"
  fi
}

# tar gz input
quick-archive () {
    tar cvzf ${1}-$(date +%Y%M%d%H%m%S).tgz ${1}
}

# command tree with size
treesize () {
    du -k --max-depth=1 2>/dev/null | sort -nr | awk '
        BEGIN {
            split("KB,MB,GB,TB", Units, ",");
        }
        {
            u = 1;
            while ($1 >= 1024) {
                $1 = $1 / 1024;
                u += 1
            }
            $1 = sprintf("%.1f %s", $1, Units[u]);
            print $0;
        }
        ' 2>/dev/null
}

# copy with progress bar
cp_p() {
   set -e
   strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
      | awk '{
	    count += $NF
            if (count % 10 == 0) {
               percent = count / total_size * 100
               printf "%3d%% [", percent
               for (i=0;i<=percent;i++)
                  printf "="
               printf ">"
               for (i=percent;i<100;i++)
                  printf " "
               printf "]\r"
            }
         }
         END { print "" }' total_size=$(stat -c '%s' "${1}") count=0
}

## backup quiclky a file
qb() {
	export LAST_BAK=$1
	cp $LAST_BAK $LAST_BAK.BAK
}

## restore quiclky a file
restb(){
	if [ "$LAST_BAK" != "" ]
	then
		cp $LAST_BAK.BAK $LAST_BAK
	fi
	export LAST_BAK=""
}

cd() {
  if [ "$#" = "0" ]
  then
  pushd ${HOME} > /dev/null
  elif [ -f "${1}" ]
  then
    ${EDITOR} ${1}
  else
  pushd "$1" > /dev/null
  fi
}

bd(){
  if [ "$#" = "0" ]
  then
    popd > /dev/null
  else
    for i in $(seq ${1})
    do
      popd > /dev/null
    done
  fi
}

lf() {
    if [ "x${1}" == "x" ]
    then
        n=1 
    else
        n="${1}"
    fi  
    ls -rt1 | tail -n ${n} | head -n 1
}

newerthan() {
    if [ "$#" -ne 2 ]; then
        echo "Illegal number of parameters"
    fi
    if [[ $1 -nt $2 ]]; then return 0; fi
    return 1
}

# mkdir and go
mkcd() {
	mkdir $1 && cd ./$1
}

cd () {
  current_dir="$PWD"
  builtin cd "$@" || return
  if [ -f "$PWD/.dir_hook.sh" ];then
          source "$PWD/.dir_hook.sh"
  fi
}

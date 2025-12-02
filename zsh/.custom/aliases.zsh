## DEVOPS
# launch binder (terraform poc)
alias binder='(cd /home/user/workspace/src/perso/terraform-poc/binder; rm -f out.json; ENV=victor make auto-apply && ENV=victor OUTPUT=output.json make output)'
# scan uuid in terraform infrastructure
alias uuidscan='grep -s -R "uuid\s*=" '
# Launch portainer
alias portainer='docker run -d -p 9000:9000 -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /$XDG_RUNTIME_DIR/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest'
# Launch downloader
function downloader() { (cd ~/Workspace/docker/downloader && ./compose.sh "$@") }
# Start gitlab runners on vagrant
alias start_gl_runner='(cd ~/workspace/envs/vagrant/debian-11-docker-virt;sudo systemctl start libvirtd && vagrant up && vagrant ssh -c "sudo sh -c \"(cd /root/env; ./gitlab-runner.sh)\"")'
alias connect_gl_runner='(cd ~/workspace/envs/vagrant/debian-11-docker-virt;vagrant ssh)'
alias stop_gl_runner='(cd ~/workspace/envs/vagrant/debian-11-docker-virt;vagrant halt)'
# Kubernetes
#alias do='--dry-run=client oyaml'
#
# AWS
#alias cdk='docker run --rm -u "1000:1000" -v "$PWD:$PWD" -w "$PWD" -it aws-cdk cdk '
alias cdk='docker run -it --rm -v ~/.cdk_history:/home/cdk/.bash_history -v $PWD:/app -v ~/.aws:/home/cdk/.aws cdk bash'
alias aws='docker run --rm -ti -v ~/.aws:/root/.aws amazon/aws-cli '

## ENVS
alias dc_implicity_d='(cd $HOME/workspace/envs/docker/implicity;mdc -p implicity down)'
alias dc_implicity_u='(cd $HOME/workspace/envs/docker/implicity;mdc -p implicity up -d)'
alias dc_resilio_d='(cd $HOME/workspace/envs/docker/resilio;mdc down)'
alias dc_resilio_u='(cd $HOME/workspace/envs/docker/resilio;mdc up -d)'
alias dc_downloader_d='(cd $HOME/workspace/envs/docker/downloader;mdc down)'
alias dc_downloader_u='(cd $HOME/workspace/envs/docker/downloader;mdc up -d)'
alias dc_kanboard_u='(cd $HOME/workspace/envs/docker/kanboard;mdc up -d)'
alias dc_kanboard_d='(cd $HOME/workspace/envs/docker/kanboard;mdc down)'
# local kubernetes cluster
alias env_k8s_local_up='(cd /home/user/workspace/envs/vagrant/k8s-cluster-virt; vagrant up)'
alias env_k8s_local_halt='(cd /home/user/workspace/envs/vagrant/k8s-cluster-virt; vagrant halt)'
# vault
alias env_vault_up='(cd /home/user/workspace/envs/vagrant/vault-virt; vagrant up)'
alias env_vault_halt='(cd /home/user/workspace/envs/vagrant/vault-virt; vagrant halt)'
# consul
alias env_consul_up='(cd /home/user/workspace/envs/vagrant/consul-virt; vagrant up)'
alias env_consul_halt='(cd /home/user/workspace/envs/vagrant/consul-virt; vagrant halt)'
# test machine
alias env_debian_up='(cd /home/user/workspace/envs/vagrant/debian-virt; vagrant up)'
alias env_debian_halt='(cd /home/user/workspace/envs/vagrant/debian-virt; vagrant halt)'

## KUBERNETES
alias kgetnodes="kubectl get nodes -Lfailure-domain.beta.kubernetes.io/zone -Lkops.k8s.io/instancegroup -Lbeta.kubernetes.io/instance-type"
alias get_context="grep \"current-context:\" ~/.kube/config | cut -d ' ' -f2"
function kubens() { kubectl config set-context --current --namespace "$@" }
alias k='kubectl '
alias kl='kubectl logs '
alias klf='kubectl logs -f '
## create/destroy from yaml faster
alias kaf='k apply -f '
alias kdf='k delete -f '
## namespaces (poor man's `kubens`)
export nk='-n kube-system'
## destroy things without waiting
export now='--grace-period 0 --force'
## create yaml on-the-fly faster
export do='--dry-run=client -o yaml'
alias k='kubectl '
alias kgetnodes="kubectl get nodes -Lfailure-domain.beta.kubernetes.io/zone -Lkops.k8s.io/instancegroup -Lbeta.kubernetes.io/instance-type -owide"

## SSH
alias sshconfigall='find $HOME/.ssh/configs -type f -regextype egrep -regex ".*(implicity|perso).*conf$" -exec cat -- {} \; | dd of=$HOME/.ssh/config'
alias sshconfigperso='find $HOME/.ssh/configs -type f -regextype egrep -regex ".*perso.*conf$" -exec cat -- {} \; | dd of=$HOME/.ssh/config'
alias sshconfigimplicity='find $HOME/.ssh/configs -type f -regextype egrep -regex ".*implicity.*conf$" -exec cat -- {} \; | dd of=$HOME/.ssh/config'

## SYSTEM
alias watch='watch '
alias cm='chezmoi '
alias t='go-task '
alias kill_idea="kill -9 $(ps aux | grep idea |awk '{print $2}'|head -n1)"
backup() {(cd "$HOME/.backup" && ./backup_menu.sh "$@")}
alias backup_mega='(cd "$HOME/.backup" && ./backup_menu.sh "history.mega3" "konsave.mega1" "documents.mega" "lab.mega3" "dcmi.mega2" --thread)'
alias backup_ssd='(cd "$HOME/.backup" && ./backup_menu.sh "dcmi.ssd" "history.ssd" "konsave.ssd" "documents.ssd" --thread)'
#alias pacmanS='function _pacmanS() { echo "$@" | tr " " "\n" >> ~/.packages/pacman_pkglists/new.txt && sort -u -o ~/.packages/pacman_pkglists/new.txt ~/.packages/pacman_pkglists/new.txt && sudo pacman -S "$@"; }; _pacmanS'
alias yayS='function _yayS() { echo "$@" | tr " " "\n" >> ~/.packages/aur_pkglist.txt && sort -u -o ~/.packages/aur_pkglist.txt ~/.packages/aur_pkglist.txt && yay -S "$@"; }; _yayS'
alias flatpakS='function _flatpakS() { echo "$@" | tr " " "\n" >> ~/.packages/flatpak_pkglist.txt && sort -u -o ~/.packages/flatpak_pkglist.txt ~/.packages/flatpak_pkglist.txt && flatpak install "$@"; }; _flatpakS'
alias yayR='function _yayR() { yay -Rns "$@"; for pkg in "$@"; do sed -i "\|^$pkg\$|d" ~/.packages/aur_pkglist.txt; done; sort -u -o ~/.packages/aur_pkglist.txt ~/.packages/aur_pkglist.txt; }; _yayR'
alias flatpakR='function _flatpakR() { flatpak uninstall -y "$@"; for pkg in "$@"; do sed -i "\|^$pkg\$|d" ~/.packages/flatpak_pkglist.txt; done; sort -u -o ~/.packages/flatpak_pkglist.txt ~/.packages/flatpak_pkglist.txt; }; _flatpakR'
alias pacmanS='function _pacmanS() {
    for pkg in "$@"; do
        # Check if pkg already exists in any list
        if ! grep -qxF "$pkg" ~/.packages/pacman_pkglists/*.txt 2>/dev/null; then
            echo "$pkg" >> ~/.packages/pacman_pkglists/new.txt
        fi
    done

    # Sort all lists
    find ~/.packages/pacman_pkglists -type f -name "*.txt" -exec sort -u -o {} {} \;

    # Install packages
    sudo pacman -S "$@"
}; _pacmanS'
alias pacmanR='function _pacmanR() {
    sudo pacman -Rns "$@";
    for pkg in "$@"; do
        find ~/.packages/pacman_pkglists -type f -name "*.txt" -exec sed -i "\|^$pkg\$|d" {} \;
    done;
    find ~/.packages/pacman_pkglists -type f -name "*.txt" -exec sort -u -o {} {} \;
}; _pacmanR'
alias restart_plasma='systemctl restart --user plasma-plasmashell'
alias blue_conn_sony='while ! bluetoothctl connect 0C:A6:94:64:29:DD; do echo "Waiting for bluetooth connection"; sleep 2; done'

## oath
alias yk_thales='ykman oath accounts code 42dcc854865a4800:victor.beauvoire@implicity.com'

## ZSH
# alias
alias ag="alias | grep " # +command
# history
alias hg="history | grep " # +command

## go-task
alias thunderbird="open_with_tmux 'go-task thunderbird-new'"
alias librewolf="open_with_tmux 'go-task librewolf'"
alias joplin="open_with_tmux 'joplin'"
alias myip="curl ifconfig.me"

## Flatpak apps
alias okular="org.kde.okular "

# OPS
alias start_k8="ssh 192.168.1.101 sudo etherwake C8:FF:BF:0F:7A:35"

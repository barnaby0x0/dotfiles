## KUBECTL
kubens() {
	kubectl config set-context --current --namespace "$1"
}

ingress_health() {
  context=$(k config current-context)
  while IFS= read -r line
  do
      namespace=$(echo $line | awk -F ' {2,}' '{print $1}')
      name=$(echo $line | awk -F ' {2,}' '{print $2}')
      class=$(echo $line | awk -F ' {2,}' '{print $3}')
      hosts=$(echo $line | awk -F ' {2,}' '{print $4}')
      address=$(echo $line | awk -F ' {2,}' '{print $5}')
      port=$(echo $line | awk -F ' {2,}' '{print $6}')
      age=$(echo $line | awk -F ' {2,}' '{print $7}')
      # shellcheck disable=SC1083
      test1=$({curl -sSf https://$hosts > /dev/null} 2>&1)
      test2=$(curl -Is https://$hosts | head -n 1 | tr -d '\r' | xargs)
      s=$([[ ! -z "$test1" ]] && echo $test1 || echo $test2)
      echo "$namespace;$name;$class;$hosts;$address;$port;$age;$s"
  done <<< $(k get ingress -A | awk 'NR>1') | column -s ';' -t -N'NAMESPACE,NAME,CLASS,HOSTS,ADDRESS,PORTS,AGE,HEALTH' -J -n"$context"
}

## TERRAFORM
alias binder='(cd /home/user/workspace/src/perso/terraform-poc/binder; rm -f out.json; ENV=victor make auto-apply && ENV=victor OUTPUT=output.json make output)'
binder_all() {
    (
    cd $HOME/workspace/src/perso/poc/terraform-envs/binder;
    rm -f outputs/*out.json; 
    for env in environments/*; do e=$(basename $env); echo $e; ENV=$e make auto-apply && ENV=$e OUTPUT=outputs/$e.out.json make output; done;
    )
}

binder_by_env () {
    ENV=${1} make auto-apply && ENV=${1} OUTPUT=${1}.out.json make output
}

## PACKER
packer_all() {
    #export cmd="packer build "
    mkdir -p logs
    export pids=()

    for FILE in *.json
    do
      (export PACKER_LOG=1;export PACKER_LOG_PATH="logs/$FILE-$(date +%Y%m%d_%H%M).log"; packer build $FILE) &
      arrVar+=($!)
    done

    for pid in "${arrVar[@]}"
    do
         wait "$pid" && echo "$pid exited normally" || echo "$pid exited abnormally with status $?"
    done

    rm -f ami-list.txt
    for FILE in logs/*.log
    do
      ami=$(cat $FILE | egrep "^[a-z]{2}-(east|west)-[1-6]:\s(ami-.*)$"| awk '{print $2}')
      env=$(basename $FILE | cut -d '.' -f1)
      echo "$(date +%Y-%m-%d_%H:%M) $env: $ami" | tee -a ami-list.txt
    done
}

## AWS
get_ami_canonical () {
    OWNER_UBUNTU="099720109477"
    PROVIDED_REGION="$1"
    REGION="${PROVIDED_REGION:-eu-west-1}"
    echo "get images for the owner $OWNER_UBUNTU in the region $REGION"
    aws ec2 describe-images --region "${REGION}" --output table --owners "${OWNER_UBUNTU}" --query "sort_by(Images, &CreationDate)[*].[CreationDate,Name,ImageId]"
}

get_ami_fedora () {
    OWNER_UBUNTU="125523088429"
    PROVIDED_REGION="$1"
    REGION="${PROVIDED_REGION:-eu-west-1}"
    echo "get images for the owner $OWNER_UBUNTU in the region $REGION"
    aws ec2 describe-images --region "${REGION}" --output table --owners "${OWNER_UBUNTU}" --query "sort_by(Images, &CreationDate)[*].[CreationDate,Name,ImageId]"
}

get_latest_focal_ami () {
	region="${1:-eu-west-1}"
	arch="${2:-amd64}"
    version="${3:-20.04}"
	aws ssm get-parameters --region "${region}" --names /aws/service/canonical/ubuntu/server/"${version}"/stable/current/"${arch}"/hvm/ebs-gp2/ami-id|jq -r '.Parameters[0].Value'
}

## SYSTEM
gen_ramdom_char () {
    tr -dc a-z0-9 </dev/urandom | head -c $1 ; echo ''
}

del_empty_line() {
    sed -ri '/^\s*$/d' $1
}

## SECURITY
session_encrypt() {
  gpg -e -r "$2" "$1"
  session_header=$(head -c 512k "$1.gpg")
  echo "$session_header"
   #| tee "$1.head.gpg" >/dev/null
}

## DOCKER
docker_find_container_by_volumes(){
  VOLUME_NAME="$1"
  docker ps -aq | while read container; do
    if docker inspect --format='{{range .Mounts}}{{if eq .Name "'$VOLUME_NAME'"}}{{.Name}}{{end}}{{end}}' "$container" | grep -q "$VOLUME_NAME"; then
      # Print the container name
      docker inspect --format='{{.Name}}' "$container" | sed 's/\///'
    fi
  done
}

stop_container() {
    container_name=$1
    
    # Check if container is running
    if docker ps -q --filter "name=${container_name}" | grep -q .; then
        echo "Stopping Docker container ${container_name}..."
        docker stop ${container_name}
    else
        echo "Docker container ${container_name} is not running."
    fi
}

docker_stop_by_image(){
  VOLUME_NAME="$1"
  docker ps --format '{{.Names}}|{{.Image}}'| awk -v pat=$VOLUME_NAME -F '|' '$2 ~ pat {system("docker stop " $1)}'
}

docker_stop_by_volume(){
  VOLUME_NAME="$1"
  CONTAINER_NAME=$(docker_find_container_by_volumes $VOLUME_NAME)
  #docker stop $CONTAINER_NAME 
  stop_container $CONTAINER_NAME 
}

docker_volumes_size() {
  VOLUME_NAME="$1"
  docker run --rm -v ${VOLUME_NAME}:/volume alpine:latest du -sh /volume
}

docker_volumes_backup(){
  VOLUME_NAME="$1"
  #docker_stop_by_image "$VOLUME_NAME"
  docker_stop_by_volume "$VOLUME_NAME"
  docker run --rm -v ${VOLUME_NAME}:/volume -v $(pwd):/backup busybox tar cvf /backup/${VOLUME_NAME}_backup_$(date +%Y-%m-%d-%H-%M).tar /volume
}

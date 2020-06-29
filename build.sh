#!/bin/bash
VALID_TARGETS="base python docker dotnet nodejs"
DockerHubPrefix=""
ImageName="devopsubuntu"
Tag="latest"
AppendMode="image"
DryRun=0
targets=($VALID_TARGETS)

usage() {
  echo "Usage:"
  echo "    -h  Display this help message."
  echo "    -p  Docker Image Preffix (docker hub username). Default: empty/null"
  echo "    -i  Docker Image name. Default: $ImageName + OS_VERSION"
  echo "    -t  Docker Tag to be used. Default: latest."
  echo "    -m  Append Mode - tag or image. Default: image."
  echo "    -b  Build Targets - Comma separated list of Targets to build. Ex: -b base,dotnet,nodejs"
  echo "    -x  Dry run -- do not actually build the images."
  exit 0
}

validateTargets() {
  echo "TODO: Validate targets"
}

while getopts "hp:i:t:m:b:x" opt; do
  case ${opt} in
    h)
      usage
      ;;
    m) AppendMode="$OPTARG"
    ;;
    p) DockerHubPrefix="$OPTARG"
    ;;
    i) ImageName="$OPTARG"
    ;;
    t) Tag="$OPTARG"
    ;;
    b) 
      OIFS=$IFS;
      IFS=",";
      targets=($OPTARG)
      IFS=$OIFS;
      ;;
    x) DryRun=1
    ;;
    \?) 
      echo "Invalid option -$OPTARG" >&2
      usage
      ;;
  esac
done

print_info() {
  lightgreen='\e[92m'
  nocolor='\033[0m'
  echo -e "${lightgreen}[*] $1${nocolor}"
}

print_info "Building all images..."
print_info "- DockerHubPrefix: '$DockerHubPrefix'"
print_info "- ImageName: '$ImageName'"
print_info "- Tag: '$Tag'"
print_info "- AppendMode: '$AppendMode'"
echo -e "\e[92m[*] - BuildTargets: ${targets[@]}\033[0m"

print_info "Making all bash scripts executable"

find . -type f -iname "*.sh" -exec chmod +x {} \;

# Select the version you prefer, or both (16.04 18.04)
for VERSION in 18.04
do
  if [[ ! -z $DockerHubPrefix ]]; then
    ImageName="$DockerHubPrefix/$ImageName"
  else
    ImageName="$ImageName$VERSION"
  fi

  for target in ${targets[@]}; do

    IMG=""
    TAG=""

    # Check AppendMode and use target on image_name or tag
    if [[ "$AppendMode" = "image" ]]; then
      IMG="$ImageName-${target}"
      TAG="${Tag}"
    elif [[ "$AppendMode" = "tag" ]];then
      if [[ "$Tag" = "latest" ]]; then
        IMG="$ImageName"
        TAG=":${target}"
      else
        IMG="$ImageName"
        TAG=":${target}-${Tag}"
      fi
    fi

    print_info "Building $IMG... (docker build -t $IMG:$TAG .)"
    if [[ $DryRun -eq 0 ]]; then
      cd ubuntu$VERSION-$target
      pwd
      docker build -t $IMG . --build-arg IMAGE=$IMG --build-arg TAG=$TAG
      cd ..
    fi

  done

done

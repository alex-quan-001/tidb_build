#/bin/bash

bin=`dirname $0`
bin=`cd $bin;pwd`

src="$bin/tics"
container_src_docker="/code"
container_cargohome="/cargo/CARGO_HOME"
cargo_source="${bin}/tics.docker.CARGO_HOME/.cargo"

script_dir="/go"
container_go_cache="$script_dir/GOCACHE"
container_go_path="$script_dir/GOPATH"
go_path="${bin}/tics.docker.GOPATH"
go_cache="${bin}/tics.docker.GOCACHE"

go_path="${bin}/tics.docker.GOPATH"
go_cache="${bin}/tics.docker.GOCACHE"
docker_name="tics_build"
#image_name="docker.io/rust:1.57.0"
#image_name="tiflash/tics:master"
image_name="tiflash_ci_image:latest"
#image_name="tics_build:0.1"

#docker stop ${docker_name} > /dev/null 2>&1
#docker rm   ${docker_name} > /dev/null 2>&1

tag=`docker images |grep rust | awk '{print $1":"$2}'`

if test "$tag" != "$image_name"
then
    docker pull  ${image_name} > /dev/null 2>&1
fi

docker run \
  -it \
  -v ${src}:${container_src_docker} \
  -v ${cargo_source}:${container_cargohome} \
  -v ${go_path}:${container_go_path} \
  -v ${go_cache}:${container_go_cache} \
  -e CARGO_HOME=${container_cargohome} \
  --privileged \
  --name ${docker_name} \
  -w ${container_src_docker} \
  ${image_name} \
  /bin/bash


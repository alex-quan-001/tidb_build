#/bin/bash

bin=`dirname $0`
bin=`cd $bin;pwd`

src="$bin/tikv"
container_src_docker="/code"
container_cargohome="/cargo/CARGO_HOME"
cargo_source="${bin}/tikv.docker.CARGO_HOME/.cargo"
docker_name="tikv_build"
image_name="rust:1.57.0"
#image_name="tikv_build:0.1"

#docker stop ${docker_name} > /dev/null 2>&1
#docker rm   ${docker_name} > /dev/null 2>&1

tag=`docker images |grep rust | awk '{print "rust:"$2}'`

if test "$tag" != "$image_name"
then
    docker pull  ${image_name} > /dev/null 2>&1
fi

docker run \
  -it \
  -v ${src}:${container_src_docker} \
  -v ${cargo_source}:${container_cargohome} \
  -e CARGO_HOME=${container_cargohome} \
  -w $container_src_docker \
  --privileged \
  --name ${docker_name} \
  ${image_name} \
  /bin/bash

# apt-get update; apt-get install cmake -y
#  -p 20160:20160 \

#/bin/bash

bin=`dirname $0`
bin=`cd $bin;pwd`

src="${bin}/tidb"
src_docker="/code"
script_dir="/go"
container_go_cache="$script_dir/GOCACHE"
container_go_path="$script_dir/GOPATH"
go_path="${bin}/tidb.docker.GOPATH"
go_cache="${bin}/tidb.docker.GOCACHE"
docker_name="tidb_build"
image_name="golang:1.16.4"
#image_name="tidb_build:0.1"


#docker stop ${docker_name} > /dev/null 2>&1
#docker rm   ${docker_name} > /dev/null 2>&1

tag=`docker images |grep golang | awk '{print "golang:"$2}'`

if test "$tag" != "$image_name"
then
    docker pull  ${image_name} > /dev/null 2>&1
fi

docker run \
  -it \
  -v ${src}:${src_docker} \
  -v ${go_path}:${container_go_path} \
  -v ${go_cache}:${container_go_cache} \
  --privileged \
  --name ${docker_name} \
  -w ${src_docker} \
  -e GOPATH="${container_go_path}" \
  -e GOCACHE="${container_go_cache}" \
  ${image_name} \
  /bin/bash

#  -p 4001:4000 \
# make server 

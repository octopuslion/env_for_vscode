#!/bin/bash

# options.
proj_image_repo=proj_tmpl_python
proj_image_tag=0.1-prod
proj_data_base=/home/~/proj_tmpl_server/dev/data/porj
proj_container_name=proj_tmpl_python_prod
proj_container_port=8082
proj_container_user=~
python_dir=/home/~/proj_tmpl_server/dev/env/python

# remove old container.
if [[ x$1 == "x-rebuild-image" || x$1 == "x-restart" ]];then
    proj_container_id=$(docker ps -a | grep -w $proj_container_name | tail -n 1 | awk '{print $1}')
    if [[ x$proj_container_id != "x" ]];then
        docker stop $proj_container_name
        docker rm $proj_container_name
    fi
fi

# remove old image and rebuild.
if [[ x$1 == "x-rebuild-image" ]];then
    proj_image_id=$(docker images | grep -w $proj_image_tag | grep -w $proj_image_repo | tail -n 1 | awk '{print $3}')
    if [[ x$proj_image_id != "x" ]];then
        docker rmi $proj_image_id
    fi

    # copy env files to current context.
    if [[ -d "./env" ]];then
        rm -rf ./env
    fi

    mkdir -p ./env/python
    cp -r $python_dir/* ./env/python

    # build new image.
    current_dir=$(pwd)
    cd $(dirname $0)
    docker build --no-cache -t $proj_image_repo:$proj_image_tag .
    cd $current_dir

    rm -rf ./env
fi

# start proj container if needed.
started_proj_container_id=$(docker ps | grep -w $proj_container_name | tail -n 1 | awk '{print $1}')
stoped_proj_container_id=$(docker ps -a | grep -w $proj_container_name | tail -n 1 | awk '{print $1}')
if [[ x$stoped_proj_container_id == "x" ]];then
    # it means no container, need to create and run a new container.
    docker run -d --user $(id -u $proj_container_user):$(id -g $proj_container_user) \
        -p $proj_container_port:8082 --name $proj_container_name \
        -v $proj_data_base/log:/app/log \
        $proj_image_repo:$proj_image_tag
elif [[ x$started_proj_container_id == "x" ]];then
    # it means the container is stopped, start it.
    docker start $stoped_proj_container_id
fi
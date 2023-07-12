#!/bin/bash

# options.
# image
mysql_image_repo=mysql
mysql_image_tag=8.0.33-debian

# container
mysql_data_base=/home/~/project/proj_tmpl_server/prod/data/mysql
mysql_container_name=proj_tmpl_mysql_prod
mysql_password=*
mysql_port=3306

# remove old container.
if [[ x$1 == "x-restart" ]];then
    mysql_container_id=$(docker ps -a | grep -w $mysql_container_name | tail -n 1 | awk '{print $1}')
    if [[ x$mysql_container_id != "x" ]];then
        docker stop $mysql_container_name
        docker rm $mysql_container_name
    fi
fi

# start mysql container if needed.
started_mysql_container_id=$(docker ps | grep -w $mysql_container_name | tail -n 1 | awk '{print $1}')
stoped_mysql_container_id=$(docker ps -a | grep -w $mysql_container_name | tail -n 1 | awk '{print $1}')
if [[ x$stoped_mysql_container_id == "x" ]];then
    # it means no container, need to create and run a new container.
    docker run -d --user $(id -u mysql):$(id -g mysql) -p $mysql_port:3306 --name $mysql_container_name \
        -v $mysql_data_base/conf:/etc/mysql/conf.d \
        -v $mysql_data_base/logs:/var/log/mysql \
        -v $mysql_data_base/data:/var/lib/mysql \
        -e MYSQL_ROOT_PASSWORD=$mysql_password \
        $mysql_image_repo:$mysql_image_tag
elif [[ x$started_mysql_container_id == "x" ]];then
    # it means the container is stopped, start it.
    docker start $stoped_mysql_container_id
fi
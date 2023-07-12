#!/bin/bash

current_path=$(cd "$(dirname "$0")";pwd)
export PATH=$current_path/python/install/bin:$PATH

user_path=$(cd ~;pwd)
prompt=$USER@$(uname -a | awk '{print $2}'):${current_path/$user_path/\~}:cli$
while true;do
    echo -n "$prompt "
    read arg
    $arg
done

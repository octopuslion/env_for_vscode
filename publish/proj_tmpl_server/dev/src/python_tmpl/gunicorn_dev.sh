#!/bin/bash

# options
python_dir=/home/~/proj_tmpl_server/dev/env/python/install/bin

current_dir=$(cd "$(dirname "$0")";pwd)
export PYTHONPATH=$current_dir/app:$PYTHONPATH
export PATH=$python_dir:$PATH

cd $current_dir/app
python3 -m gunicorn -c ../gunicorn_config.py app:app dev
# use "ps -ef | grep python3" to find process.
# use "kill -9" to kill the process.
# python3 -m gunicorn -D -c ../gunicorn_config.py app:app
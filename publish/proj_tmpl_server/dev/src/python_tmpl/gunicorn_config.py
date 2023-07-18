import multiprocessing
import os
import sys

# options.
opt_proj_dir_docker = '/app'
opt_proj_dir_env = '/home/~/proj_tmpl_server/dev/src/python_tmpl'

# for docker.
opt_proj_dir = opt_proj_dir_docker
opt_log_dir = f'{opt_proj_dir_docker}/log'
if len(sys.argv) > 1 and sys.argv[-1] == 'dev':
    # for dev.
    opt_proj_dir = opt_proj_dir_env
    opt_log_dir = f'{opt_proj_dir}/log_dev'

os.makedirs(opt_log_dir, exist_ok=True)

# 预加载资源
preload_app = True

# 绑定 ip + 端口
bind = '0.0.0.0:8082'

# 进程数 = cpu 数量 * 2 + 1
workers = multiprocessing.cpu_count() * 2 + 1

# 线程数 = cpu 数量 * 2
threads = multiprocessing.cpu_count() * 2

# 等待队列最大成都, 超过此长度的访问将被拒绝
backlog = 2048

# 工作模式为协程
worker_class = 'gevent'

# 最大客户端并发数量, 对使用线程和协程的 worker 的工作有影响
# 服务器配置值: 1200 - 中小型项目
worker_connections = 1200

# 进程名称
proc_name = f'{opt_log_dir}/proc.pid'

# 日志等级
loglevel = 'error'

# 日志文件
logfile = f'{opt_log_dir}/app.log'

# 错误日志文件
errorlog = f'{opt_log_dir}/error.log'

# 访问日志文件
accesslog = f'{opt_log_dir}/access.log'

# 设置访问日志格式, 错误日志不使用
# 参数:
# h     remote address
# l     '-'
# u     currently '-', may be user name in future releases
# t     date of the request
# r     status line (e.g. `GET / HTTP/1.1`)
# s     status
# b     response length or '-'
# f     referer
# a     user agent
# T     request time in seconds
# D     request time in microseconds
# L     request time in decimal seconds
# p     process id
access_log_format = '%(t)s %(p)s %(h)s "%(r)s" %(s)s %(L)s %(b)s %(f)s'

# 工作目录
chdir = f'{opt_proj_dir}/app'

# 超时
# timeout = 30

print('launch flask using gunicorn with config file.')
print(f'running on http://{bind}.')

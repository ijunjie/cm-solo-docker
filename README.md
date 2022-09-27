## solo 节点容器化

默认关闭 docker-go-vm 合约虚拟机， 因为容器中难以嵌套容器
```conf
vm:
  enable_dockervm: false
```

实际使用时，可以挂载 volume:

### 1. 容器内 /app/config/certs
可以使用其他证书，目录结构如下
```text
certs/
|-- ca
|   `-- ca.crt
`-- node
    |-- consensus1.nodeid
    |-- consensus1.sign.crt
    |-- consensus1.sign.key
    |-- consensus1.tls.crt
    `-- consensus1.tls.key
```

### 2./app/config/chainconfig
链配置，chainconfig/{bc1.yml, bc2.yml}

### 3./app/config/chainmaker.yml
程序配置。可以开启 vm.enable_dockervm 选项，但是使用 TCP 模式，例如
```yml
vm:
  enable_dockervm: true # 打开 dockervm
  uds_open: false # 关闭 uds, 改用 TCP 方式
  docker_vm_host: 192.168.205.128 # docker host ip
  docker_vm_port: 22351
```
在 docker host 机器要提前启动 docker vm

### 5./app/config/log.yml
建议不更改，使用容器内默认的即可，关键配置 log.system.log_in_console=true 使日志输出到前台

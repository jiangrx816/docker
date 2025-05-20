# docker
本地开发环境配置

# 启动服务
docker-compose -f docker-compose.yml up -d


## 1.目录结构

```
/
├── docker                      项目名目录
│   ├── logstash                logstash配置相关目录
│   ├── nginx                   nginx配置相关目录
│   ├── docker-compose.yml      Docker 服务配置示例文件
│   └── restart.sh              容器服务重启脚本
└── README.md                   说明文档
```

## 2.快速使用
### 1. 本地安装
    - `git`
    - `Docker`(系统需为Linux，Windows 10 Build 15063+，或MacOS 10.12+，且必须要`64`位）
    - `docker-compose 1.7.0+`
### 2. `clone`项目：
    ```
    $ git clone https://github.com/jiangrx816/docker.git
    ```
### 3. 配置文件（Windows系统请用`copy`命令），启动：
    ```
    $ cd docker                                         # 进入项目目录

    $ docker-compose up                                 # 启动

    $ docker-compose up -d                              # 后台启动
    ```
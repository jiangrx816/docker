#!/bin/bash

echo "等待 Nginx 启动完成..."
# Step 1: 启动  Nginx 服务
docker-compose -f ./nginx/docker-compose.yml up -d

echo "等待 MySQL 启动完成..."
# Step 2: 启动  MySQL 服务
docker-compose -f ./mysql/docker-compose.yml up -d

echo "等待 Redis 启动完成..."
# Step 3: 启动 Redis 服务
docker-compose -f ./redis/docker-compose.yml up -d

echo "等待 Elasticsearch 启动完成..."
# Step 4: 启动 Elasticsearch 服务
docker-compose -f ./elasticsearch/docker-compose.yml up -d

echo "等待 Kibana 启动完成..."
# Step 5: 启动 Kibana 服务
docker-compose -f ./kibana/docker-compose.yml up -d

echo "等待 Logstash 启动完成..."
# Step 6: 启动 Logstash 服务
docker-compose -f ./logstash/docker-compose.yml up -d

echo "等待 Rabbitmq 启动完成..."
# Step 7: 启动 Rabbitmq 服务
docker-compose -f ./rabbitmq/docker-compose.yml up -d
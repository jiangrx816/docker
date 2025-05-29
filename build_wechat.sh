#!/bin/bash

# 检查是否传入版本号
if [ -z "$1" ]; then
  echo "❌ 错误：请传入版本号，例如：1.0.0"
  exit 1
fi

VERSION="$1"

# 校验版本号格式：必须是 x.y.z，且 x/y/z 为数字
if ! [[ "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "❌ 错误：版本号格式不正确，正确格式为 X.Y.Z，例如：1.0.0"
  exit 1
fi

IMAGE_TAG="wechat:${VERSION}-amd64"

# 检查镜像是否已存在
if docker images --format '{{.Repository}}:{{.Tag}}' | grep -q "^${IMAGE_TAG}$"; then
  echo "❌ 错误：镜像 ${IMAGE_TAG} 已存在。"

  # 获取当前 wechat:*-amd64 镜像中最大的版本号
  LATEST_VERSION=$(docker images --format '{{.Tag}}' | grep '^.*-amd64$' | grep '^.*wechat' \
    | sed 's/-amd64//' | sort -Vr | head -n1)

  # 提示下一个建议版本号
  if [[ "$LATEST_VERSION" =~ ^([0-9]+)\.([0-9]+)\.([0-9]+)$ ]]; then
    MAJOR="${BASH_REMATCH[1]}"
    MINOR="${BASH_REMATCH[2]}"
    PATCH="${BASH_REMATCH[3]}"
    NEXT_VERSION="${MAJOR}.${MINOR}.$((PATCH + 1))"
    echo "✅ 当前最新版本为：$LATEST_VERSION，建议使用下一个版本号：$NEXT_VERSION"
  fi

  exit 1
fi

# 构建 Docker 镜像
docker buildx build \
  --platform linux/amd64 \
  -t "${IMAGE_TAG}" \
  --output type=docker \
  .
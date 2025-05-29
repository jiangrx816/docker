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

  # 提取已有 wechat:*-amd64 镜像的版本号，并找出最大版本
  LATEST_VERSION=$(docker images --format '{{.Repository}}:{{.Tag}}' \
    | grep '^wechat:' \
    | grep '\-amd64$' \
    | sed -E 's/^wechat:([0-9]+\.[0-9]+\.[0-9]+)-amd64$/\1/' \
    | sort -Vr \
    | head -n 1)

  if [[ "$LATEST_VERSION" =~ ^([0-9]+)\.([0-9]+)\.([0-9]+)$ ]]; then
    MAJOR="${BASH_REMATCH[1]}"
    MINOR="${BASH_REMATCH[2]}"
    PATCH="${BASH_REMATCH[3]}"
    NEXT_VERSION="${MAJOR}.${MINOR}.$((PATCH + 1))"
    echo "✅ 当前版本或存在，建议使用下一个版本号：$NEXT_VERSION"
  else
    echo "⚠️ 没有找到合法的 wechat 镜像版本，或者版本格式异常。"
  fi

  exit 1
fi

# 构建 Docker 镜像
docker buildx build \
  --platform linux/amd64 \
  -t "${IMAGE_TAG}" \
  --output type=docker \
  .
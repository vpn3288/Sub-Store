# Dockerfile for Sub-Store
FROM node:22-alpine

# 安装 pnpm
RUN npm install -g pnpm@11.0.9

WORKDIR /app

# 复制 backend 目录
COPY backend/package.json backend/pnpm-lock.yaml ./
COPY backend/ ./

# 安装依赖并构建
RUN pnpm install --frozen-lockfile
RUN pnpm bundle:esbuild

# 创建数据目录
RUN mkdir -p /app/data

# 设置环境变量
ENV NODE_ENV=production
ENV SUB_STORE_DATA_BASE_PATH=/app/data
ENV SUB_STORE_BACKEND_API_PORT=3000
ENV SUB_STORE_BACKEND_API_HOST=::

# 暴露端口
EXPOSE 3000

# 启动命令
CMD ["node", "sub-store.min.js"]

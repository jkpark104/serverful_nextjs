# 멀티 스테이지 빌드 사용
FROM node:22-slim AS base

# pnpm 설치
RUN npm install -g pnpm

# 의존성 설치 스테이지
FROM base AS deps
WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

# 빌드 스테이지
FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN pnpm build

# 실행 스테이지
FROM node:22-slim AS runner
WORKDIR /app

# 필요한 파일들만 복사
COPY --from=builder /app/.next/standalone ./

EXPOSE 3000
ENV PORT=3000
ENV HOSTNAME="0.0.0.0"

CMD ["node", "server.js"]
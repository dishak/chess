FROM node:20-alpine AS root_image
WORKDIR /root

COPY package.json yarn.lock ./
COPY ./packages/eslint-config ./packages/eslint-config
COPY ./packages/typescript-config ./packages/typescript-config
# COPY ./packages ./packages
RUN npm install

FROM node:20-alpine as frontend_img
WORKDIR /root
COPY --from=root_image /root ./
COPY ./packages/store ./packages/store
COPY ./packages/ui ./packages/ui
COPY ./apps/frontend/package.json ./apps/frontend/
COPY ./apps/frontend/package-lock.json ./apps/frontend/
RUN npm install
COPY ./apps/frontend ./apps/frontend/
CMD ["sh", "-c", "cd ./apps/frontend && npm run dev"]
# CMD ["sh", "-c", "while :; do sleep 1; done"]

FROM node:20-alpine as backend_img
WORKDIR /root
COPY --from=root_image /root ./
COPY ./packages/db ./packages/db
COPY ./apps/backend/package.json ./apps/backend/
COPY ./apps/backend/package-lock.json ./apps/backend/
RUN npm install
COPY ./apps/backend ./apps/backend/
CMD ["sh", "-c", "cd ./apps/backend && npm run dev"]


FROM node:20-alpine as ws_img
WORKDIR /root
COPY --from=root_image /root ./
# COPY ./packages ./packages
COPY ./packages/db ./packages/db
COPY ./apps/ws/package.json ./apps/ws/
COPY ./apps/ws/package-lock.json ./apps/ws/
RUN npm install
COPY ./apps/ws ./apps/ws/
CMD ["sh", "-c", "cd ./apps/ws && npm run dev"]
# CMD ["sh", "-c", "while :; do sleep 1; done"]
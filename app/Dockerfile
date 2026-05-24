FROM node:22-alpine AS builder

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

FROM node:22-alpine

WORKDIR /app

COPY --from=builder /app .

RUN mkdir /data

EXPOSE 3000

CMD ["node", "server.js"]

FROM node:18-alpine AS dependencies

WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn

FROM node:18-alpine AS build

WORKDIR /app
COPY --from=dependencies /app/node_modules ./node_modules

ARG DATABASE_URL
ENV DATABASE_URL $DATABASE_URL
RUN printenv >> .env

COPY . .


RUN npx prisma migrate deploy
RUN yarn build

FROM node:18-alpine AS deploy

WORKDIR /app

ENV NODE_ENV production

COPY --from=build /app/public ./public
COPY --from=build /app/package.json ./package.json
COPY --from=build /app/.next/standalone ./
COPY --from=build /app/.next/static ./.next/static
COPY --from=build /app/startup.sh ./startup.sh

EXPOSE 3000

ENV PORT 3000

CMD node server.js

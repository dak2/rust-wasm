FROM rust:slim
WORKDIR /app
COPY . ./
RUN set -ex \
    && apt-get update \
    && apt-get install -y git curl ca-certificates pkg-config make unzip --no-install-recommends \
    && curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh \
    && apt-get update \
    && rustup target add wasm32-unknown-unknown \
    && cargo install cargo-generate trunk \
    && mkdir /app
ENV USER=root

FROM node:18-slim
WORKDIR /wasm-game-of-life/www
COPY wasm-game-of-life/www/package*.json wasm-game-of-life/www/node_modules ./
RUN npm install --legacy-peer-deps
COPY /wasm-game-of-life/www .
EXPOSE 8080
ENV NODE_OPTIONS=--openssl-legacy-provider
CMD ["npm", "run", "start"]


FROM rust:slim

RUN set -ex \
    && apt-get update \
    && apt-get install -y git curl ca-certificates pkg-config make unzip --no-install-recommends \
    && curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh \
    && apt-get update \
    && apt-get install -y nodejs --no-install-recommends \
    && rustup target add wasm32-unknown-unknown \
    && cargo install cargo-generate trunk \
    && npm cache verify \
    && mkdir /app

ENV USER=root
WORKDIR /app

# syntax = docker/dockerfile:experimental
ARG RUBY_VERSION=3.1.2
ARG VARIANT=bullseye
ARG BASE_TAG=sha-79fd7210779fec4c4745a5f5b2210ff0a9f09cca
FROM ghcr.io/lutriseng/ruby-base/${RUBY_VERSION}/${VARIANT}:${BASE_TAG} AS base

ARG NODE_VERSION=16
ARG BUNDLER_VERSION=2.3.14

SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

RUN mkdir /app
WORKDIR /app
RUN useradd -d /app -u 9000 fleetbox
RUN chown -R fleetbox:fleetbox /app
USER fleetbox

RUN mkdir -p tmp/pids

ARG PRE_PACKAGES="curl"
ENV PRE_PACKAGES=${PRE_PACKAGES}
ARG EXTRA_PROD_PACKAGES=""
ARG PROD_PACKAGES="postgresql-client file vim curl gzip libsqlite3-0 nodejs make git ${EXTRA_PROD_PACKAGES}"
ENV PROD_PACKAGES=${PROD_PACKAGES}

USER root
RUN --mount=type=cache,id=prod-apt-cache,sharing=locked,target=/var/cache/apt \
    --mount=type=cache,id=prod-apt-lib,sharing=locked,target=/var/lib/apt \
    apt-get update -qq && \
    apt-get install --no-install-recommends -y ${PRE_PACKAGES} && \
    (curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash -) && \
    apt-get update -qq && \
    apt-get install --no-install-recommends -y ${PROD_PACKAGES} && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives \
USER fleetbox

USER root
RUN corepack enable
USER fleetbox

ARG RAILS_ENV=production
ENV RAILS_ENV=${RAILS_ENV}

ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

ARG BUNDLE_WITHOUT=development:test
ARG BUNDLE_PATH=vendor/bundle
ENV BUNDLE_PATH ${BUNDLE_PATH}
ENV BUNDLE_WITHOUT ${BUNDLE_WITHOUT}

FROM base as dev

ARG DEV_PACKAGES="git build-essential libpq-dev wget vim curl gzip xz-utils libsqlite3-dev"
ENV DEV_PACKAGES ${DEV_PACKAGES}

USER root
RUN --mount=type=cache,id=dev-apt-cache,sharing=locked,target=/var/cache/apt \
    --mount=type=cache,id=dev-apt-lib,sharing=locked,target=/var/lib/apt \
    apt-get update -qq && \
    apt-get install --no-install-recommends -y ${DEV_PACKAGES} && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives
USER fleetbox

USER root
RUN gem install -N bundler -v ${BUNDLER_VERSION}
USER fleetbox

FROM dev as gems

COPY --chown=root Gemfile* ./
RUN bundle config set deployment true && bundle install && rm -rf vendor/bundle/ruby/*/cache

FROM base

COPY --chown=root --from=gems /app /app

ENV SECRET_KEY_BASE 1

COPY --chown=root . .

USER root
RUN mkdir -p junit/ tmp/ public/assets/ log/
RUN chown -R fleetbox:fleetbox junit/ tmp/ public/assets/ log/
USER fleetbox

RUN bin/rails assets:precompile

USER root
RUN chown -R root:root public/assets/
USER fleetbox

ENV PORT 8080

CMD make local-prod-server

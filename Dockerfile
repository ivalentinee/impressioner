FROM elixir:1.14.3-slim AS dev

EXPOSE 4000

ENV NODE_ENV=development

RUN useradd --uid 1000 -U -ms /bin/bash elixir

# required packages
RUN apt-get update && \
    apt-get install -y inotify-tools build-essential && \
    apt-get clean

RUN mix local.hex --force && mix local.rebar --force && \
    su -l elixir -c "mix local.hex --force && mix local.rebar --force"

RUN mkdir /app
WORKDIR /app

# ------------------------------
FROM dev AS test

COPY mix.exs mix.lock /app/
RUN mix deps.get

ADD . /app

RUN mix compile

# ------------------------------
FROM dev AS prod

ENV MIX_ENV=prod NODE_ENV=production

COPY mix.exs mix.lock /app/
RUN mix local.hex --force && \
    mix deps.get && \
    mix local.rebar --force

ADD . /app

RUN mix compile && \
    mix phx.digest

CMD bash -c "mix phx.server"

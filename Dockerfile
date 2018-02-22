FROM elixir:1.6.0

# required packages
RUN apt-get update && \
    apt-get install -y inotify-tools build-essential && \
    apt-get clean

# node + yarn
RUN curl --silent --location https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs && \
    npm install yarn -g && \
    apt-get clean

RUN mkdir /app
WORKDIR /app

ENV MIX_ENV=prod NODE_ENV=production

# hex deps
COPY mix.exs mix.lock /app/
RUN mix local.hex --force && \
    mix deps.get && \
    mix local.rebar --force

# node packages
COPY package.json yarn.lock /app/
RUN yarn install -s --frozen-lockfile --non-interactive

EXPOSE 4000

ADD . /app

# build application
RUN mix compile && \
    npm run build && \
    mix phx.digest

CMD bash -c "mix phx.server"

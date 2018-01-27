# Impressioner

## Setup your Phoenix app:

    $ docker-compose build
    $ docker-compose run --rm web mix deps.get
    $ docker-compose run --rm web yarn -s --frozen-lockfile --non-interactive
    $ docker-compose up -d

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Start/restart/stop Phoenix app:

    $ docker-compose start
    $ docker-compose restart
    $ docker-compose stop

## Roadmap (may change)

- ~MobX~
- Usage in "README"
- "Next slide preview"
- Improved controls
- Keep current state (aka "Sessions")
- Authentication

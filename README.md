# Impressioner

## Setup your Phoenix app:
```sh
$ docker-compose build
$ docker-compose run --rm web mix deps.get
$ docker-compose run --rm web yarn -s --frozen-lockfile --non-interactive
$ docker-compose up -d
```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Start/restart/stop Phoenix app:
```sh
$ docker-compose start
$ docker-compose restart
$ docker-compose stop
```

## Automatically format code
```sh
$ docker-compose run --rm web mix format --check-equivalent
$ docker-compose run --rm web npm run eslint -- --fix
```

## Tests and linters
### Elixir tests:
```sh
$ docker-compose run --rm web mix test
```

### Elixir linter:
```sh
$ docker-compose run --rm web mix format --check-formatted
```

### JS tests
*TBD*

### JS linter
```sh
$ docker-compose run --rm web npm run eslint
```

## Roadmap (may change)

- ~MobX~
- Usage in "README"
- "Next slide preview"
- Improved controls
- Keep current state (aka "Sessions")
- Authentication

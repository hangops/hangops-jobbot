# Hangbot

You've found HangOps friendly Chat Robot Hangbot

### Docker

Hangbot will now run within a docker container. If you do this, you will need to `rm -r node_modules` as the locally installed modules will often conflict with the Docker (linux) runtime.

1.  Edit `.env` to fit your needs, it defaults to a docker-compose redis instance. `cp .env.sample .env` would be a fine places to start modifying $ENV to suit your needs
2.  `cp docker-compose.override{.example,}.yml docker-compose.yml` combined with step one will help you get your container up with your custom ENV
3.  Then you can run either:
  * `make run` to run a real hangbot instance, connected to slack, your slack token is required to be set in `.env`
  * `make interactive` or simply `make` to run in interactive mode, which does not connect to slack.


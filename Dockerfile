FROM articulate/articulate-node:8-alpine

USER $SERVICE_USER

RUN mkdir $SERVICE_ROOT/scripts/
RUN mkdir $SERVICE_ROOT/scripts/vendor/
RUN mkdir $SERVICE_ROOT/scripts/vendor/src/
RUN mkdir $SERVICE_ROOT/scripts/vendor/src/hubot-slack-whitelist-middleware

COPY --chown=service:service /scripts/vendor/hubot-slack-whitelist-middleware/package.json $SERVICE_ROOT/scripts/vendor/hubot-slack-whitelist-middleware/
COPY --chown=service:service /scripts/vendor/hubot-slack-whitelist-middleware/src/index.coffee $SERVICE_ROOT/scripts/vendor/hubot-slack-whitelist-middleware/src/index.coffee
COPY --chown=service:service package.json $SERVICE_ROOT/
RUN yarn install && yarn cache clean

COPY --chown=service:service . $SERVICE_ROOT/
ENV PATH $PATH:/$SERVICE_ROOT/node_modules/.bin

CMD hubot --adapter slack --name $HUBOT_NAME
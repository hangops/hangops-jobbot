FROM articulate/articulate-node:8-alpine

USER $SERVICE_USER

RUN mkdir $SERVICE_ROOT/scripts/
COPY --chown=service:service package.json $SERVICE_ROOT/
RUN yarn install && yarn cache clean

COPY --chown=service:service . $SERVICE_ROOT/
ENV PATH $PATH:/$SERVICE_ROOT/node_modules/.bin

CMD hubot --adapter slack --name $HUBOT_NAME
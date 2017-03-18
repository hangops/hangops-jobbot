# Configuration:
#   HUBOT_WHITELIST
#   HUBOT_WHITELIST_PATH

reach = require('hoek').reach
path = require('path')

module.exports = (robot) ->

  # Establish whitelist
  whitelist = []
  if process.env.HUBOT_WHITELIST
    whitelist = process.env.HUBOT_WHITELIST.split(',')
  else if process.env.HUBOT_WHITELIST_PATH
    whitelist = require(path.resolve(process.env.HUBOT_WHITELIST_PATH))

  unless Array.isArray(whitelist)
    robot.logger.error 'whitelist is not an array!'

  robot.receiveMiddleware (context, next, done) ->
    # Get channel name from client's cache (https://github.com/slackapi/hubot-slack/issues/328)
    channelName = robot.adapter.client.rtm.dataStore.getChannelGroupOrDMById(reach(context, 'response.envelope.room')).name

    # Unless the room is in the whitelist
    unless channelName in whitelist
      # We're done
      context.response.message.finish()
      done()
    else
      next(done)

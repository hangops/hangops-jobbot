# Configuration:
#   HUBOT_WHITELIST
#   HUBOT_WHITELIST_PATH

reach = require('hoek').reach
path = require('path')

module.exports = (robot) ->

  # Establish whitelist
  whitelist = []
  if process.env.HUBOT_WHITELIST
    robot.logger.debug "I am whitelisted for the following channels: #{process.env.HUBOT_WHITELIST}"
    whitelist = process.env.HUBOT_WHITELIST.split(',')
    robot.logger.debug "Whitelist after split: #{whitelist}"
  else if process.env.HUBOT_WHITELIST_PATH
    whitelist = require(path.resolve(process.env.HUBOT_WHITELIST_PATH))

  unless Array.isArray(whitelist)
    robot.logger.error 'whitelist is not an array!'

  robot.receiveMiddleware (context, next, done) ->
    # Get channel name from client's cache (https://github.com/slackapi/hubot-slack/issues/328)
    channelName = robot.adapter.client.rtm.dataStore.getChannelGroupOrDMById(reach(context, 'response.envelope.room')).name
    robot.logger.debug "I see the Channel Name as: #{channelName}"

    # Unless the room is in the whitelist
    unless channelName in whitelist
      # We're done
      robot.logger.debug "I am NOT in a whitelisted channel #{channelName}"
      context.response.message.finish()
      done()
    else
      robot.logger.debug "I am whitelisted for this channel #{channelName} so I'll process this message normally"
      next(done)

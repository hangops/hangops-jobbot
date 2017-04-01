module.exports = (robot) ->

  robot.hear /is hiring|to hire/i, (res) ->
    robot.logger.debug "I heard: #{res.message.text} - so I'll remind now"
    res.reply "If you haven't already, feel free to pin your Job Description and add it to the Google Doc listed in the topic ---^"

  robot.hear /gdoc (.*)?/i, (res) ->
    targetuser = res.match[1]

    user = robot.adapter.client.rtm.dataStore.getUserByName(targetuser)
    if !user
      robot.logger.debug "Told to remind #{targetuser} about the gdoc, but they are not a user."
      return

    channel = robot.adapter.client.rtm.dataStore.getChannelById(res.user.room)
    if channel.members.find((id) -> id == user.id) !== undefined
      robot.logger.debug "Told to remind #{targetuser} about the gdoc, but ehy are not in this room."
      return

    robot.logger.debug "Received targetted Google document remind message will remind #{res.message.text}"
    res.send "@#{targetuser} If you haven't already, feel free to pin your Job Description and add it to the Google Doc listed in the topic ---^"

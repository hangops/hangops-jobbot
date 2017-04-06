module.exports = (robot) ->

  robot.hear /is hiring|to hire/i, (res) ->
    robot.logger.debug "I heard: #{res.message.text} - so I'll remind now"
    res.reply "If you haven't already, feel free to pin your job description and add it to the Google Doc listed in the topic ---^\n(I've included a direct link for your convenience: https://docs.google.com/spreadsheets/d/1rtHao8rpI2aRA678ASQK-7NXpHcumd4LQGTtq5y7AiE)"

  robot.hear /gdoc (.*)?/i, (res) ->
    targetuser = res.match[1]

    user = robot.adapter.client.rtm.dataStore.getUserByName(targetuser)
    if !user
      robot.logger.debug "Told to remind #{targetuser} about the gdoc, but they are not a user."
      return

    robot.logger.debug "Received targetted Google document remind message will remind #{res.message.text}"
    res.send "@#{targetuser} If you haven't already, feel free to pin your job description and add it to the Google Doc listed in the topic ---^\n(I've included a direct link for your convenience: https://docs.google.com/spreadsheets/d/1rtHao8rpI2aRA678ASQK-7NXpHcumd4LQGTtq5y7AiE)"

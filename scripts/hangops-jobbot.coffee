module.exports = (robot) ->

  robot.hear /is hiring|to hire|re hiring|is looking for/i, (res) ->
    robot.logger.debug "I heard: #{res.message.text} - so I'll remind now"
    res.reply "If you haven't already, feel free to pin your job description and add it via the Google form listed in the topic ---^\n(I've included a direct link for your convenience: https://bit.ly/2Iv436W)\nView jobs at: https://bit.ly/2EsFzXS"

  robot.hear /gdoc (.*)?/i, (res) ->
    targetuser = res.match[1]

    # search targetuser for @ and yank (if its there), then match against room
    targetuser = targetuser.replace(/@/g, '')

    user = robot.adapter.client.rtm.dataStore.getUserByName(targetuser)
    if !user
      robot.logger.debug "Told to remind #{targetuser} about the gdoc, but they are not a user."
      return

    robot.logger.debug "Received targeted Google document remind message will remind #{res.message.text}"
    res.send "@#{targetuser} If you haven't already, feel free to pin your job description and add it via the Google form listed in the topic ---^\n(I've included a direct link for your convenience: https://bit.ly/2Iv436W)\nView jobs at: https://bit.ly/2EsFzXS"
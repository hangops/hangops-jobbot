module.exports = (robot) ->

  robot.hear /gdoc/i, (res) ->
    # TODO: figure out who last posted a link and @<username> message them
    robot.logger.debug "Received Google document remind message will remind #{res.message.text}"
    res.send "If you haven't already, feel free to pin your Job Description and add it to the Google Doc listed in the topic ---^"

  robot.hear /is hiring|to hire/i, (res) ->
    robot.logger.debug "I heard: #{res.message.text} - so I'll remind now"
    res.reply "If you haven't already, feel free to pin your Job Description and add it to the Google Doc listed in the topic ---^"

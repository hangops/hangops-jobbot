module.exports = (robot) ->

#  robot.hear /gdoc/i, (res) ->
#    robot.logger.debug "Received Google document remind message will remind #{res.message.text}"
#    res.send "If you haven't already, feel free to pin your Job Description and add it to the Google Doc listed in the topic ---^"

  robot.hear /is hiring|to hire/i, (res) ->
    robot.logger.debug "I heard: #{res.message.text} - so I'll remind now"
    res.reply "If you haven't already, feel free to pin your Job Description and add it to the Google Doc listed in the topic ---^"

  robot.hear /gdoc (.*)?/i, (res) ->
    targetuser = res.match[1]
    robot.logger.debug "Received targetted Google document remind message will remind #{res.message.text}"
    res.send "@#{targetuser} If you haven't already, feel free to pin your Job Description and add it to the Google Doc listed in the topic ---^"

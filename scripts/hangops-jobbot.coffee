module.exports = (robot) ->

  robot.hear /gdoc/i, (res) ->
    robot.logger.debug "Received Google document remind message will remind #{res.message.text}"
    res.send "If you haven't already, feel free to pin your Job Description and add it to the Google Doc listed in the topic ---^"

#  robot.hear /job (.*) (.*) (.*) /i, (res) ->
#    robot.respond /job (.*) (.*) (.*) /i, (res) ->
#      jobStatus = res.match[1]
#      jobURL = res.match[2]
#      jobTime = res.match[3]
#      if jobStatus is "open"
#          res.reply "Opened Job and posted to Gdoc"
#      else
#          res.reply "Failed to Open"
#      robot.logger.debug "Job will be posted for X #{res.message.text}"
#      res.send "This is a test of bot"
  
  robot.hear /looking for/i, (res) ->
    robot.logger.debug "I heard `looking for` so I'll remind now - text I hear is as follows: #{res.message.text}"
    res.reply "If you haven't already, feel free to pin your Job Description and add it to the Google Doc listed in the topic ---^"

  robot.hear /candidate/i, (res) ->
    robot.logger.debug "I heard `candidate` so I'll remind now - text I hear is as follows: #{res.message.text}"
    res.reply "If you haven't already, feel free to pin your Job Description and add it to the Google Doc listed in the topic ---^"

  robot.hear /to hire/i, (res) ->
    robot.logger.debug "I heard `to hire` so I'll remind now - text I hear is as follows: #{res.message.text}"
    res.reply "If you haven't already, feel free to pin your Job Description and add it to the Google Doc listed in the topic ---^"
    
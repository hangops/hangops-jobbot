module.exports = (robot) ->
  robot.listen(

  robot.hear /gdoc/i, (res) ->
    robot.logger.debug "Received remind message will remind #{res.message.text}"
    res.send "if you haven't already, feel free to pin your Job Description and add it to the Google Doc listed in the topic ---^"

  robot.respond /job (.*) (.*) (.*) /i, (res) ->
    jobStatus = res.match[1]
    jobURL = res.match[2]
    jobTime = res.match[3]
    if jobStatus is "open"
        res.reply "Opened Job and posted to Gdoc"
    else
        res.reply "Failed to Open"
    # robot.logger.debug "Job will be posted for X #{res.message.text}"
    # res.send "This is a test of bot"
)

module.exports = (robot) ->
  robot.listen(

  robot.hear /remind/i, (res) ->
    robot.logger.debug "Received remind message will remind #{res.message.text}"
    res.send "if you haven't already, feel free to pin your Job Description and add it to the Google Doc listed in the topic ---^"
  )

cronJob = require('cron').CronJob
module.exports = (robot) ->
  new cronJob
    cronTime: "0 0 19 * * 1-5"
    onTick: ->
      robot.send {room: "general"}, "おしごとおつかれさまにゃ"
      return
    start: true
    timeZone: "Asia/Tokyo"
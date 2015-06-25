# Description:
#   定時になると挨拶をgeneralに流す
#
# Notes:
#   残業に対してあまり手厳しい罵倒にしないこと。
#    ねぎらいの気持ちが重要。
#
cron = require('cron').CronJob
module.exports = (robot) ->
  new cron '0 0 19 * * 1-5', () =>
    robot.send {room: "#general"}, "おしごとおつかれさまにゃ"
  , null, true, "Asia/Tokyo"
# Description:
#   定時になると挨拶をgeneralに流す
#
# Notes:
#   残業に対してあまり手厳しい罵倒にしないこと。
#   ねぎらいの気持ちが重要。
#   "定時になりました。いつまでもダラダラ仕事してんじゃねーよ亀かよ"とか書いたりしないこと
#
cron = require('cron').CronJob
module.exports = (robot) ->
  new cron '0 0 19 * * 1-5', () =>
    robot.send {room: "#general"}, "おしごとおつかれさまにゃ"
  ,null, true, "Asia/Tokyo"

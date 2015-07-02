# Description:
#   天気予報を返す
#
# Notes:
#   とくになし
#
module.exports = (robot) ->
  robot.respond /(天気|てんき)/i, (msg) ->
    request = msg.http('http://weather.livedoor.com/forecast/webservice/json/v1')
    .query(city: '130010')
    .get()
    request (err, res, body) ->
      json = JSON.parse body
      msg.reply json['forecasts'][0]['telop']+'にゃん'

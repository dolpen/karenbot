# Description:
#   イカレギュラーマッチのステージ情報を返す
#
# Notes:
#   イカ、よろしくー
#
module.exports = (robot) ->
  robot.respond /(イカ)/i, (msg) ->
    request = msg.http('http://s3-ap-northeast-1.amazonaws.com/splatoon-data.nintendo.net/stages_info.json')
    .get()
    request (err, res, body) ->
      json = JSON.parse body
      msg.reply 'レギュラーは'+json[0]['stages'][0]['name']+'と'+json[0]['stages'][1]['name']+'だよ。イカ、よろしくー'

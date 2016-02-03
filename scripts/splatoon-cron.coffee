# Description:
#   イカレギュラーマッチのステージ情報を返す
#
# Notes:
#   イカ、よろしくー
#
data_r = [
  "0 0 11 * * *",
  "0 0 15 * * *",
  "0 0 19 * * *"
]

sendNews = (robot) ->
  resp = "ハイカラニュースの時間だよ!\n"
  request_fes = robot.http("http://s3-ap-northeast-1.amazonaws.com/splatoon-data.nintendo.net/fes_info.json").get()
  request_fes (err, res, body_fes) ->
    json_fes = JSON.parse body_fes
    fes_state = json_fes["fes_state"]
    if fes_state >= 0
      state = ["告知", "開催"][fes_state]
      resp += "フェスが" + state + "されているよ!\n"
      resp += "お題は " + json_fes["team_alpha_name"] + " 対 " + json_fes["team_bravo_name"] + " だよ。\n"
    if fes_state == 1
      resp += "レギュラーは " + json_fes["fes_stages"][0]["name"] + " と " + json_fes["fes_stages"][1]["name"] + " と " + json_fes["fes_stages"][2]["name"] + " だよ。\n"
      resp += "イカ、よろしくー"
      robot.send {room: "#splatoon"}, resp
    else
      request_info = robot.http("https://splatoon.ink/schedule.json").get()
      request_info (err, res, body) ->
        json_info = JSON.parse body
        now_time = (new Date()).getTime()
        result = (item for item in json_info.schedule when item.startTime <= now_time and item.endTime >= now_time)[0]
        resp += "レギュラーは " + result.regular.maps[0]["nameJP"] + " と " + result.regular.maps[1]["nameJP"] + " だよ。\n"
        resp += "ガチマッチは " + result.ranked.maps[0]["nameJP"] + " と " + result.ranked.maps[1]["nameJP"] + " の " + result.ranked["rulesJP"] + " だよ。\n"
        resp += "イカ、よろしくー"
        robot.send {room: "#splatoon"}, resp

cron = require('cron').CronJob

module.exports = (robot) ->
  for i in data_r
    do (i) ->
      new cron i, () =>
        sendNews(robot)
      , null, true, "Asia/Tokyo"

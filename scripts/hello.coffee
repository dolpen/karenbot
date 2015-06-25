# Description:
#   pingや簡単なあいさつや生存確認のためのもの
#
# Notes:
#   重要なのは癒し
#
module.exports = (robot) ->
  robot.hear /にゃ/i, (msg) ->
    msg.send msg.random [
      "にゃ〜",
      "にゃんにゃん",
      "にゃ！",
      "にゃん",
      "にゃー",
      "にゃっ"
    ]

# scripts/hello.coffee
# 事実上の挨拶
module.exports = (robot) ->
  robot.respond /にゃ[んー〜っ]$/i, (msg) ->
    nyas = [
      "にゃ〜",
      "にゃんにゃん",
      "にゃ！",
      "にゃん",
      "にゃー",
      "にゃっ"
    ]
    nya = msg.random nyas
    msg.send "#{nya}"

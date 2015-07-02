# karenbot(karen)

heroku で動かすことを目的とした slack 用の hubot です。

[heroku]: http://www.heroku.com
[hubot]: http://hubot.github.com
[generator-hubot]: https://github.com/github/generator-hubot

### ローカルで動作確認する

```
% bin/hubot
```
上記コマンドで動作し、プロンプトが現れます(場合によってはEnterを一回押す必要がある)。
```
    [Sat Feb 28 2015 12:38:27 GMT+0000 (GMT)] INFO Using default redis on localhost:6379
    karen>
```
hubot でデフォルトで入っているコマンドに関しては、```karen help``` で確認できます。

```
    karen> karen help
    karen animate me <query> - The same thing as `image me`, except adds [snip]
    karen help - Displays all of the help commands that karen knows about.
    ...
```

### スクリプトを書く

``` /scripts ``` 以下に CoffeeScript で書きます。
コード例は実際にみてもらったほうが早い気がします。


### デプロイと heroku での動作

このアプリケーションは heroku の無料枠内で動作することを目指して作られています

 * [New App](https://dashboard.heroku.com/new)
から適当なアプリケーション名とリージョンを選んでアプリケーションを作成
 * 作成したアプリケーションのリソース画面に移動
 * dyno の設定を Free web 1台に固定する
 * Add-ons の Edit ボタンを押して、下記のアドオンを有効化
    * Redis Cloud
 * アプリケーションのプッシュ
    * 直接プッシュしても良いし、 GitHub などの外部リポジトリを連携させてもいい
    * わたしは GitHub のリポジトリから master head を常に参照するように設定してあります

ここまでで動作は出来るが、

 * heroku の規約が変更され、 Free の dyno が1日あたり18時間しか動かせない
    * 今は警告のみだが2ヶ月程度で強制停止される
 * Webサービスであれば、アクセスがなければ dyno は停止する(カウント外)が、
 hubot のように常時待ち受けるものは、明示的に止めないと確実に制限を突破する。
 * 動かす dyno の台数を時間帯で変更する Process Scheduler というアドオンは Free dyno に対応していない
  
という酷い状況なので、下記のように対処した。

 * 作成したアプリケーションのリソース画面に移動
 * Add-ons の Edit ボタンを押して、下記のアドオンを有効化
    * Heroku Scheduler
 * Heroku Scheduler の リンクで、Heroku API を定期的に curl させるコマンドを設定する

dyno の停止
```
curl -n -X PATCH https://api.heroku.com/apps/infinite-ocean-6752/formation -H "Accept: application/vnd.heroku+json; version=3" -H "Content-Type: application/json" -d '{"updates": [{"process": "web", "quantity": 0, "size": "Free"}]}'
```

dyno の起動
```
curl -n -X PATCH https://api.heroku.com/apps/infinite-ocean-6752/formation -H "Accept: application/vnd.heroku+json; version=3" -H "Content-Type: application/json" -d '{"updates": [{"process": "web", "quantity": 1, "size": "Free"}]}'
```

これを、 一日の動作時間が18時間を超えないように指定すればOK
(タイムゾーンに注意 / 18時間ギリギリだとたまに警告されるので、余裕を持ったほうがいい)



# Github Search
[Gihub Api](https://docs.github.com/ja/rest/search/search?apiVersion=2022-11-28#search-repositories)を利用してgithubのリポジトリを検索するアプリです。
2023年7月の3連休を使って急いで制作しました…！まだまだやりたいことや細かいところの修正はありますが、一旦は目標としていたところまで作成が出来ました。本当はデザインにこだわりたかった…。。

## 画面
・検索前<br>
<img width="372" alt="3d9d3f18-24c8-11ee-9cf3-06720a606bea" src="https://github.com/gahaku200/github_search/assets/59167773/5101cdfd-a265-4018-9c4e-1535882a8c3b"><br>
・検索後<br>
<img width="368" alt="135afe84-24c8-11ee-911e-06720a606bea" src="https://github.com/gahaku200/github_search/assets/59167773/d016d8e0-339c-4e13-9e26-2d947f8eb507"><br>
・検索詳細<br>
<img width="374" alt="8ecbe628-24c8-11ee-918e-064017533d40" src="https://github.com/gahaku200/github_search/assets/59167773/d300f33a-26be-4686-987c-703536e815c7"><br>
・メニューバー<br>
<img width="370" alt="a603edae-24c8-11ee-9128-064017533d40" src="https://github.com/gahaku200/github_search/assets/59167773/c46bfff3-bcb0-4239-97ba-6402792008a4"><br>
・エラーダイアログ<br>
<img width="375" alt="876b3ada-24ca-11ee-8a42-064017533d40" src="https://github.com/gahaku200/github_search/assets/59167773/df74a460-1642-44b0-ba87-70c05652baf0"><br>
・ダークモード<br>
<img width="371" alt="d104e194-24cc-11ee-b36c-064017533d40" src="https://github.com/gahaku200/github_search/assets/59167773/f958dd2a-1e98-4db8-9331-1570462cf40c"><br>

## 環境
|         | Version| 
| ------- | ------ |
| Flutter | 3.10.6 | 
| Dart    | 3.0.6  | 
| hooks_riverpod    | 2.3.6  | 
## 技術スタック
### アプリ機能
・githubリポジトリの検索と詳細表示<br>
・無限スクロール（スクロールが下までいくと30件づつデータが増えていく）<br>
・ダークモード対応<br>
・多言語対応（日本、英語のみでデバイスの言語設定を変更すると表示が変わる）<br>

###  テスト
あまりテストコードを書いたことがないのでファイルは少ないですが、一応以下のテストコードを作成しています。<br>
・Widgetテスト<br>
検索前と検索後のWidgetのテスト<br>
・Goldenテスト<br>
検索前と検索後のGoldenのテスト<br>
・Unitテスト<br>
モデルとNotifierのユニットテストを[Mockito](https://pub.dev/packages/mockito)パッケージを使用してテスト<br>

### gitコミット前のチェック
git commitした時にlefthook.ymlを使用してチェックするようにしています。下記を実施してエラーが出たらコミット出来ないようになっています。<br>
・`flutter test`コマンドを実施<br>
・`flutter analyze`コマンドを実施<br>
・[pedantic_mono](https://pub.dev/packages/pedantic_mono)パッケージを利用したlinter<br>
・[import_sorter](https://pub.dev/packages/import_sorter)パッケージを使用して自動でimportを並び替え<br>
・`dart format`コマンドを実施<br>

### github actions
・プルリクエストを作成後`flutter test`と`flutter analyze`が実施され、2つ項目に通過出来なかった場合マージ出来ないようになっています。<br>
・github actionsでmainブランチのアプリバージョンを変更出来るようになっています。アプリバージョンが1.0.0+1の場合、下記項目を選択するとそれぞれ結果で更新されます。<br>
|         | 結果| 
| ------- | ------ |
| major | 2.0.0+1 | 
| minor    | 1.1.0+1  | 
| patch    | 1.0.1+1  |
| build    | 1.0.0+2  |
 
<img width="754" alt="1aa4a9e0-24cf-11ee-90cf-06720a606bea" src="https://github.com/gahaku200/github_search/assets/59167773/3375815f-54ec-475d-924b-90304b23c36a"><br>
・mainブランチのアプリバージョンが変更される自動デプロイされる仕組みになっています。Appleの個人アカウントは持っていないので、androidのデプロイのみ実装(fastlaneを使用)しています。
ビルドファイルがGoogle Play Consoleの内部テストにデプロイされることになります。<br>

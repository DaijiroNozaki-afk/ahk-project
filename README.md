# ahk-project
これは、日付や定型文を簡単なキー操作で入力するホットストリングです。AutoHotkey v2は、Windows のみで動作します。

## インストール
[AutoHotkey](https://www.autohotkey.com/) をダウンロードします。このプログラムはv2.0 で書かれているので、ダウンロードページで「Download v2.0」の方をダウンロードし、動作させるWindows 機にインストールします。


VSCode をご利用の方は、「[AutoHotkey Plus Plus](https://marketplace.visualstudio.com/items?itemName=mark-wiemer.vscode-autohotkey-plus-plus)」をインストールしましょう。コーディングが快適になります。

### 備考
- AutoHotkey をインストールした後に付属する「Ahk2Exe」を使えば、AutoHotkey のプログラムを.exe 化できます。それを利用すれば、AutoHotkey をインストールしていないWindows 機でもホットストリングが使えるようになります。

## ファイル構成
- ore_hotstring-v2.ahk - プログラムの本体です。
- ore_hotstring.ahk - AutoHotkey のv1.1 で動いていたプログラムです。v2.0後方互換性は犠牲となっており、v1.1のために書かれたスクリプトは基本的に動作せず、改修の必要があります。
- README.md ahk-project についての説明書です。
- v2_tutorial.ahk - チュートリアルを受けたときに書いたメモです。

## 使い方
- ahk-project/ore_hotstring-v2.ahk を開きます。Windows のタスクバー右側の常駐アプリに「H」アイコンが増えます。プログラムはこれで起動しています。
- 主にテキストエディタで文字入力をするときに利用します。
- VSCode のターミナルでGit Bash を使うときも利用できます。
- Windows エクスプローラーでファイル名を変更中にも利用できます。ファイル名に年月日を入れたいときに使えます。
- ブラウザを利用したエディタではホットストリングが動作しません。Windows のエディタでご利用ください。

### 操作
- git push を素早く入力する
    - キー操作：gp[[ 
    - 入力例：git push -u origin HEAD

- git checkout を素早く入力する
    - キー操作：gch[[ 
    - 入力例：git checkout -b 

- git commit を素早く入力する
    - キー操作：gco[[ 
    - 入力例：git commit -m ""

- 今日の日付を入力する
    - キー操作：w[[
    - 入力例：2023年10月2日(月)
- 今日の日付を半角8桁で入力する
    - キー操作：q[[ 
    - 入力例：20231002
- 今年の指定日の日付を入力する
    - キー操作：t[[
    - キー操作後にダイアログが表示されて4桁の数字を入力できます。日付が4桁になるよう指定日の月日(1月1日なら「0101」)を入力してエンターキーを押すと、指定した日付が入力されます。
    - 入力例：2023年1月1日(日)

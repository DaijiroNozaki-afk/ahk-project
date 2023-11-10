#Requires AutoHotkey v2.0 ; v2.0 のバージョン要件が満たされない場合、エラーを表示し終了します
#Warn ;タイポや「グローバル」宣言の欠落など、エラーを示す可能性のある特定の条件に対する警告を出す
#SingleInstance Force ; スクリプトがすでに実行されている場合、ダイアログボックスをスキップして古いインスタンスを自動的に置き換える
#Hotstring * ; hotsting を終了文字無しで発動させる
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;git push を素早く入力する
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;gp[[ 
;git push -u origin HEAD
::gp[[::
{
A_Clipboard := "git push -u origin HEAD"
Send "+{INSERT}"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;git checkout を素早く入力する
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;gch[[ 
;git checkout -b 
::gch[[::
{
    A_Clipboard := "git checkout -b "
    Send "+{INSERT}"
    Sleep 100
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;git commit を素早く入力する
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;gco[[ 
;git commit -m ""
::gco[[::
{
    A_Clipboard := 'git commit -m ""'
    Send "+{INSERT}"
    Sleep 100
    Send "{Left}"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;文字支援
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;ユーロ、ポンド入力
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;ユーロ、ポンドの記号は、ファイルをSJIS で保存すると文字化けするので、UTF-8 BOM付きで保存する必要がある。
::e[[::
{
    A_Clipboard := '€'
    Send "+{INSERT}"
}

::p[[::
{
    A_Clipboard := '￡'
    Send "+{INSERT}"
}

;三点リーダー2連
::fd[[::
{
    A_Clipboard := '……'
    Send "+{INSERT}"
}
;ダッシュ2連
::fh[[::
{
    A_Clipboard := '――'
    Send "+{INSERT}"
}
;青空文庫ルビ
::fr[[::
{
    A_Clipboard := '《》'
    Send "+{INSERT}"
    Sleep 100
    Send "{Left}"
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;今日の日付を入力する
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;w[[ → 年月日＋曜日を入力する Hotstring  本体
::w[[::
{
    TimeString := FormatTime(,"LongDate")
    downum := FormatTime(,"WDay")
    dowstr := get_dowstr(downum)
    A_Clipboard := TimeString . dowstr
    Send "+{INSERT}"
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;今日の日付を半角8桁で入力する
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;q[[ 今日を8桁で入力する
::q[[::
{
    TimeString := FormatTime(,"yyyyMMdd")
    Send TimeString
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;今年の指定日の日付を入力する
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;t[[ → 今年の指定日の年月日＋曜日を入力する Hotstring  本体

::t[[::
{
    {
        MyGui := Gui(,"今年日付入力")
        MyGui.Add("Text",, "指定日[4ケタ]")
        MyGui.Add("Edit", "vTargetDay Limit4 Number") 
        MyGui.Add("Button", "default", "OK").OnEvent("Click", InsDateExec) ; ダイアログの「OK」ボタンの表示。オプションに"default"とつけることで、テキストを入力後に「Enter」キーを押したときの動作として設定する 
        MyGui.Add("Button", " x+20" , "Cancel").OnEvent("Click", CloseWindow) ; キャンセルボタン、ダイアログを閉じる
        MyGui.OnEvent("Escape", CloseWindow) ; [ESC] キーでダイアログを閉じる
        MyGui.show() ; Gui を表示する
    }
    
    ; MyGui を閉じる関数
    CloseWindow(*)
    {
        MyGui.Destroy()
    }
    ; ダイアログに入力された四桁の数字を年月日＋曜日に変換し、入力する関数
    InsDateExec(*)
    {
        Saved := MyGui.Submit()
        TargetDay := Saved.TargetDay
        ;今年の年を取得
        YearString := SubStr((FormatTime(,"ShortDate")), 1, 4)
        ;取得した月日のテキストから曜日を取得
        dayString := FormatTime(YearString . TargetDay . "000000"  ,"WDay")
        ;取得したテキストから年月日を取得
        targetString := FormatTime(YearString . TargetDay . "000000" ,"LongDate")
        ;曜日を(月)の形式に変換
        dowstr := get_dowstr(dayString)
        if (StrLen(targetString) < 1) {
            return
        }
        A_Clipboard := targetString . dowstr
        Send "+{INSERT}"
    }
}

;曜日をカッコつきで返す
get_dowstr(theNum)
{
    dowtable := "日月火水木金土"
    ; Wday は日曜日が 1、
    dowstr := SubStr(dowtable, theNum, 1)
    return "(" . dowstr . ")"
}
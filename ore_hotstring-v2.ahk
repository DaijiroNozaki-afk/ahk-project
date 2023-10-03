#Requires AutoHotkey v2.0
#Warn
#SingleInstance
#Hotstring *
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;git push を素早く入力する
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;gp[[ 
;git push -u origin HEAD
; ::gpgp::MsgBox("This is a test")
::gp[[::
{
A_Clipboard := "git push -u origin HEAD"
Send "+{INSERT}"
return
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;git checkout を素早く入力する
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;gch[[ 
;git checkout -b 
::gch[[::
{
A_Clipboard := "git checkout -b"
Send "+{INSERT}"
return
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
    return
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;ユーロ、ポンド入力
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;ユーロ、ポンドの記号は、ファイルをSJIS で保存すると文字化けするので、UTF-8 BOM付きで保存する必要がある。
::e[[::
{
    A_Clipboard := '€'
    Send "+{INSERT}"
    return
}

::p[[::
{
    A_Clipboard := '￡'
    Send "+{INSERT}"
    return
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;今日の日付を入力する
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;w[[ → 年月日＋曜日を入力する Hotstring  本体
::w[[::
{
    ; FormatTime, TimeString,, LongDate
    TimeString := FormatTime(,"LongDate")
    ; FormatTime, downum,, WDay
    downum := FormatTime(,"WDay")
    dowstr := get_dowstr(downum)
    A_Clipboard := TimeString . dowstr
    Send "+{INSERT}"
    return

}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;今日の日付を半角8桁で入力する
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;q[[ 今日を8桁で入力する
::q[[::
{
    ; FormatTime, TimeString,, yyyyMMdd
    TimeString := FormatTime(,"yyyyMMdd")
    ; clipboard = %TimeString%
    A_Clipboard := TimeString
    Send "+{INSERT}"
    return
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;今年の指定日の日付を入力する
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;t[[ → 年月日＋曜日を入力する Hotstring  本体
::t[[::
{
    ; 入力フォーム作成
    MyGui := Gui(,"今年日付入力")
    MyGui.Add("Text",, "指定日[4ケタ]")
    MyGui.Add("Edit", "vTargetDay ym Limit4 Number")  ; ymオプションは、コントロールの新しい列を開始します。
    MyGui.Add("Button", "default ", "OK").OnEvent("Click", InsDateExec)
    MyGui.Add("Button", " x+20" , "Cancel").OnEvent("Click", CloseWindow)
    MyGui.OnEvent("Escape", CloseWindow)
    MyGui.show()
    ; MyGui_Escape(ThisGui) 
    ; {
    ;     ; [ESC] キーでダイアログを閉じる
    ;     MyGui.Destroy()
    ;     Return
    ; }
    CloseWindow(*)
    {
        MyGui.Destroy()
        Return
    }
    InsDateExec(*)
    {
        Saved := MyGui.Submit()
        TargetDay := Saved.TargetDay
        ; ;今年の年を取得
        YearString := FormatTime(,"ShortDate")
        YearString := SubStr(YearString, 1, 4)
        ; ;取得した月日のテキストから曜日を取得
        dayString := FormatTime(YearString . TargetDay . "000000"  ,"WDay")
        ; ;取得したテキストから年月日を取得
        targetString := FormatTime(YearString . TargetDay . "000000" ,"LongDate")
        ; ;曜日を(月)の形式に変換
        dowstr := get_dowstr(dayString)
        A_Clipboard := targetString . dowstr
        Send "+{INSERT}"
    Return
    }
  return
}

;曜日をカッコつきで返す
get_dowstr(theNum)
{
    dowtable := "日月火水木金土"
    ; Wday は日曜日が 1、
    dowstr := ""
    dowstr := SubStr(dowtable, theNum, 1)
    return "(" dowstr ")"
}
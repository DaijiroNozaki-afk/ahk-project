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
    Gui_Escape(thisGui) 
    {
        MyGui.Destroy()
        Return
    }
    MyGui.show()
    ; Gui,Add,Text, yp+10,指定日[4ケタ]
    ; Gui,Add,Edit,x100 yp-4 vTargetDate w50 Limit4 Number ; 入力フォーム、4ケタ、数字のみの制限
    ; Gui,Add,Button,gInsDateExec x170 yp-2 default,&OK ; オプションで default を指定すると、Enter が押されたときにそのボタンのラベルが処理されます
    ; Gui,Show
    CloseWindow(*)
    {
        MyGui.Destroy()
        Return
    }
    InsDateExec(*)
    {
        Saved := MyGui.Submit()
        ; MsgBox("You entered '" Saved.TargetDay)
        TargetDay := Saved.TargetDay
        ; Gui,Submit
        ; Gui,Destroy
        ; ;今年の年を取得
        ; FormatTime, YearString,, ShortDate
        YearString := FormatTime(,"ShortDate")
        ; StringMid,YearString,YearString,1,4 ; 年を取得
        YearString := SubStr(YearString, 1, 4)
        ; ;取得した月日のテキストから曜日を取得
        ; FormatTime, dayString,%YearString%%TargetDate%000000,WDay
        dayString := FormatTime(YearString . TargetDay . "000000"  ,"WDay")
        ; ;取得したテキストから年月日を取得
        ; FormatTime, targetString,%YearString%%TargetDate%000000,LongDate
        targetString := FormatTime(YearString . TargetDay . "000000" ,"LongDate")
        ; ;曜日を(月)の形式に変換
        ; dowstr := get_dowstr(dayString)
        dowstr := get_dowstr(dayString)
        ; A_Clipboard := targetString
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
    ; StringMid, dowstr, dowtable, %theNum%, 1
    dowstr := SubStr(dowtable, theNum, 1)
    return "(" dowstr ")"
}
;独自ショートカット
SetTitleMatchMode, 2


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Hotstring のオプション. 自分好み.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; - 終了文字無しで発動させる
; 0 自動置換後、最後に終了文字を入力しない
#Hotstring *
#Hotstring O


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;今日の日付を入力する
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;w[[ → 年月日＋曜日を入力する Hotstring  本体
::w[[::
  FormatTime, TimeString,, LongDate
  FormatTime, downum,, WDay
  dowstr := get_dowstr(downum)
  clipboard = %TimeString% %dowstr%
  Send, +{INSERT}
return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;今日の日付を半角8桁で入力する
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;q[[ 今日を8桁で入力する
::q[[::
FormatTime, TimeString,, yyyyMMdd
clipboard = %TimeString%
Send, +{INSERT}
return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;git push を素早く入力する
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;gp[[ 
;git push -u origin HEAD
::gp[[::
clipboard = git push -u origin HEAD
Send, +{INSERT}
return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;git checkout を素早く入力する
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;gch[[ 
;git checkout -b 
::gch[[::
clipboard = git checkout -b
Send, +{INSERT}
Send, +{Space}
return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;git commit を素早く入力する
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;gco[[ 
;git commit -m ""
::gco[[::
clipboard = git commit -m ""
Send, +{INSERT}
return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;今年の指定日の日付を入力する
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;t[[ → 年月日＋曜日を入力する Hotstring  本体
::t[[::
  ; 入力フォーム作成
  Gui,Add,Text, yp+10,指定日[4ケタ]
  Gui,Add,Edit,x100 yp-4 vTargetDate w50 Limit4 Number ; 入力フォーム、4ケタ、数字のみの制限
  Gui,Add,Button,gInsDateExec x170 yp-2 default,&OK ; オプションで default を指定すると、Enter が押されたときにそのボタンのラベルが処理されます
  Gui,Show
return

InsDateExec:
  Gui,Submit
  Gui,Destroy
  ;今年の年を取得
  FormatTime, YearString,, ShortDate
  StringMid,YearString,YearString,1,4 ; 年を取得
  ;取得した月日のテキストから曜日を取得
  FormatTime, dayString,%YearString%%TargetDate%000000,WDay
  ;取得したテキストから年月日を取得
  FormatTime, targetString,%YearString%%TargetDate%000000,LongDate
  ;曜日を(月)の形式に変換
  dowstr := get_dowstr(dayString)
  clipboard = %targetString% %dowstr%
  Send, +{INSERT}
Return

;入力フォームキャンセルで、Gui を破棄
;キャンセル、エスケープキー、閉じるに対応
ButtonCancel:
GuiEscape:
GuiClose:
  Gui,Destroy
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;ユーロ、ポンド入力
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;ユーロ、ポンドの記号は、ファイルをSJIS で保存すると文字化けするので、UTF-8 BOM付きで保存する必要がある。
::e[[::
	clipboard = €
	Send, +{INSERT}
return
::p[[::
	clipboard = ￡
	Send, +{INSERT}
return

;曜日をカッコつきで返す
get_dowstr(theNum)
{
    dowtable := "日月火水木金土"
    ; Wday は日曜日が 1、
    ; StringMid のStartChar は、取り出す部分の開始位置。StringGetPosと違い、1文字目が 1。
    dowstr := ""
    StringMid, dowstr, dowtable, %theNum%, 1
    return "(" dowstr ")"
}

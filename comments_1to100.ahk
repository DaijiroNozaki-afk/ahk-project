#Requires AutoHotkey v2.0
x := 1
; x := 15

; xが100になるまでループ
Loop 100
    {
        ; xの値をコンソールに出力
        Send100Comments(x)
        ; xの値を1増やす
        x := x + 1
    }

Send100Comments(x){
      
    sleepTime := RandomInt4To9()
    Sleep sleepTime
    ;クリップボードに数字をコピー
    A_Clipboard := x
    ;数字を入力
    ;Enter
    Send "+{INSERT}"
    Sleep 100
    Send "+{ENTER}"

}

;4~9秒の間で待機
; ランダムな整数生成関数 (4から9)
RandomInt4To9() {
    ; RandomRange 関数を使用して、0から9までのランダムな整数を生成
    randomNum := Random(0, 5)
  
    ; 3を足して、3から12までの範囲に変換
    randomNum := (randomNum + 4) * 1000
  
    ; 関数終了
    return randomNum
  }

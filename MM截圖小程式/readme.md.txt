# Feature
* 以 PrintScrn 鍵呼叫 Windows 剪貼工具。
* 在剪貼工具按 ctrl+v 可呼叫 mm client 並貼上圖片。

# How to use
* 建議將此程式複製回本機電腦執行。
* 設定為開機時啟動
    * 第一次啟動程式時請點擊右鍵選擇 "以系統管理員身分執行"，將自動建立捷徑。
        * 若自動建立捷徑失敗將打開 windows 啟動路徑，須自行按 ctrl+v 貼上。    
* 按printscreen - 啟動剪貼工具，若已啟動則重新擷取。可使用畫筆於圖片上註記編輯。
* 在剪貼工具視窗按 ctrl+v - 若有安裝mm程式，則切換視窗並貼上最終編輯圖片。若無安裝mm程式則自行切換視窗貼上。

* 若有安裝其他截圖軟體 (ex. snagit) 則預設熱鍵會與其衝突，請更改 [截圖軟體熱鍵] 或更改 [此程式熱鍵] 如下：
    * 將此程式重新命名，在最前方加上為 ctrl/ alt/ shift 任一，與一個空格 ex. 
        ctrl ahk PrtScr2Snipping.exe
        alt ahk PrtScr2Snipping.exe
        shift ahk PrtScr2Snipping.exe
    並如第二點以管理員身分重新執行一次即可。
;Opens Excel sheet for editting Spreadsheet of hotkeys in Firefox
    OpenSpreadSheet()
        {
            path := "C:\Program Files\Firefox Nightly\firefox.exe"
            profile := "-Main-" 
            profileName := "default"            
            IfWinExist, AHK-DailyDriver hotkey mapping
            {
                sheetId := WinExist("AHK-DailyDriver hotkey mapping")
                WinActivate, ahk_id %sheetId%
            }
            IfWinNotExist, AHK-DailyDriver hotkey mapping
            {
                RunWait, %path% -p %profileName% -new-tab https://docs.google.com/spreadsheets/d/1eRfcNj-UR4kXf5fBXDS4rn95YMSlbbT8McJL3HkK-_A/edit ,,Hide 
            }             
        }
;Shows in a msgbox, the current information of the active window
    GetActiveWindowData()
        {
            this_id := WinExist("A")
            WinGetTitle, this_title, ahk_id %this_id%
            WinGetClass, this_class, ahk_id %this_id%
            WinGet, this_PID, PID, ahk_id %this_id%
            MsgBox,Active window info:`n`n Title = %this_title%`n Class = %this_class%`n PID = %this_PID%
            Return
        }
;Display all active windows
    GetAllWindows()
        {
            WinGet,Windows,List
            Gui, New,+Resize +HwndMyGuiHwnd,AllActiveWindows
            Gui, Font, s8
            loopCount := 0
            c1 := 10
            c1yAdd := 30
            c2 := 500
            c2yAdd := 30
            Loop,%Windows%
            {
                loopCount++
                i := loopCount - 1
                this_id := Windows%A_Index%
                WinGetTitle, this_title, ahk_id %this_id%
                WinGetClass, this_class, ahk_id %this_id%
                WinGet, this_PID, PID, ahk_id %this_id%
                GuiControlGet, winT, Pos, WindowText%i%
                ;MsgBox, %winTY%
                If (this_title)
                {
                    Gui, Add, Text,x%c1% y%c1yAdd%,%this_title%:`n`t Class: %this_class%`n`t ID: %this_id%`n`t PID: %this_PID% HwndWindowText%loopCount%
                    c1yAdd := c1yAdd + 60
                }
                If !(this_title)
                {
                    Gui, Add, Text,x%c2% y%c2yAdd%, %this_id%:`n`t Class: %this_class%`n`t PID: %this_PID% HwndWindowText%loopCount%
                    c2yAdd := c2yAdd + 60
                }
            }
            Gui, Show, AutoSize
            Return
        }
;Reload Script
    ReloadScript()
    {
        currAct := WinActive("A")
        MsgBox, Reloading Script dailyDriver.ahk
        Reload
        WinActivate, ahk_id %currAct%
        Return
    }
;HelperGUI
    HelperGUI()
    {
        global
        loopCount := 1
        Gui, New, +HwndHelperGuiHwnd, HelperGui
        Gui, Show, w1000 h800,Koolertron Keybinds
        GuiControlGet, guiInfo,Pos, text1
        gui, Show
        GuiControl, Move, text1, % "x" guiWidth/2 - guiInfoW/2
        Gui, +Theme +Resize
        Gui, Color, 484848
        Gui, Font, s15
        Gui, add, Picture,w-1 h400, Info/MacropadTemplate.jpg
        FileReadLine, FullTopColumn, Info/HotkeySheet.txt, 1
        ;MsgBox, %FullTopColumn%
        StringSplit, TopHoldArr, FullTopColumn, \
        ;MsgBox, %TopHoldArr1%
        Gui, Font, s10

        Gui, Add, ListView, r15 vHotkeys w900, %TopHoldArr1%|%TopHoldArr2%|%TopHoldArr3%|%TopHoldArr4%|%TopHoldArr5%|%TopHoldArr6%|%TopHoldArr7%|%TopHoldArr8%|%TopHoldArr9%|%TopHoldArr10%|%TopHoldArr11%
        GuiControl, +Title, HotKeys

        Loop, Read, Info/HotkeySheet.txt
        {
            StringSplit, HoldArr, A_LoopReadLine, |
            ;MsgBox, %HoldArr1% %HoldArr2% %HoldArr3% %HoldArr4% %HoldArr5% %HoldArr6% %HoldArr7% %HoldArr8% %HoldArr9% %HoldArr10% %HoldArr11%
            If (loopCount != 1)
            {
                LV_Add(,HoldArr1,HoldArr2,HoldArr3,HoldArr4,HoldArr5,HoldArr6,HoldArr7,HoldArr8,HoldArr9,HoldArr10,HoldArr11)
            }
            ;MsgBox, %loopCount%
            loopCount++
        }
        LV_ModifyCol()
        loopCount := 1
        return
    }  
;Kill active process    
    KillProcess()
    {
        current := WinExist("A")
        WinGetClass, this_class, ahk_id %current%
        WinGetTitle, this_title, ahk_id %current%
        If (this_class = "MozillaWindowClass")
        {
            Send, {CtrlDown}{F4}{CtrlUp}
            Return
        }
        If (this_title ~= "Vivaldi")
        {
            Send, {CtrlDown}{F4}{CtrlUp}
            Return
        }
        Else
        {
            WinClose, A
            Return
        }
    }
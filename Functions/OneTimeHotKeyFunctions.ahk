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
        MsgBox,,, Reloading Script dailyDriver.ahk,1
        Reload
        WinActivate, ahk_id %currAct%
        Return
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
        If (this_class = "Chrome_WidgetWin_1")
        {
            If (this_title ~= "Vivaldi")
            {
                Send, {CtrlDown}{AltDown}{ShiftDown}5{ShiftUp}{AltUp}{CtrlUp}
                Return
            }
        }
        WinClose, A
        Return
    }
;Join Argument function
    JoinArgs(p*) 
    {
        o:=""
        s:=" "
        for k,v in p {
            if InStr(v,"""") {
                RegExReplace(v, """" , """""")
            }
            if InStr(v," ") {
                v := """" . v . """"
            }
            o.=s v
        }
        return SubStr(o,StrLen(s)+1)
    }
;Run current script as admin
    RunAsAdmin() {
        If Not A_IsAdmin {
            ArgsToPass := JoinArgs(A_Args*)
            Run, *RunAs "%A_ScriptFullPath% " %ArgsToPass%
            if ErrorLevel
                ExitApp
            ExitApp
        }
        return
    }
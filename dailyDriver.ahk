SetTitleMatchMode, 2
#Include, Functions.ahk

;Script reload
    +!r:: 
        MsgBox, Reloading Script dailyDriver.ahk
        Reload
        return

; Application Run/Kill handling

;FireFox
    F23::
        Run, "C:\Program Files\Mozilla Firefox\firefox.exe" -p HifiVox
        return
    F24::
        Run, "C:\Program Files\Mozilla Firefox\firefox.exe" -p default-release
        return
;Steam main account
    +F24::
        IfWinExist, Steam 
        {
            Process, close, steam.exe
            ;location of .bat must be changed
            Run, "C:\Users\Colto\Documents\SteamMain.bat" ,,Hide
        }
        IfWinNotExist, Steam
        {
            ;location of .bat must be changed
            Run, "C:\Users\Colto\Documents\SteamMain.bat" ,,Hide
        }
        return
;Steam Alt
    +F23::
        IfWinExist, Steam 
        {
            Process, close, steam.exe
            ;location of .bat must be changed
            Run, "C:\Users\Colto\Documents\SteamPBX.bat" ,,Hide
        }
        IfWinNotExist, Steam 
        {
            ;location of .bat must be changed
            Run, "C:\Users\Colto\Documents\SteamPBX.bat" ,,Hide
        }
        return

;Volume controls

;focused application volume
    F13::
        Run cmd.exe /c start nircmd.exe changeappvolume focused -0.1 ,,Hide
        return
    F14::
        Run cmd.exe /c start nircmd.exe changeappvolume focused +0.1 ,,Hide
        return

;Browser volume control

;Browser Volume up 
    F16::
        ;Check for active Firefox
        IfWinExist, ahk_class MozillaWindowClass
        {
            multiWindowArr := []
            multiWinCounter := 0
            WinGet,Windows,List
            Loop,%Windows%
            {
                this_id := "ahk_id " . Windows%A_Index%
                WinGetTitle, this_title, %this_id%
                WinGetClass, this_class, %this_id%
                WinGet, this_PID, PID, %this_id%
                If (this_class = "MozillaWindowClass") 
                {
                    multiWinCounter += 1
                    multiWindowArr.Push(this_PID)
                }
            }
            uniqMultiArr := uniq(multiWindowArr)
            For e, v in uniqMultiArr 
            {
                Run cmd.exe /c start nircmd.exe changeappvolume /%v% +0.1 ,,Hide
            }    
        }
        ;Check for active Google Chrome
        IfWinExist, Google Chrome
        {
            Run cmd.exe /c start nircmd.exe changeappvolume chrome.exe +0.1 ,,Hide
        }
        return
;Browser Volume down
    F15::
        ;Check for active Firefox
        IfWinExist, ahk_class MozillaWindowClass
        {
            multiWindowArr := []
            multiWinCounter := 0
            WinGet,Windows,List
            Loop,%Windows%
            {
                this_id := "ahk_id " . Windows%A_Index%
                WinGetTitle, this_title, %this_id%
                WinGetClass, this_class, %this_id%
                WinGet, this_PID, PID, %this_id%
                If (this_class = "MozillaWindowClass") 
                {
                    multiWinCounter += 1
                    multiWindowArr.Push(this_PID)
                }
            }
            uniqMultiArr := uniq(multiWindowArr)
            For e, v in uniqMultiArr 
            {
                Run cmd.exe /c start nircmd.exe changeappvolume /%v% -0.1 ,,Hide
            }    
        }
        ;Check for active Google Chrome
        IfWinExist, Google Chrome
        {
            Run cmd.exe /c start nircmd.exe changeappvolume chrome.exe -0.1 ,,Hide
        }
        return

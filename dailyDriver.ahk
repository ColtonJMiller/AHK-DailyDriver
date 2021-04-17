SetTitleMatchMode, 2
#Include, Functions.ahk
;temp test hotkey


;All active Windows
    +^!K::
        WinGet,Windows,List
        Loop,%Windows%
        {
            this_id := "ahk_id " . Windows%A_Index%
            WinGetTitle, this_title, %this_id%
            WinGetClass, this_class, %this_id%
            WinGet, this_PID, PID, %this_id%
            MsgBox, %this_title% %this_PID%
        }
        Return

;Script reload
    +!R:: 
        MsgBox, Reloading Script dailyDriver.ahk
        Reload
        return

; Application Sizing and movement





; Application Run/Kill handling

;FireFox
;Firefox Alt Account Main Monitor
    F23:: 
        RunWait, cmd.exe /c start firefox.exe -p HifiVox -new-tab about:home  ,,Hide 
        return
;Firefox Default Account Main Monitor  
    F24::
        RunWait, cmd.exe /c start firefox.exe -p default-release -new-tab about:home  ,,Hide 
        return
;Steam main account
    +F13::
        IfWinExist, Steam 
        {
            MsgBox, Starting Main Steam
            Process, close, steam.exe
            ;location of .bat must be changed
            Run, "C:\Users\Colto\Documents\SteamMain.bat" ,,Hide
        }
        IfWinNotExist, Steam
        {
            MsgBox, Starting Main Steam
            ;location of .bat must be changed
            Run, "C:\Users\Colto\Documents\SteamMain.bat" ,,Hide
        }
        return
;Steam Alt
    +F14::
        IfWinExist, Steam 
        {
            MsgBox, Starting Alt Steam
            Process, close, steam.exe
            ;location of .bat must be changed
            Run, "C:\Users\Colto\Documents\SteamPBX.bat" ,,Hide
        }
        IfWinNotExist, Steam 
        {
            MsgBox, Starting Alt Steam
            ;location of .bat must be changed
            Run, "C:\Users\Colto\Documents\SteamPBX.bat" ,,Hide
        }
        return

;Volume controls

;focused application volume
    F13::
        Run cmd.exe /c start nircmd.exe changeappvolume focused -0.05 ,,Hide
        return
    F14::
        Run cmd.exe /c start nircmd.exe changeappvolume focused +0.05 ,,Hide
        return

;Media volume control (includes browser tabs with audio)

;Media Volume up 
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
                Run cmd.exe /c start nircmd.exe changeappvolume /%v% +0.05 ,,Hide
            }    
        }
;Check for active Google Chrome
        IfWinExist, Google Chrome
        {
            Run cmd.exe /c start nircmd.exe changeappvolume chrome.exe +0.05 ,,Hide
        }
;music app volume up    
        IfWinExist, TIDAL
        {
            Run cmd.exe /c start nircmd.exe changeappvolume TIDAL.exe +0.05 ,,Hide            
        }
        IfWinExist, Spotify
        {
            Run cmd.exe /c start nircmd.exe changeappvolume Spotify.exe +0.05 ,,Hide            
        }
        Return
;Media Volume down
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
                Run cmd.exe /c start nircmd.exe changeappvolume /%v% -0.05 ,,Hide
            }    
        }
;Check for active Google Chrome
        IfWinExist, Google Chrome
        {
            Run cmd.exe /c start nircmd.exe changeappvolume chrome.exe -0.05 ,,Hide
        }
        IfWinExist, TIDAL
        {
            Run cmd.exe /c start nircmd.exe changeappvolume TIDAL.exe -0.05 ,,Hide            
        }
        IfWinExist, Spotify
        {
            Run cmd.exe /c start nircmd.exe changeappvolume Spotify.exe -0.05 ,,Hide            
        }
        Return

;Music apps volume control

;Moved to universal media controls may implement independant controls with more physical buttons available

;music app volume down    
;Line in volume control
;Line in volume up
    F17::
        Run cmd.exe /c start nircmd.exe changeappvolume "Adobe Audition CC.exe" -0.05 ,,Hide             
        IfWinExist, Audacity
        {
            Run cmd.exe /c start nircmd.exe changeappvolume Audacity.exe -0.05 ,,Hide            
        }
        IfWinExist, VoiceMeeter 
        {
            Run cmd.exe /c start nircmd.exe changeappvolume Voicemeeter.exe -0.05 ,,Hide 

        }
        return  
    F18::  
        Run cmd.exe /c start nircmd.exe changeappvolume "Adobe Audition CC.exe" +0.05 ,,Hide             
        IfWinExist, Audacity
        {
            Run cmd.exe /c start nircmd.exe changeappvolume Audacity.exe +0.05 ,,Hide            
        }
        IfWinExist, VoiceMeeter 
        {
            Run cmd.exe /c start nircmd.exe changeappvolume Voicemeeter.exe +0.05 ,,Hide            
        } 
        return     

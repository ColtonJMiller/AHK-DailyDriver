;Koolertron 23 key
;R3 Macros
;M1 = >^F19 
;M2 = >^F20 
;M3 = >^F21 
;M4 = >^F22 
;M5 = >^F23 
;M6 = >^F24 
;R4 Binds
;C1 = <+ LT SHIFT
;C2 = <^ LT CTRL
;C3 = <! LT ALT
;C4 = >! RT ALT
;C5/6 = >+ RT SHIFT

SetTitleMatchMode, 2
#Include, Functions.ahk

;temp test hotkey

; Open hotkey sheet
    <+<^<!H::
        IfWinExist, AHK-DailyDriver hotkey mapping
        {
            sheetId := WinExist("AHK-DailyDriver hotkey mapping")
            WinActivate, ahk_id %sheetId%
        }
        IfWinNotExist, AHK-DailyDriver hotkey mapping
        {
            RunWait, cmd.exe /c start firefox.exe -p default-release -new-tab https://docs.google.com/spreadsheets/d/1eRfcNj-UR4kXf5fBXDS4rn95YMSlbbT8McJL3HkK-_A/edit ,,Hide 
        }    
        Return
;All active Windows
    <+<^!K::
        WinGet,Windows,List
        MsgBox, %Windows%
        Loop,%Windows%
        {
            this_id := "ahk_id " . Windows%A_Index%
            WinGetTitle, this_title, %this_id%
            WinGetClass, this_class, %this_id%
            WinGet, this_PID, PID, %this_id%
            MsgBox, Title = %this_title%`n Class = %this_class%`n PID = %this_PID%
        }
        Return

;Script reload
    <+<!R:: 
        MsgBox, Reloading Script dailyDriver.ahk
        Reload
        return
;Application location
    ;Maximize or restore toggle for active window 
        F22::
            WinGet, winState, MinMax, A
            if (winState = 0 || winState = -1 )
            {
                WinMaximize, A
                return
            }
            If (winState = 1)
            {
                WinRestore, A
                Return
            }
    ;Minimize active window   
        F21::
            WinGet, winState, MinMax, A
            If (winState = 1 || winState = 0)
            {
                WinMinimize, A
                Return
            }
            If (winState = -1)
            {
                Return
            }
    ;Move active window to other monitor
        F24::
            Send, {LWinDown}{ShiftDown}{Left}{ShiftUp}{LWinUp}
            Return
;Application process kill  
    ;Kill current active process
        <+F14::
            current := WinExist("A")
            WinGetClass, this_class, ahk_id %current%
            WinGetTitle, this_title, ahk_id %current%
            If (this_class = "MozillaWindowClass")
            {
                Send, {CtrlDown}{F4}{CtrlUp}
                Return
            }
            If (this_title ~= "Visual Studio Code")
            {
                Send, {CtrlDown}{F4}{CtrlUp}
                Return
            }
            If (this_class = "Chrome_WidgetWin_1")
            {
                Send, {CtrlDown}{F4}{CtrlUp}
                Return
            }
            WinGet, currentPID, PID, %current%
            WinClose ahk_id %current%
            Return
;FireFox new tab per profile
    
    ;Firefox Default Account open new tab
        >+>^F19::
            profile := "-Main-" 
            profileName := "default-release"
            WinGet, this_ID, ID, %profile%
            Runwait, cmd.exe /c start firefox.exe -p %profileName% -new-tab about:home ,,Hide
            WinWaitClose, 
            WinActivate, ahk_id %this_ID%
            Return        
    ;Firefox Alt Account open new tab
        >+>^F20::
            profile := "-Hifi-" 
            profileName := "HifiVox"
            WinGet, this_ID, ID, %profile%
            Runwait, cmd.exe /c start firefox.exe -p %profileName% -new-tab about:home ,,Hide
            WinWaitClose, 
            WinActivate, ahk_id %this_ID%
            Return   
;Chrome new tab per profile    
    ;Chrome Main Account open new tab
        <^>^F19::
            profile := "|Main|" 
            profileName := "default"
            WinGet, this_ID, ID, %profile%
            Runwait, cmd.exe /c start chrome.exe --args --profile-directory=%profileName% www.google.com  ,,Hide
            WinWaitClose, 
            WinActivate, ahk_id %this_ID%
            Return 
    ;Chrome Work Account open new tab
        <^>^F20::
            profile := "|Work|" 
            profileName := """profile 1"""
            WinGet, this_ID, ID, %profile%
            Runwait, cmd.exe /c start chrome.exe --args --profile-directory=%profileName% www.google.com  ,,Hide
            WinWaitClose, 
            WinActivate, ahk_id %this_ID%
            Return 
;Application open and make active
    ;Firefox Default Account make active/cycle tabs
        >^F19::
            profile := "-Main-" 
            profileName := "default-release"
            IfWinExist, %profile%
            {
                WinGet, actCheck, ID, %profile%
                currActive := WinExist("A")              
                If (currActive = actCheck)
                {
                    Send, {Ctrl Down}{PgDn}{Ctrl Up} 
                    return                  
                }
                Else 
                {
                    WinActivate, ahk_id %actCheck%
                    Return
                }
            }
            IfWinNotExist, %profile%
            {
                Run, cmd.exe /c start firefox.exe -p %profileName% -new-tab about:home ,,Hide
                WinWait, %profileName%
                Return
            } 
            Return
    ;Firefox Alt Account make active/cycle tabs
        >^F20::
            profile := "-Hifi-" 
            profileName := "HifiVox"
            IfWinExist, %profile%
            {
                WinGet, actCheck, ID, %profile%
                currActive := WinExist("A")              
                If (currActive = actCheck)
                {
                    Send, {Ctrl Down}{PgDn}{Ctrl Up} 
                    return                  
                }
                Else 
                {
                    WinActivate, ahk_id %actCheck%
                    Return
                }
            }
            IfWinNotExist, %profile%
            {
                Run, cmd.exe /c start firefox.exe -p %profileName% -new-tab about:home ,,Hide
                WinWait, %profileName%
                Return
            } 
            Return
    ;Chrome Main Account make active/cycle tabs
        <+>^F19::
            profile := "|Main|"
            profileName := "Default"
            IfWinExist,  %profile%
            {
                WinGet, actCheck, ID, %profile%
                currActive := WinExist("A")              
                If (currActive = actCheck)
                {
                    Send, {Ctrl Down}{Tab}{Ctrl Up} 
                    return                  
                }
                Else 
                {
                    WinActivate, ahk_id %actCheck%
                    Return
                }
                WinActivate, ahk_id %mainAct%
                return           
            }
            IfWinNotExist, %profile% 
            {
                Run, cmd.exe /c start chrome.exe --args --profile-directory=%profileName%  ,,Hide
                WinWait, %profile%
                Return                
            }           
    ;Chrome Work Account make active/cycle tabs
        <+>^F20::
            profile := "|Work|"
            profileName := """profile 1"""
            IfWinExist,  %profile%
            {
                WinGet, actCheck, ID, %profile%
                currActive := WinExist("A")              
                If (currActive = actCheck)
                {
                    Send, {Ctrl Down}{Tab}{Ctrl Up} 
                    return                  
                }
                Else 
                {
                    WinActivate, ahk_id %actCheck%
                    Return
                }
                WinActivate, ahk_id %mainAct%
                return           
            }
            IfWinNotExist, %profile% 
            {
                Run, cmd.exe /c start chrome.exe --args --profile-directory=%profileName%  ,,Hide
                WinWait, %profile%
                Return                
            }  
    ;Visual Studio
        >^F21::
            IfWinExist, ahk_exe Code.exe
            {
                WinGet, ffActive, ID, ahk_exe code.exe
                WinActivate, ahk_id %ffActive%
                Return
            }
            IfWinNotExist, ahk_exe Code.exe
            {
                RunWait, "C:\Users\Colto\AppData\Local\Programs\Microsoft VS Code\Code.exe" ,,Hide
                Return
            }   
    ;TIDAL
        >^F22::
            IfWinExist, ahk_exe TIDAL.exe
            {
                WinGet,tidalActive,ID, ahk_exe TIDAL.exe
                WinActivate, ahk_id %tidalActive%
                Return
            }
            IfWinNotExist, ahk_exe TIDAL.exe
            {
                Run, "C:\Users\Colto\AppData\Local\TIDAL\TIDAL.exe" ,,Hide
                Return
            } 
    ;Spotify
        >+>^F22::
            IfWinExist, ahk_exe C:\Users\Colto\AppData\Roaming\Spotify\Spotify.exe
            {
                WinGet,spotActive,ID, ahk_exe C:\Users\Colto\AppData\Roaming\Spotify\Spotify.exe
                WinActivate, ahk_id %spotActive%
                Return
            }
            IfWinNotExist, ahk_exe C:\Users\Colto\AppData\Roaming\Spotify\Spotify.exe
            {
                RunWait, "C:\Users\Colto\AppData\Roaming\Spotify\Spotify.exe" ,,Hide
                Return
            }  
    ;Photoshop    
        >^F23::
            IfWinExist, ahk_exe photoshop.exe
            {
                WinGet, PSActive, ID, ahk_exe C:\Program Files\Adobe\Adobe Photoshop 2020\photoshop.exe
                currActive := WinExist("A")              
                If (currActive = PSActive)
                {
                    Send, {Ctrl Down}{Tab}{Ctrl Up} 
                    return                  
                }
                Else 
                {
                    WinActivate, ahk_id %PSActive%
                    Return
                }
            }
            IfWinNotExist, ahk_exe photoshop.exe
            {
                Run, "C:\Program Files\Adobe\Adobe Photoshop 2020\photoshop.exe" ,,Hide
                Return
            }
    ;Steam main account
        >^F24::
            IfWinExist, ahk_exe steam.exe
            {
                WinGet, steamID, ID, Steam
                WinActivate, ahk_id %steamID%
                Return
            }
            IfWinNotExist, ahk_exe steam.exe
            {
                MsgBox,,, Starting Main Steam, 1
                Process, close, steam.exe
                ;location of .bat must be changed
                Run, "C:\Users\Colto\Documents\SteamMain.bat" ,,Hide
            }
            return
    ;Steam Alt
        >+>^F24::
            IfWinExist, ahk_exe steam.exe
            {
                WinGet, steamID, ID, Steam
                WinActivate, ahk_id %steamID%
                Return
            }
            IfWinNotExist, ahk_exe steam.exe 
            {
                MsgBox,,, Starting Alt Steam, 1
                Process, close, steam.exe
                ;location of .bat must be changed
                Run, "C:\Users\Colto\Documents\SteamPBX.bat" ,,Hide
                Return
            }
            Return
    ;Koolertron Editor
        >+F24::
            IfWinExist, AMAKeyboardClient
            {
                WinGet,koolActive,ID, AMAKeyboardClient
                WinActivate, ahk_id %koolActive%
                Return
            }
            IfWinNotExist, AMAKeyboardClient
            {
                Run, "C:\Users\Colto\Documents\amag\amag\AMAG_EN\AMAG.exe" ,,Hide
                Return
            } 
;Volume Controls

    ;main system volume 2%
        F19::
            SoundSet -2 
            Return
        F20::
            SoundSet +2
            Return       
    ;main system volume 5%
        >+F19::
            SoundSet -5
            Return
        >+F20::
            SoundSet +5
            Return
    ;focused application volume 2%
        F13::
            Run cmd.exe /c start nircmd.exe changeappvolume focused -0.02 ,,Hide
            return
        F14::
            Run cmd.exe /c start nircmd.exe changeappvolume focused +0.02 ,,Hide
            return
    ;focused application volume 10%
        >+F13::
            Run cmd.exe /c start nircmd.exe changeappvolume focused -0.1 ,,Hide
            return
        >+F14::
            Run cmd.exe /c start nircmd.exe changeappvolume focused +0.1 ,,Hide
            return
    ;Media volume control (firefox,chrome,tidal,and spotify) 2%
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
                    Run cmd.exe /c start nircmd.exe changeappvolume /%v% -0.02 ,,Hide
                }    
            }
            ;Check for active Google Chrome
            IfWinExist, Google Chrome
            {
                Run cmd.exe /c start nircmd.exe changeappvolume chrome.exe -0.02 ,,Hide
            }
            IfWinExist, ahk_exe TIDAL.exe
            {
                Run cmd.exe /c start nircmd.exe changeappvolume TIDAL.exe -0.02 ,,Hide               
                Run cmd.exe /c start nircmd.exe changeappvolume TIDALPlayer.exe -0.02 ,,Hide         
            }
            IfWinExist, ahk_exe Spotify.exe
            {
                Run cmd.exe /c start nircmd.exe changeappvolume Spotify.exe -0.02 ,,Hide            
            }
            Return
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
                    Run cmd.exe /c start nircmd.exe changeappvolume /%v% +0.02 ,,Hide
                }    
            }
            ;Check for active Google Chrome
            IfWinExist, Google Chrome
            {
                Run cmd.exe /c start nircmd.exe changeappvolume chrome.exe +0.02 ,,Hide
            } 
            IfWinExist, ahk_exe TIDAL.exe
            {
                Run cmd.exe /c start nircmd.exe changeappvolume TIDALPlayer.exe +0.02 ,,Hide            
            }
            IfWinExist, ahk_exe Spotify.exe
            {
                Run cmd.exe /c start nircmd.exe changeappvolume Spotify.exe +0.02 ,,Hide            
            }
            Return
    ;Media volume control (firefox,chrome,tidal,and spotify) 10%
        >+F15::
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
            IfWinExist, ahk_exe TIDAL.exe
            {
                Run cmd.exe /c start nircmd.exe changeappvolume TIDALPlayer.exe -0.1 ,,Hide            
            }
            IfWinExist, ahk_exe Spotify.exe
            {
                WinGet, spotPID, PID, ahk_exe Spotify.exe
                Run cmd.exe /c start nircmd.exe changeappvolume Spotify.exe -0.1 ,,Hide            
            }
            Return
        >+F16::
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
            IfWinExist, Google Chrome
            {
                Run cmd.exe /c start nircmd.exe changeappvolume chrome.exe +0.1 ,,Hide
            } 
            IfWinExist, ahk_exe TIDAL.exe
            {
                Run cmd.exe /c start nircmd.exe changeappvolume TIDALPlayer.exe +0.1 ,,Hide            
            }
            IfWinExist, ahk_exe Spotify.exe
            {
                WinGet, spotPID, PID, ahk_exe Spotify.exe
                Run cmd.exe /c start nircmd.exe changeappvolume Spotify.exe +0.1 ,,Hide            
            }
            Return
    ;Line in volume control 2%
        F17::
            Run cmd.exe /c start nircmd.exe changeappvolume "Adobe Audition CC.exe" -0.02 ,,Hide             
            IfWinExist, Audacity
            {
                Run cmd.exe /c start nircmd.exe changeappvolume Audacity.exe -0.02 ,,Hide            
            }
            IfWinExist, VoiceMeeter 
            {
                Run cmd.exe /c start nircmd.exe changeappvolume Voicemeeter.exe -0.02 ,,Hide 

            }
            return  
        F18::  
            Run cmd.exe /c start nircmd.exe changeappvolume "Adobe Audition CC.exe" +0.02 ,,Hide             
            IfWinExist, Audacity
            {
                Run cmd.exe /c start nircmd.exe changeappvolume Audacity.exe +0.02 ,,Hide            
            }
            IfWinExist, VoiceMeeter 
            {
                Run cmd.exe /c start nircmd.exe changeappvolume Voicemeeter.exe +0.02 ,,Hide            
            } 
            return     

    ;Line in volume control 10%
        >+F17::
            Run cmd.exe /c start nircmd.exe changeappvolume "Adobe Audition CC.exe" -0.1 ,,Hide             
            IfWinExist, Audacity
            {
                Run cmd.exe /c start nircmd.exe changeappvolume Audacity.exe -0.1 ,,Hide            
            }
            IfWinExist, VoiceMeeter 
            {
                Run cmd.exe /c start nircmd.exe changeappvolume Voicemeeter.exe -0.1 ,,Hide 

            }
            return  
        >+F18::  
            Run cmd.exe /c start nircmd.exe changeappvolume "Adobe Audition CC.exe" +0.1 ,,Hide             
            IfWinExist, Audacity
            {
                Run cmd.exe /c start nircmd.exe changeappvolume Audacity.exe +0.1 ,,Hide            
            }
            IfWinExist, VoiceMeeter 
            {
                Run cmd.exe /c start nircmd.exe changeappvolume Voicemeeter.exe +0.1 ,,Hide            
            } 
            return   

  

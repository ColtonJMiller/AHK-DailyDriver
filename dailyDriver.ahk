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


;HOTKEYS One time helper keys
    ; Open hotkey sheet
        SheetHK := "<+<^<!H"
        hotkey, %SheetHK%, sheetLab
    ;All active Windows
        allActiveHK := "<+<^!K"
        hotkey, %allActiveHK%, allActiveLab
    ;Script reload
        reloadHK := "<+<!R"
        hotkey, %reloadHK%, reloadLab
;HOTKEYS Application min, max, and monitor cycle 
    ;Maximize or restore toggle for active window 
        maxToggleHK := "F22"
        hotkey, %maxToggleHK%, maxToggleLab
    ;Minimize active window
        minWinHK := "F21"
        hotkey, %minWinHK%, MinWinLab
    ;Move active window to other monitor    
        monitorCycleHK := "F24"
        hotkey, %monitorCycleHK%, monitorCycleLab
;HOTKEYS Application process kill
    ;Kill current active process/close tab
        killProcessHK:= "<+F14"
        hotkey, %killProcessHK%, killProcessLab
;HOTKEYS Application open and make active. Cycle tabs
    ;Firefox Default Account make active/cycle tabs
        ffOpenMainHK := ">^F19"
        hotkey, %ffOpenMainHK%, ffOpenMainLab
    ;Firefox Alt Account make active/cycle tabs
        ffOpenAltHK := ">^F20"
        hotkey, %ffOpenAltHK%, ffOpenAltLab
    ;Chrome Main Account make active/cycle tabs
        chromeOpenMainHK := "<+>^F19"
        hotkey, %chromeOpenMainHK%, chromeOpenMainLab
    ;Chrome Work Account make active/cycle tabs
        chromeOpenWorkHK := "<+>^F20"
        hotkey, %chromeOpenWorkHK%, chromeOpenWorkLab
    ;Visual Studio make active/cycle tabs
        VSCodeOpenHK := ">^F21"
        hotkey, %VSCodeOpenHK%, VSCodeOpenLab
    ;TIDAL make active/open
        tidalOpenHK := ">^F22"
        hotkey, %tidalOpenHK%, tidalOpenLab
    ;Spotify make active/open
        spotifyOpenHK := ">+>^F22"
        hotkey, %spotifyOpenHK%, spotifyOpenLab
    ;Photoshop make active/open cycle tabs
        psOpenHK := ">^F23"
        hotkey, %psOpenHK%, psOpenLab
    ;Steam Main make active/open   
        steamOpenMainHK := ">^F24"
        hotkey, %steamOpenMainHK%, steamOpenMainLab
    ;Steam Alt make active/open 
        steamOpenAltHK := ">+>^F24"
        hotkey, %steamOpenAltHK%, steamOpenAltLab
    ;Koolertron Editor active/open
        koolertronOpenHK := ">+F24"
        hotkey, %koolertronOpenHK%, koolertronOpenLab
;HOTKEYS Applications new tabs
    ;Firefox Default Account open new tab
        ffNewTabMainHK := ">+>^F19"
        hotkey, %ffNewTabMainHK%, ffNewTabMainLab
    ;Firefox Alt Account open new tab
        ffNewTabAltHK := ">+>^F20"
        hotkey, %ffNewTabAltHK%, ffNewTabAltLab
    ;Chrome Main Account open new tab
        chromeNewTabMainHK := "<^>^F19"
        hotkey, %chromeNewTabMainHK%, chromeNewTabMainLab
    ;Chrome Work Account open new tab
        chromeNewTabWorkHK := "<^>^F20"
        hotkey, %chromeNewTabWorkHK%, chromeNewTabWorkLab
;HOTKEYS Volume controls
    ;main system volume down 2%
        mainSysVolDown2HK := "F19"
        hotkey, %mainSysVolDown2HK%, mainSysVolDown2Lab
    ;main system volume up 2%
        mainSysVolUp2HK := "F20"
        hotkey, %mainSysVolUp2HK%, mainSysVolUp2Lab
    ;main system volume down 5%
        mainSysVolDown5HK := ">+F19"
        hotkey, %mainSysVolDown5HK%, mainSysVolDown5Lab
    ;main system volume up 5%
        mainSysVolUp5HK := ">+F20"
        hotkey, %mainSysVolUp5HK%, mainSysVolUp5Lab
    ;focused application volume down 2%
        focusVolDown2HK := "F13"
        hotkey, %focusVolDown2HK%, focusVolDown2Lab
    ;focused application volume up 2%
        focusVolUp2HK := "F14"
        hotkey, %focusVolUp2HK%, focusVolUp2Lab
    ;focused application volume down 5%
        focusVolDown5HK := ">+F13"
        hotkey, %focusVolDown5HK%, focusVolDown5Lab
    ;focused application volume up 5%
        focusVolUp5HK := ">+F14"
        hotkey, %focusVolUp5HK%, focusVolUp5Lab
    ;Media volume control (firefox,chrome,tidal,and spotify) down 2%
        mediaVolDown2HK := "F15"
        hotkey, %mediaVolDown2HK%, mediaVolDown2Lab
    ;Media volume control (firefox,chrome,tidal,and spotify) up 2%
        mediaVolUp2HK := "F16"
        hotkey, %mediaVolUp2HK%, mediaVolUp2Lab
    ;Media volume control (firefox,chrome,tidal,and spotify) down 5%
        mediaVolDown5HK := ">+F15"
        hotkey, %mediaVolDown5HK%, mediaVolDown5Lab
    ;Media volume control (firefox,chrome,tidal,and spotify) up 5%
        mediaVolUp5HK := ">+F16"
        hotkey, %mediaVolUp5HK%, mediaVolUp5Lab
    ;Line in volume control down 2%
        lineVolDown2HK := "F17"
        hotkey, %lineVolDown2HK%, lineVolDown2Lab
    ;Line in volume control up 2%
        lineVolUp2HK := "F18"
        hotkey, %lineVolUp2HK%, lineVolUp2Lab
    ;Line in volume control down 5%
        lineVolDown5HK := ">+F17"
        hotkey, %lineVolDown5HK%, lineVolDown5Lab
    ;Line in volume control up 5%
        lineVolUp5HK := ">+F18"
        hotkey, %lineVolUp5HK%, lineVolUp5Lab 
Return
;One time helper keys
    ; Open hotkey sheet
        sheetLab:
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
        allActiveLab:
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
        reloadLab: 
            MsgBox, Reloading Script dailyDriver.ahk
            Reload
            return
;Application min, max, and monitor cycle
    ;Maximize or restore toggle for active window 
        maxToggleLab:
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
        minWinLab:
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
            Return
    ;Move active window to other monitor
        monitorCycleLab:
            Send, {LWinDown}{ShiftDown}{Left}{ShiftUp}{LWinUp}
            Return
;Application process kill  
    ;Kill current active process/close tab
        killProcessLab:
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
            If (this_title ~= "Google Chrome")
            {
                Send, {CtrlDown}{F4}{CtrlUp}
                Return
            }
            Else
            {
                WinClose, A
                Return
            }
            Return
;Application open and make active. Cycle tabs
    ;Firefox Default Account make active/cycle tabs
        ffOpenMainLab:
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
                Return
            }
            IfWinNotExist, %profile%
            {
                Run, cmd.exe /c start firefox.exe -p %profileName% -new-tab about:home ,,Hide
                WinWait, %profileName%
                Return
            } 
            Return
    ;Firefox Alt Account make active/cycle tabs
        ffOpenAltLab:
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
                Return
            }
            IfWinNotExist, %profile%
            {
                Run, cmd.exe /c start firefox.exe -p %profileName% -new-tab about:home ,,Hide
                WinWait, %profileName%
                Return
            } 
            Return
    ;Chrome Main Account make active/cycle tabs
        chromeOpenMainLab:
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
        chromeOpenWorkLab:
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
    ;Visual Studio make active/cycle tabs
        VSCodeOpenLab:
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
    ;TIDAL make active/open
        tidalOpenLab:
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
            Return
    ;Spotify make active/open
        spotifyOpenLab:
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
    ;Photoshop make active/open cycle tabs  
        psOpenLab:
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
    ;Steam Main make active/open 
        steamOpenMainLab:
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
    ;Steam Alt make active/open
        steamOpenAltLab:
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
    ;Koolertron Editor active/open
        koolertronOpenLab:
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
;Application new tabs
    ;Firefox Default Account open new tab
        ffNewTabMainLab:
            profile := "-Main-" 
            profileName := "default-release"
            WinGet, this_ID, ID, %profile%
            Runwait, cmd.exe /c start firefox.exe -p %profileName% -new-tab about:home ,,Hide
            WinWaitClose, 
            WinActivate, ahk_id %this_ID%
            Return        
    ;Firefox Alt Account open new tab
        ffNewTabAltLab:
            profile := "-Hifi-" 
            profileName := "HifiVox"
            WinGet, this_ID, ID, %profile%
            Runwait, cmd.exe /c start firefox.exe -p %profileName% -new-tab about:home ,,Hide
            WinWaitClose, 
            WinActivate, ahk_id %this_ID%
            Return     
    ;Chrome Main Account open new tab
        chromeNewTabMainLab:
            profile := "|Main|" 
            profileName := "default"
            WinGet, this_ID, ID, %profile%
            Runwait, cmd.exe /c start chrome.exe --args --profile-directory=%profileName% www.google.com  ,,Hide
            WinWaitClose, 
            WinActivate, ahk_id %this_ID%
            Return 
    ;Chrome Work Account open new tab
        chromeNewTabWorkLab:
            profile := "|Work|" 
            profileName := """profile 1"""
            WinGet, this_ID, ID, %profile%
            Runwait, cmd.exe /c start chrome.exe --args --profile-directory=%profileName% www.google.com  ,,Hide
            WinWaitClose, 
            WinActivate, ahk_id %this_ID%
            Return  
;Volume Controls
    ;main system volume down 2%
        mainSysVolDown2Lab:
            SoundSet -2 
            Return
    ;main system volume up 2%
        mainSysVolUp2Lab:
            SoundSet +2
            Return       
    ;main system volume down 5%
        mainSysVolDown5Lab:
            SoundSet -5
            Return
    ;main system volume up 5%
        mainSysVolUp5Lab:
            SoundSet +5
            Return
    ;focused application volume down 2%
        focusVolDown2Lab:
            Run cmd.exe /c start nircmd.exe changeappvolume focused -0.02 ,,Hide
            return
    ;focused application volume up 2%        
        focusVolUp2Lab:
            Run cmd.exe /c start nircmd.exe changeappvolume focused +0.02 ,,Hide
            return
    ;focused application volume down 5%
        focusVolDown5Lab:
            Run cmd.exe /c start nircmd.exe changeappvolume focused -0.05 ,,Hide
            return
    ;focused application volume up 5%
        focusVolUp5Lab:
            Run cmd.exe /c start nircmd.exe changeappvolume focused +0.05 ,,Hide
            return
    ;Media volume control (firefox,chrome,tidal,and spotify) down 2%
        mediaVolDown2Lab:
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
    ;Media volume control (firefox,chrome,tidal,and spotify) up 2%
        mediaVolUp2Lab:
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
    ;Media volume control (firefox,chrome,tidal,and spotify) down 5%
        mediaVolDown5Lab:
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
            IfWinExist, ahk_exe TIDAL.exe
            {
                Run cmd.exe /c start nircmd.exe changeappvolume TIDALPlayer.exe -0.05 ,,Hide            
            }
            IfWinExist, ahk_exe Spotify.exe
            {
                WinGet, spotPID, PID, ahk_exe Spotify.exe
                Run cmd.exe /c start nircmd.exe changeappvolume Spotify.exe -0.05 ,,Hide            
            }
            Return
    ;Media volume control (firefox,chrome,tidal,and spotify) up 5%
        mediaVolUp5Lab:
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
            IfWinExist, Google Chrome
            {
                Run cmd.exe /c start nircmd.exe changeappvolume chrome.exe +0.05 ,,Hide
            } 
            IfWinExist, ahk_exe TIDAL.exe
            {
                Run cmd.exe /c start nircmd.exe changeappvolume TIDALPlayer.exe +0.05 ,,Hide            
            }
            IfWinExist, ahk_exe Spotify.exe
            {
                WinGet, spotPID, PID, ahk_exe Spotify.exe
                Run cmd.exe /c start nircmd.exe changeappvolume Spotify.exe +0.05 ,,Hide            
            }
            Return
    ;Line in volume control down 2%
        lineVolDown2Lab:
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
    ;Line in volume control up 2% 
        lineVolUp2Lab:  
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

    ;Line in volume control down 5%
        lineVolDown5Lab:
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
    ;Line in volume control up 5%  
        lineVolUp5Lab:  
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

  

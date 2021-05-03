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
grabInputPID()
{
    tmpFile = ~~TaskListResult~~
    RunWait %comspec% /c tasklist /svc > %tmpFile%,, Hide
    ; Read fast and delete, may even avoid writting to disk...
    FileRead taskList, %tmpFile%
    FileDelete %tmpFile%

    searchedImage = svchost.exe
    searchedService = Audiosrv ; Just test value, put what you need
    imageNameLen := StrLen(searchedImage)

    Loop Parse, taskList, `n, `r
    {
        StringLeft imageName, A_LoopField, %imageNameLen%
        If (imageName = searchedImage)
        {
            StringMid pid, A_LoopField, 29, 7
            ;MsgBox %pid% - %A_LoopField%
        }  
        IfInString A_LoopField, %searchedService%
        {
            ; /!\ I suppose the service name can be found only for the searched image
            ; Otherwise, a stronger check must be made
            bFound := true
            Break
        }
    }
    StringReplace, pidNoSpace, pid, %A_Space%,,All
    If (bFound)
    {
        ;MsgBox Searched PID is: (%pidNoSpace%)
    }
    Else
    {
        MsgBox Oops, no PID found...
    }
    Return pidNoSpace
}

LineInPID := grabInputPID()
;MsgBox, %LineInPID%

;Global variables
firstActiveHoldCount := 0
firstActiveHoldID := ""
secondActiveHoldCount := 0
secondActiveHoldID := ""
lineInMutePercent := 0
;HOTKEYS 
    ;HOTKEYS Media Keys 
        ;Track control
            ;Track Previous
                trackPrevHK := "<+F13"
                hotkey, %trackPrevHK%, trackPrevLab             
            ;Track play/pause
                trackPlayHK := "<+F15"
                hotkey, %trackPlayHK%, trackPlayLab   
            ;Track next 
                trackNextHK := "<+F17"
                hotkey, %trackNextHK%, trackNextLab 
    ;HOTKEYS One time helper keys
        ;Open hotkey sheet
            SheetHK := "<+<^<!H"
            hotkey, %SheetHK%, sheetLab
        ;All active Windows
            allActiveHK := "<+<^!K"
            hotkey, %allActiveHK%, allActiveLab
        ;Script reload
            reloadHK := "<+<!R"
            hotkey, %reloadHK%, reloadLab
        ;Open helper GUI
            helperGUIHK := "<+<^<!G"
            hotkey, %helperGUIHK%, helperGUILab
        ;Active window check 
            activeCheckHK := "<+<^<!_"
            hotkey, %activeCheckHK%, activeCheckLab               
    ;HOTKEYS Application min, max, and monitor cycle 
        ;Maximize or restore toggle for active window 
            maxToggleHK := "F22"
            hotkey, %maxToggleHK%, maxToggleLab
        ;Move active window to other monitor    
            monitorCycleHK := "F24"
            hotkey, %monitorCycleHK%, monitorCycleLab
        ;Move active window to other monitor    
            monitor1OnlyHK := "<+F20"
            hotkey, %monitor1OnlyHK%, monitor1OnlyLab
        ;Move active window to other monitor    
            monitor2OnlyHK := "<+F22"
            hotkey, %monitor2OnlyHK%, monitor2OnlyLab
        ;Move active window to other monitor    
            monitorExtendHK := "<+F24"
            hotkey, %monitorExtendHK%, monitorExtendLab
        ;Restore windows
            restoreWinPosHK := "^F24"
            hotkey, %restoreWinPosHK%, restoreWinPosLab
    ;HOTKEYS Application process kill
        ;Kill current active process/close tab
            killProcessHK:= "<+F14"
            hotkey, %killProcessHK%, killProcessLab
    ;HOTKEYS Application open and make active. Cycle tabs
        ;First Active window save / make active
            firstActiveHoldHK := ">+F21"
            hotkey, %firstActiveHoldHK%, firstActiveHoldLab
        ;Second Active window save / make active
            secondActiveHoldHK := ">+F23"
            hotkey, %secondActiveHoldHK%, secondActiveHoldLab
        ;First Active window clear
            firstActiveClearHK := ">+F22"
            hotkey, %firstActiveClearHK%, firstActiveClearLab
        ;Second Active window clear
            secondActiveClearHK := ">+F24"
            hotkey, %secondActiveClearHK%, secondActiveClearLab
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
        ;Pocket Casts make active/open
            PCOpenHK := ">!>^F22"
            hotkey, %PCOpenHK%, PCOpenLab
        ;VLC Player make ative/open
            vlcOpenHK := ">^F23"
            hotkey, %vlcOpenHK%, vlcOpenLab        
        ;Photoshop make active/open cycle tabs
            psOpenHK := ">+>^F23"
            hotkey, %psOpenHK%, psOpenLab
        ;Steam Main make active/open   
            steamOpenMainHK := ">^F24"
            hotkey, %steamOpenMainHK%, steamOpenMainLab
        ;Steam Alt make active/open 
            steamOpenAltHK := ">+>^F24"
            hotkey, %steamOpenAltHK%, steamOpenAltLab
        ;Koolertron Editor active/open
            koolertronOpenHK := "<+>^F24"
            hotkey, %koolertronOpenHK%, koolertronOpenLab
        ;Volume mixer open/make active
            volMixOpenHK := "F23"
            hotkey, %volMixOpenHK%, volMixOpenLab  
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
        ;Mute Channels
            ;Mute/Unmute Focused volume
                focusVolMuteHK := "<!F14"
                hotkey, %focusVolMuteHK%, focusVolMuteLab
            ;Mute/Unmute Media volume
                mediaVolMuteHK := "<!F16"
                hotkey, %mediaVolMuteHK%, mediaVolMuteLab
            ;Mute/Unmute Line In volume
                lineVolMuteHK := "<!F18"
                hotkey, %lineVolMuteHK%, lineVolMuteLab
            ;Mute/Unmute System volume
                sysVolMuteHK := "<!F20"
                hotkey, %sysVolMuteHK%, sysVolMuteLab
        ;focused application volumes
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
            ;focused application volume down 10%
                focusVolDown10HK := ">!F13"
                hotkey, %focusVolDown10HK%, focusVolDown10Lab
            ;focused application volume down 10%
                focusVolUp10HK := ">!F14"
                hotkey, %focusVolUp10HK%, focusVolUp10Lab
        ;Media volumes
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
            ;Media volume control (firefox,chrome,tidal,and spotify) down 10%
                mediaVolDown10HK := ">!F15"
                hotkey, %mediaVolDown10HK%, mediaVolDown10Lab
            ;Media volume control (firefox,chrome,tidal,and spotify) up 10%
                mediaVolUp10HK := ">!F16"
                hotkey, %mediaVolUp10HK%, mediaVolUp10Lab
        ;Line in volumes
            ;Line in volume control down 1%
                lineVolDown1HK := "F17"
                hotkey, %lineVolDown1HK%, lineVolDown1Lab
            ;Line in volume control up 1%
                lineVolUp1HK := "F18"
                hotkey, %lineVolUp1HK%, lineVolUp1Lab
            ;Line in volume control down 5%
                lineVolDown5HK := ">+F17"
                hotkey, %lineVolDown5HK%, lineVolDown5Lab
            ;Line in volume control up 5%
                lineVolUp5HK := ">+F18"
                hotkey, %lineVolUp5HK%, lineVolUp5Lab
            ;Line in volume control down 10%  
                lineVolDown10HK := ">!F17"
                hotkey, %lineVolDown10HK%, lineVolDown10Lab
            ;Line in volume control up 10%
                lineVolUp10HK := ">!F18"
                hotkey, %lineVolUp10HK%, lineVolUp10Lab
        ;main system volumes   
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
            ;main system volume down 10%
                mainSysVolDown10HK := ">!F19"
                hotkey, %mainSysVolDown10HK%, mainSysVolDown10Lab        
            ;main system volume up 10% 
                mainSysVolUp10HK := ">!F20"
                hotkey, %mainSysVolUp10HK%, mainSysVolUp10Lab   
    ;HOTKEYS EQ and Sound Output
        ;Switch output with EQ change
            ;Set BTA30 Digital output/Peace EQ XM4
                DOEQHK := "<!>^F19"
                hotkey, %DOEQHK%, DOEQLab   
            ;Set Logitech Pro X output/Peace EQ Pro X
                LPXEQHK := "<!>^F20"
                hotkey, %LPXEQHK%, LPXEQLab   
            ;Set FiiO K5 Speaker output/Peace EQ 770 80ohm
                K5770EQHK := "<!>^F21"
                hotkey, %K5770EQHK%, K5770EQLab  
            ;Set FiiO K5 Speaker output/Peace EQ MK5  
                K5MK5EQHK := "<!>^F22"
                hotkey, %K5MK5EQHK%, K5MK5EQLab  
    Return
;Main code
    ;Media Keys
        ;Track Control
            ;Track Previous
                trackPrevLab:
                    Send {Media_Prev}
                    return
            ;Track Play/Pause
                trackPlayLab:
                    Send {Media_Play_Pause}
                    return
            ;Track next
                trackNextLab:
                    Send {Media_Next}
                    return
    ;One time helper keys
        ;Open hotkey sheet
            sheetLab:
                profile := "-Main-" 
                profileName := "default-release-1"            
                IfWinExist, AHK-DailyDriver hotkey mapping
                {
                    sheetId := WinExist("AHK-DailyDriver hotkey mapping")
                    WinActivate, ahk_id %sheetId%
                }
                IfWinNotExist, AHK-DailyDriver hotkey mapping
                {
                    RunWait, C:\Program Files\Mozilla Firefox\firefox.exe -p %profileName% -new-tab https://docs.google.com/spreadsheets/d/1eRfcNj-UR4kXf5fBXDS4rn95YMSlbbT8McJL3HkK-_A/edit ,,Hide 
                }    
                Return
        ;Active window check
            activeCheckLab:
                soundVar := "svchost.exe%b{ac704d33-4b02-492c-a578-f52c49993ce0}"
                WinGet, SoundPid, PID, ahk_exe %soundVar%
                MsgBox, %SoundPid%
                noneStg := "None"
                this_id := WinExist("A")
                WinGetTitle, this_title, ahk_id %this_id%
                WinGetClass, this_class, ahk_id %this_id%
                WinGet, this_PID, PID, ahk_id %this_id%
                If (firstActiveHoldID = "" && secondActiveHoldID = "")
                {
                    MsgBox,Active window info:`n`n Title = %this_title%`n Class = %this_class%`n PID = %this_PID%`n`n Active Hold info:`n`n firstActiveHoldCount = %firstActiveHoldCount%`n firstActiveHoldID = %noneStg%`n secondActiveHoldCount = %secondActiveHoldCount%`n secondActiveHoldID = %noneStg%
                    Return
                }
                If (firstActiveHoldID = "")
                {
                    MsgBox,Active window info:`n`n Title = %this_title%`n Class = %this_class%`n PID = %this_PID%`n`n Active Hold info:`n`n firstActiveHoldCount = %firstActiveHoldCount%`n firstActiveHoldID = %noneStg%`n secondActiveHoldCount = %secondActiveHoldCount%`n secondActiveHoldID = %secondActiveHoldID%
                    Return            
                }
                If (secondActiveHoldID = "")
                {
                    MsgBox,Active window info:`n`n Title = %this_title%`n Class = %this_class%`n PID = %this_PID%`n`n Active Hold info:`n`n firstActiveHoldCount = %firstActiveHoldCount%`n firstActiveHoldID = %firstActiveHoldID%`n secondActiveHoldCount = %secondActiveHoldCount%`n secondActiveHoldID = %noneStg%
                    Return            
                }
                MsgBox,Active window info:`n`n Title = %this_title%`n Class = %this_class%`n PID = %this_PID%`n`n Active Hold info:`n`n firstActiveHoldCount = %firstActiveHoldCount%`n firstActiveHoldID = %firstActiveHoldID%`n secondActiveHoldCount = %secondActiveHoldCount%`n secondActiveHoldID = %secondActiveHoldID%
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
                currAct := WinActive("A")
                MsgBox, Reloading Script dailyDriver.ahk
                Reload
                WinActivate, ahk_id %currAct%
                return
        ;Open helper GUI
            helperGUILab:
            IfWinNotExist, Koolertron Keybinds 
            {
                RunWait, HelperGUI.ahk
            }
            Return
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
        ;Move active window to other monitor
            monitorCycleLab:
                Send, {LWinDown}{ShiftDown}{Left}{ShiftUp}{LWinUp}
                Return
        ;Set Monitor 1 only
            monitor1OnlyLab:
                FileDelete, AllWinPos.txt
                SysGet, numOfMonitors, MonitorCount
                SysGet, priMonitor, MonitorPrimary
                SysGet, mon1, Monitor, 1
                SysGet, mon2, Monitor, 2
                WinGet,Windows,List
                ;MsgBox, %Windows%
                Loop,%Windows%
                {
                    this_id := "ahk_id " . Windows%A_Index%
                    WinGetTitle, this_title, %this_id%
                    WinGetClass, this_class, %this_id%
                    WinGet, this_PID, PID, %this_id%
                    WinGet, Winstate, MinMax, %this_id%
                    
                    ;MsgBox, Title = %this_title%`n Class = %this_class%`n PID = %this_PID%
                    WinGetPos, currX, currY, currH, currW, %this_id%
                    ;MsgBox, %currX%
                    FileAppend, %currX%\%currY%\%currH%\%currW%\%Winstate%\%this_title%`n, AllWinPos.txt
                }
                ;MsgBox, Monitor 1
                Run cmd.exe /c C:\Windows\System32\DisplaySwitch.exe /internal ,,Hide
                Return
        ;Set monitor 2 only
            monitor2OnlyLab:
                FileDelete, AllWinPos.txt
                SysGet, numOfMonitors, MonitorCount
                SysGet, priMonitor, MonitorPrimary
                SysGet, mon1, Monitor, 1
                SysGet, mon2, Monitor, 2
                WinGet,Windows,List
                ;MsgBox, %Windows%
                Loop,%Windows%
                {
                    this_id := "ahk_id " . Windows%A_Index%
                    WinGetTitle, this_title, %this_id%
                    WinGetClass, this_class, %this_id%
                    WinGet, this_PID, PID, %this_id%
                    WinGet, Winstate, MinMax, %this_id%
                    
                    ;MsgBox, Title = %this_title%`n Class = %this_class%`n PID = %this_PID%
                    WinGetPos, currX, currY, currH, currW, %this_id%
                    ;MsgBox, %currX%
                    FileAppend, %currX%\%currY%\%currH%\%currW%\%Winstate%\%this_title%`n, AllWinPos.txt
                }
                ;MsgBox, Monitor 2
                Run cmd.exe /c C:\Windows\System32\DisplaySwitch.exe /external ,,Hide
                Return
        ;Set extended monitor layout
            monitorExtendLab:
                ;MsgBox, Monitor Extend
                RunWait, cmd.exe /c C:\Windows\System32\DisplaySwitch.exe /extend ,,Hide
                Sleep, 3000
                ;Loop, Read, AllWinPos.txt
                ;{
                ;    currInnerActive := WinActive("A")
                ;    ;MsgBox, %A_LoopReadLine%
                ;    StringSplit, HoldArr, A_LoopReadLine, \
                ;    If (HoldArr6 != "Program Manager")
                ;    {
                ;        If (HoldArr6 != "Switch USB")
                ;        {
                ;            If (HoldArr6)
                ;            {
                ;                If (HoldArr2 < -1080)
                ;                {
                ;                ;MsgBox %HoldArr6% met condition with %HoldArr1% %HoldArr2%
                ;                WinGetPos, currInnerX, currInnerY, currInnerH, currInnerW, %HoldArr7%
                ;                WinGet, WinState, MinMax, %HoldArr7%
                ;                ;MsgBox %HoldArr6%`n x: %currInnerX%`n y: %currInnerY%
                ;                    WinActivate, %HoldArr6%
                ;                    Send, {LWinDown}{ShiftDown}{Left}{ShiftUp}{LWinUp}
                ;                    If (WinState != 1)
                ;                    {
                ;                        WinMaximize, %HoldArr6%
                ;                    }
                ;                    WinActivate, ahk_id currInnerActive
                ;                }
                ;            }
                ;        }
                ;    }
                ;}
                Return
        ;Restore window config
            restoreWinPosLab:
                Loop, Read, AllWinPos.txt
                {
                    currInnerActive := WinActive("A")
                    ;MsgBox, %A_LoopReadLine%
                    StringSplit, HoldArr, A_LoopReadLine, \
                    If (HoldArr6 != "Program Manager")
                    {
                        If (HoldArr6 != "Switch USB")
                        {
                            If (HoldArr6)
                            {
                                If (HoldArr1 < -9 ||HoldArr2 < -9)
                                {
                                    ;MsgBox %HoldArr6% met condition with %HoldArr1% %HoldArr2%
                                    WinGetPos, currInnerX, currInnerY, currInnerH, currInnerW, %HoldArr7%
                                    ;MsgBox %HoldArr6%`n x: %currInnerX%`n y: %currInnerY%
                                    If (currInnerY < -9)
                                    {
                                        ;MsgBox break met
                                    }
                                    Else
                                    {
                                        WinActivate, %HoldArr6%
                                        Send, {LWinDown}{ShiftDown}{Left}{ShiftUp}{LWinUp}
                                        WinActivate, ahk_id currInnerActive
                                    }
                                }
                            }
                        }
                    }
                }
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
        ;First active hold key/make active
            firstActiveHoldLab:
                If (firstActiveHoldCount = 0)
                {
                    firstActiveHoldID := WinExist("A")
                    If (firstActiveHoldID = "")
                    {
                        MsgBox,, Notice, No active window was selected try again, 1
                        Return
                    }
                    firstActiveHoldCount++
                    Return
                }
                If (firstActiveHoldCount = 1)
                {
                    ;error handling
                    If (firstActiveHoldID = "")
                    {
                        MsgBox,, Notice, No active window held, 1
                        firstActiveHoldCount := 0 
                        Return
                    }
                    IfWinActive, ahk_id %firstActiveHoldID%
                    {
                        Return
                    }
                    IfWinNotActive, ahk_id %firstActiveHoldID%
                    {
                        WinActivate, ahk_id %firstActiveHoldID%
                        Return
                    }
                }           
                Return   
        ;Second active hold key/make active
            secondActiveHoldLab:
                If (secondActiveHoldCount = 0)
                {
                    secondActiveHoldID := WinExist("A")
                    If (secondActiveHoldID = "")
                    {
                        MsgBox,, Notice, No active window was selected try again., 1
                        Return
                    }
                    secondActiveHoldCount++
                    Return
                }
                If (secondActiveHoldCount = 1)
                {
                    ;error handling
                    If (secondActiveHoldID = "")
                    {
                        MsgBox,, Notice, No active window held, 1
                        secondActiveHoldCount := 0 
                        Return
                    }
                    IfWinActive, ahk_id %secondActiveHoldID%
                    {
                        Return
                    }
                    IfWinNotActive, ahk_id %secondActiveHoldID%
                    {
                        WinActivate, ahk_id %secondActiveHoldID%
                        Return
                    }
                }           
                Return 
        ;First active hold clear
            firstActiveClearLab:
                firstHold := WinActive("A")
                firstActiveHoldCount := 0
                firstActiveHoldID := ""
                MsgBox,, Notice, First window hold cleared, 1
                WinActivate, ahk_id %firstHold%
                Return
        ;Second active hold clear
            secondActiveClearLab:
                secondHold := WinActive("A")
                secondActiveHoldCount := 0
                secondActiveHoldID := ""
                MsgBox,, Notice, Second window hold cleared, 1
                WinActivate, ahk_id %secondHoldHold%
                Return 
        ;Firefox Default Account make active/cycle tabs
            ffOpenMainLab:
                profile := "-Main-" 
                profileName := "default-release-1"
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
                    Run, C:\Program Files\Mozilla Firefox\firefox.exe -p %profileName% -new-tab about:home ,,Hide
                    WinWait, %profile%
                    Return
                } 
                Return
        ;Firefox Alt Account make active/cycle tabs
            ffOpenAltLab:
                profile := "-Hifi-" 
                profileName := "default-nightly"
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
                    Run, C:\Program Files\Firefox Nightly\firefox.exe -p %profileName% -new-tab about:home ,,Hide
                    WinWait, %profile%
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
                profile := "Visual Studio Code"
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
                    Run, "C:\Users\Colton\AppData\Local\Programs\Microsoft VS Code\Code.exe" ,,Hide
                    Return
                } 
                Return  
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
                    Run, "C:\Users\Colton\AppData\Local\TIDAL\TIDAL.exe" ,,Hide
                    Return
                } 
                Return
        ;Spotify make active/open
            spotifyOpenLab:
                IfWinExist, ahk_exe C:\Users\Colton\AppData\Roaming\Spotify\Spotify.exe
                {
                    WinGet,spotActive,ID, ahk_exe C:\Users\Colton\AppData\Roaming\Spotify\Spotify.exe
                    WinActivate, ahk_id %spotActive%
                    Return
                }
                IfWinNotExist, ahk_exe C:\Users\Colton\AppData\Roaming\Spotify\Spotify.exe
                {
                    RunWait, "C:\Users\Colton\AppData\Roaming\Spotify\Spotify.exe" ,,Hide
                    Return
                } 
        ;Pocket Casts make active/open
            PCOpenLab:    
                IfWinExist, Pocket Casts Desktop
                {
                    WinGet,spotActive,ID, Pocket Casts Desktop
                    WinActivate, ahk_id %spotActive%
                    Return
                }
                IfWinNotExist, Pocket Casts Desktop
                {
                    RunWait, "C:\Users\Colton\Documents\WindowsAppLink\Pocket Casts Desktop"
                    Return
                } 
        ;VLC Player make active/open
            vlcOpenLab:
                IfWinActive, VLC media player
                {
                    Sleep, 100
                    Send, {CtrlDown}1{CtrlUp}
                    Return
                }
                IfWinExist, VLC media player
                {
                    WinGet,spotActive,ID, VLC media player
                    WinActivate, ahk_id %spotActive%
                    Return
                }
                IfWinNotExist, VLC media player
                {
                    Runwait, "C:\Program Files\VideoLAN\VLC\vlc.exe"
                    return
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
                    Run, "C:\Users\Colton\Documents\SteamMain.bat" ,,Hide
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
                    Run, "C:\Users\Colton\Documents\SteamPBX.bat" ,,Hide
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
                    RunWait, "C:\Users\Colton\Documents\amag\amag\AMAG_EN\AMAG.exe" ,,Hide
                    amagID := WinExist(ahk_exe "C:\Users\Colton\Documents\amag\amag\AMAG_EN\AMAG.exe")
                    WinActivate, ahk_id %amagID%
                    Return
                }
        ;Volume mixer open/make active
            volMixOpenLab:
                IfWinNotExist, ahk_exe SndVol.exe
                {
                    Run C:\Windows\System32\SndVol.exe 
                    WinWait, ahk_exe SndVol.exe    
                    WinActivate, ahk_exe SndVol.exe               
                }  
                If WinExist("ahk_exe SndVol.exe")  
                    WinActivate, ahk_exe SndVol.exe
                Return
    ;Application new tabs
        ;Firefox Default Account open new tab
            ffNewTabMainLab:
                profile := "-Main-" 
                profileName := "default-release-1"
                WinGet, this_ID, ID, %profile%
                Runwait, C:\Program Files\Mozilla Firefox\firefox.exe -p %profileName% -new-tab about:home,,Hide 
                WinActivate, ahk_id %this_ID%
                Return        
        ;Firefox Alt Account open new tab
            ffNewTabAltLab:
                profile := "-Hifi-" 
                profileName := "default-nightly"
                WinGet, this_ID, ID, %profile%
                Runwait, C:\Program Files\Firefox Nightly\firefox.exe  -p %profileName% -new-tab about:home ,,Hide
                WinActivate, ahk_id %this_ID%
                Return     
        ;Chrome Main Account open new tab
            chromeNewTabMainLab:
                profile := "|Main|" 
                profileName := "default"
                WinGet, this_ID, ID, %profile%
                Runwait, cmd.exe /c start chrome.exe --args --profile-directory=%profileName% www.google.com  ,,Hide
                WinActivate, ahk_id %this_ID%
                Return 
        ;Chrome Work Account open new tab
            chromeNewTabWorkLab:
                profile := "|Work|" 
                profileName := """profile 1"""
                WinGet, this_ID, ID, %profile%
                Runwait, cmd.exe /c start chrome.exe --args --profile-directory=%profileName% www.google.com  ,,Hide
                WinActivate, ahk_id %this_ID%
                Return  
    ;Volume Controls
        ;Mute channels    
            ;Mute/Unmute Focused volume
                focusVolMuteLab: 
                    return               
            ;Mute/Unmute Media volume\
                mediaVolMuteLab:
                    return
            ;Mute/Unmute Line In volume
                lineVolMuteLab:
                    RunWait, cmd.exe /c SoundVolumeView.exe /stab "" | GetNir "Volume Percent" "ProcessID= %LineInPID%" "Type=Application" "DeviceName= 3- USB Multi-Channel Audio Device" "Direction= Render" > VolumePercents/LineInPercent.txt ,,Hide
                    FileReadLine, lineInPercentVal, VolumePercents/LineInPercent.txt, 1
                    StringTrimRight, trimmedPercentVal, lineInPercentVal, 1
                    If (trimmedPercentVal != 0.0)
                    {
                        lineInMutePercent := trimmedPercentVal
                    }
                    Else
                    {
                        MsgBox,,Notice, Line in channel is already muted, 1
                        return
                    }
                    SoundGet, currSysVolStart
                    percentAdjust := ((currSysVolStart/100) * (lineInMutePercent))/100
                    If (lineInMutePercent = 0.0)
                    {
                        Run cmd.exe /c start nircmd.exe changeappvolume /%LineInPID% +%percentAdjust% ,,Hide                        
                    }   
                    Else
                    {

                        Run cmd.exe /c start nircmd.exe changeappvolume /%LineInPID% -1 ,,Hide
                    }
                    return
            ;Mute/Unmute System volume
                sysVolMuteLab:
                    Send, {Volume_Mute}
                    return
        ;focused application volumes
            ;focused application volume down 2%
                focusVolDown2Lab:
                    SoundGet, currVol
                    percentCurrVol := currVol / 100
                    percentRecalc := 0.02 / percentCurrVol
                    Run cmd.exe /c start nircmd.exe changeappvolume focused -%percentRecalc% ,,Hide
                    return
            ;focused application volume up 2%        
                focusVolUp2Lab:
                    SoundGet, currVol
                    percentCurrVol := currVol / 100
                    percentRecalc := 0.02 / percentCurrVol 
                    vlcAdjust := percentRecalc/10 
                    Run cmd.exe /c start nircmd.exe changeappvolume focused +%percentRecalc% ,,Hide
                    return
            ;focused application volume down 5%
                focusVolDown5Lab:
                    SoundGet, currVol
                    percentCurrVol := currVol / 100
                    percentRecalc := 0.05 / percentCurrVol 
                    Run cmd.exe /c start nircmd.exe changeappvolume focused -%percentRecalc% ,,Hide
                    return
            ;focused application volume up 5%
                focusVolUp5Lab:
                    SoundGet, currVol
                    percentCurrVol := currVol / 100
                    percentRecalc := 0.05 / percentCurrVol
                    Run cmd.exe /c start nircmd.exe changeappvolume focused +%percentRecalc% ,,Hide
                    return
            ;focused application volume down 10%
                focusVolDown10Lab:
                    SoundGet, currVol
                    percentCurrVol := currVol / 100
                    percentRecalc := 0.1 / percentCurrVol 
                    Run cmd.exe /c start nircmd.exe changeappvolume focused -%percentRecalc% ,,Hide
                    return
            ;focused application volume up 10%
                focusVolUp10Lab:
                    SoundGet, currVol
                    percentCurrVol := currVol / 100
                    percentRecalc := 0.1 / percentCurrVol 
                    Run cmd.exe /c start nircmd.exe changeappvolume focused +%percentRecalc% ,,Hide
                    return
        ;Media volumes
            ;Media volume control (firefox,chrome,tidal,and spotify) down 2%
                mediaVolDown2Lab:
                    SoundGet, currVol
                    percentCurrVol := currVol / 100
                    percentRecalc := 0.02 / percentCurrVol            
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
                            Run cmd.exe /c start nircmd.exe changeappvolume /%v% -%percentRecalc% ,,Hide
                        }    
                    }
                    ;Check for active Google Chrome
                    IfWinExist, Google Chrome
                    {
                        Run cmd.exe /c start nircmd.exe changeappvolume chrome.exe -%percentRecalc% ,,Hide
                    }
                    IfWinExist, ahk_exe TIDAL.exe
                    {
                        Run cmd.exe /c start nircmd.exe changeappvolume TIDAL.exe -%percentRecalc% ,,Hide               
                        Run cmd.exe /c start nircmd.exe changeappvolume TIDALPlayer.exe -%percentRecalc% ,,Hide         
                    }
                    IfWinExist, ahk_exe Spotify.exe
                    {
                        Run cmd.exe /c start nircmd.exe changeappvolume Spotify.exe -%percentRecalc% ,,Hide            
                    }
                    IfWinExist, Pocket Casts
                    {
                        Run cmd.exe /c start nircmd.exe changeappvolume "Pocket Casts.exe" -%percentRecalc% ,,Hide                         
                    } 
                    IfWinExist, VLC media player 
                    {
                        Run cmd.exe /c start nircmd.exe changeappvolume vlc.exe -0.02 ,,Hide                        
                    }
                    Return
            ;Media volume control (firefox,chrome,tidal,and spotify) up 2%
                mediaVolUp2Lab:
                    SoundGet, currVol
                    percentCurrVol := currVol / 100
                    percentRecalc := 0.02 / percentCurrVol
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
                            Run cmd.exe /c start nircmd.exe changeappvolume /%v% +%percentRecalc% ,,Hide
                        }    
                    }
                    ;Check for active Google Chrome
                    IfWinExist, Google Chrome
                    {
                        Run cmd.exe /c start nircmd.exe changeappvolume chrome.exe +%percentRecalc% ,,Hide
                    } 
                    IfWinExist, ahk_exe TIDAL.exe
                    {
                        Run cmd.exe /c start nircmd.exe changeappvolume TIDALPlayer.exe +%percentRecalc% ,,Hide            
                    }
                    IfWinExist, ahk_exe Spotify.exe
                    {
                        Run cmd.exe /c start nircmd.exe changeappvolume Spotify.exe +%percentRecalc% ,,Hide            
                    }
                    IfWinExist, Pocket Casts
                    {
                        Run cmd.exe /c start nircmd.exe changeappvolume "Pocket Casts.exe" +%percentRecalc% ,,Hide                         
                    }
                    IfWinExist, VLC media player 
                    {
                        Run cmd.exe /c start nircmd.exe changeappvolume vlc.exe +0.02 ,,Hide                        
                    }
                    Return
            ;Media volume control (firefox,chrome,tidal,and spotify) down 5%
                mediaVolDown5Lab:
                     SoundGet, currVol
                    percentCurrVol := currVol / 100
                    percentRecalc := 0.05 / percentCurrVol                
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
                            Run cmd.exe /c start nircmd.exe changeappvolume /%v% -%percentRecalc% ,,Hide
                        }    
                    }
                    ;Check for active Google Chrome
                    IfWinExist, Google Chrome
                    {
                        Run cmd.exe /c start nircmd.exe changeappvolume chrome.exe -%percentRecalc% ,,Hide
                    }
                    IfWinExist, ahk_exe TIDAL.exe
                    {
                        Run cmd.exe /c start nircmd.exe changeappvolume TIDAL.exe -%percentRecalc% ,,Hide               
                        Run cmd.exe /c start nircmd.exe changeappvolume TIDALPlayer.exe -%percentRecalc% ,,Hide         
                    }
                    IfWinExist, ahk_exe Spotify.exe
                    {
                        Run cmd.exe /c start nircmd.exe changeappvolume Spotify.exe -%percentRecalc% ,,Hide            
                    }
                    IfWinExist, Pocket Casts
                    {
                        Run cmd.exe /c start nircmd.exe changeappvolume "Pocket Casts.exe" -%percentRecalc% ,,Hide                         
                    }
                    IfWinExist, VLC media player 
                    {
                        Run cmd.exe /c start nircmd.exe changeappvolume vlc.exe -0.05 ,,Hide                        
                    }
                    Return
            ;Media volume control (firefox,chrome,tidal,and spotify) up 5%
                mediaVolUp5Lab:
                    SoundGet, currVol
                    percentCurrVol := currVol / 100
                    percentRecalc := 0.05 / percentCurrVol  
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
                            Run cmd.exe /c start nircmd.exe changeappvolume /%v% +%percentRecalc% ,,Hide
                        }    
                    }
                    ;Check for active Google Chrome
                    IfWinExist, Google Chrome
                    {
                        Run cmd.exe /c start nircmd.exe changeappvolume chrome.exe +%percentRecalc% ,,Hide
                    } 
                    IfWinExist, ahk_exe TIDAL.exe
                    {
                        Run cmd.exe /c start nircmd.exe changeappvolume TIDALPlayer.exe +%percentRecalc% ,,Hide            
                    }
                    IfWinExist, ahk_exe Spotify.exe
                    {
                        Run cmd.exe /c start nircmd.exe changeappvolume Spotify.exe +%percentRecalc% ,,Hide            
                    }
                    IfWinExist, Pocket Casts
                    {
                        Run cmd.exe /c start nircmd.exe changeappvolume "Pocket Casts.exe" +%percentRecalc% ,,Hide                         
                    }
                    IfWinExist, VLC media player 
                    {
                        Run cmd.exe /c start nircmd.exe changeappvolume vlc.exe +0.05 ,,Hide                        
                    }
                    Return
            ;Media volume control (firefox,chrome,tidal,and spotify) down 10%
                mediaVolDown10Lab:
                    SoundGet, currVol
                    percentCurrVol := currVol / 100
                    percentRecalc := 0.1 / percentCurrVol                
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
                            Run cmd.exe /c start nircmd.exe changeappvolume /%v% -%percentRecalc% ,,Hide
                        }    
                    }
                    ;Check for active Google Chrome
                    IfWinExist, Google Chrome
                    {
                        Run cmd.exe /c start nircmd.exe changeappvolume chrome.exe -%percentRecalc% ,,Hide
                    }
                    IfWinExist, ahk_exe TIDAL.exe
                    {
                        Run cmd.exe /c start nircmd.exe changeappvolume TIDAL.exe -%percentRecalc% ,,Hide               
                        Run cmd.exe /c start nircmd.exe changeappvolume TIDALPlayer.exe -%percentRecalc% ,,Hide         
                    }
                    IfWinExist, ahk_exe Spotify.exe
                    {
                        Run cmd.exe /c start nircmd.exe changeappvolume Spotify.exe -%percentRecalc% ,,Hide            
                    }
                    IfWinExist, Pocket Casts
                    {
                        Run cmd.exe /c start nircmd.exe changeappvolume "Pocket Casts.exe" -%percentRecalc% ,,Hide                         
                    }
                    IfWinExist, VLC media player 
                    {
                        Run cmd.exe /c start nircmd.exe changeappvolume vlc.exe -0.1 ,,Hide                        
                    }
                    Return
            ;Media volume control (firefox,chrome,tidal,and spotify) up 10%
                mediaVolUp10Lab:
                    SoundGet, currVol
                    percentCurrVol := currVol / 100
                    percentRecalc := 0.1 / percentCurrVol  
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
                            Run cmd.exe /c start nircmd.exe changeappvolume /%v% +%percentRecalc% ,,Hide
                        }    
                    }
                    ;Check for active Google Chrome
                    IfWinExist, Google Chrome
                    {
                        Run cmd.exe /c start nircmd.exe changeappvolume chrome.exe +%percentRecalc% ,,Hide
                    } 
                    IfWinExist, ahk_exe TIDAL.exe
                    {
                        Run cmd.exe /c start nircmd.exe changeappvolume TIDALPlayer.exe +%percentRecalc% ,,Hide            
                    }
                    IfWinExist, ahk_exe Spotify.exe
                    {
                        Run cmd.exe /c start nircmd.exe changeappvolume Spotify.exe +%percentRecalc% ,,Hide            
                    }
                    IfWinExist, Pocket Casts
                    {
                        Run cmd.exe /c start nircmd.exe changeappvolume "Pocket Casts.exe" +%percentRecalc% ,,Hide                         
                    }
                    IfWinExist, VLC media player 
                    {
                        Run cmd.exe /c start nircmd.exe changeappvolume vlc.exe +0.1 ,,Hide                        
                    }
                    Return
        ;Line in volumes
            ;Line in volume control down 2%
                lineVolDown1Lab:
                    SoundGet, currVol
                    percentCurrVol := currVol / 100
                    percentRecalc := 0.02 / percentCurrVol
                    Run cmd.exe /c start nircmd.exe changeappvolume /%LineInPID% -%percentRecalc% ,,Hide
                    Return
            ;Line in volume control up 2% 
                lineVolUp1Lab: 
                    SoundGet, currVol
                    percentCurrVol := currVol / 100
                    percentRecalc := 0.02 / percentCurrVol
                    Run cmd.exe /c start nircmd.exe changeappvolume /%LineInPID% +%percentRecalc% ,,Hide
                    Return
            ;Line in volume control down 5%
                lineVolDown5Lab:  
                    SoundGet, currVol
                    percentCurrVol := currVol / 100
                    percentRecalc := 0.05 / percentCurrVol
                    Run cmd.exe /c start nircmd.exe changeappvolume /%LineInPID% -%percentRecalc% ,,Hide
                    Return
            ;Line in volume control up 5%  
                lineVolUp5Lab:  
                    SoundGet, currVol
                    percentCurrVol := currVol / 100
                    percentRecalc := 0.05 / percentCurrVol
                    Run cmd.exe /c start nircmd.exe changeappvolume /%LineInPID% +%percentRecalc% ,,Hide
                    Return
            ;Line in volume control down 10%
                lineVolDown10Lab:  
                    SoundGet, currVol
                    percentCurrVol := currVol / 100
                    percentRecalc := 0.1 / percentCurrVol
                    Run cmd.exe /c start nircmd.exe changeappvolume /%LineInPID% -%percentRecalc% ,,Hide
                    Return
            ;Line in volume control up 10%  
                lineVolUp10Lab:  
                    SoundGet, currVol
                    percentCurrVol := currVol / 100
                    percentRecalc := 0.1 / percentCurrVol
                    Run cmd.exe /c start nircmd.exe changeappvolume /%LineInPID% +%percentRecalc% ,,Hide
                    Return
        ;main system volumes
            ;main system volume down 2%
                mainSysVolDown2Lab:
                    Send, {Volume_Down 1}
                    Return
            ;main system volume up 2%
                mainSysVolUp2Lab:
                    Send, {Volume_up 1}
                    Return       
            ;main system volume down 4%
                mainSysVolDown5Lab:
                    Send, {Volume_Down 2}
                    Return
            ;main system volume up 5%
                mainSysVolUp5Lab:
                    Send, {Volume_up 2}
                    Return
            ;main system volume down 10%
                mainSysVolDown10Lab:
                    Send, {Volume_Down 5}
                    Return
            ;main system volume up 10%
                mainSysVolUp10Lab:
                    Send, {Volume_up 5}
                    Return
    ;EQ and Sound Output
        ;Switch output with EQ change
            ;Set BTA30 Digital output/Peace EQ XM4
                DOEQLab:
                Run cmd.exe /c start nircmd.exe setdefaultsounddevice "Digital Output" 1 ,,Hide
                Run cmd.exe /c start nircmd.exe setdefaultsounddevice "Digital Output" 2 ,,Hide
                Send, {ShiftDown}{AltDown}{CtrlDown}{Numpad0}{CtrlUp}{AltUp}{ShiftUp}
                return
            ;Set Logitech Pro X output/Peace EQ Pro X
                LPXEQLab:
                Run cmd.exe /c start nircmd.exe setdefaultsounddevice "Pro X" 1 ,,Hide
                Run cmd.exe /c start nircmd.exe setdefaultsounddevice "Pro X" 2 ,,Hide
                Send, {ShiftDown}{AltDown}{CtrlDown}{Numpad1}{CtrlUp}{AltUp}{ShiftUp}
                return
            ;Set FiiO K5 Speaker output/Peace EQ 770 80ohm
                K5770EQLab:
                Run cmd.exe /c start nircmd.exe setdefaultsounddevice "K5 Pro" 1 ,,Hide
                Run cmd.exe /c start nircmd.exe setdefaultsounddevice "K5 Pro" 2 ,,Hide
                Send, {ShiftDown}{AltDown}{CtrlDown}{Numpad2}{CtrlUp}{AltUp}{ShiftUp}
                return
            ;Set FiiO K5 Speaker output/Peace EQ MK5
                K5MK5EQLab:
                Run cmd.exe /c start nircmd.exe setdefaultsounddevice "K5 Pro" 1 ,,Hide
                Run cmd.exe /c start nircmd.exe setdefaultsounddevice "K5 Pro" 2 ,,Hide
                Send, {ShiftDown}{AltDown}{CtrlDown}{Numpad3}{CtrlUp}{AltUp}{ShiftUp}
                return  




  

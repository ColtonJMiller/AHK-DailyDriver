;Kasa light integration https://github.com/python-kasa/python-kasa
;Koolertron 23 key Macroset and keys (see L SHIFT + CTRL + ALT + G for full set)
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
#Include, Functions/Functions.ahk
#Include, Functions/OneTimeHotKeyFunctions.ahk
#Include, Functions/ApplicationPosFunctions.ahk
#Include, Functions/ApplicationLaunchFunctions.ahk

;Global variables
    StringReplace, fixedDocPath, A_MyDocuments, \, /, All]
    ahkHoldPath := fixedDocPath . "/AHKPercentHolds/"
    LineInPID := grabInputPID()
    lampBrightVal := 1
    lampOnOffState := 0
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
        ;Kill current active process/close tab
            killProcessHK:= "<+F14"
            hotkey, %killProcessHK%, killProcessLab  
        ;Test Hot Key
            TestHK := "<^<!<+Q"
            hotkey, %TestHK%, TestLab            
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
    ;HOTKEYS Application open and make active. Cycle tabs
        ;Main Browser Account make active/cycle tabs
            MainBrowserHK := ">^F19"
            hotkey, %MainBrowserHK%, MainBrowserLab
        ;Second Browser Account make active/cycle tabs
            SecondBrowserHK := ">^F20"
            hotkey, %SecondBrowserHK%, SecondBrowserLab
        ;Visual Studio make active/cycle tabs
            VSCodeOpenHK := ">^F21"
            hotkey, %VSCodeOpenHK%, VSCodeOpenLab
        ;TIDAL make active/open
            tidalOpenHK := ">^F22"
            hotkey, %tidalOpenHK%, tidalOpenLab
        ;Pocket Casts make active/open
            PCOpenHK := ">+>^F22"
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
    ;HOTKEYS Volume controls
        ;Mute Channels
            ;Mute Focused volume
                focusVolMuteHK := "<!F13"
                hotkey, %focusVolMuteHK%, focusVolMuteLab
            ;Unmute/Restore Focused volume
                focusVolUnmuteHK := "<!F14"
                hotkey, %focusVolUnmuteHK%, focusVolUnmuteLab
            ;Mute Media volume
                mediaVolMuteHK := "<!F15"
                hotkey, %mediaVolMuteHK%, mediaVolMuteLab
            ;Unmute/Restore Media volume
                mediaVolUnmuteHK := "<!F16"
                hotkey, %mediaVolUnmuteHK%, mediaVolUnmuteLab
            ;Mute Line In volume
                lineVolMuteHK := "<!F17"
                hotkey, %lineVolMuteHK%, lineVolMuteLab
            ;Unmute/Restore Line In volume
                lineVolUnmuteHK := "<!F18"
                hotkey, %lineVolUnmuteHK%, lineVolUnmuteLab
            ;Mute/Unmute System volume 
                sysVolMuteHK := "<!F19"
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
                DOEQHK := "<+>^F19"
                hotkey, %DOEQHK%, DOEQLab   
            ;Set Logitech Pro X output/Peace EQ Pro X
                LPXEQHK := "<+>^F20"
                hotkey, %LPXEQHK%, LPXEQLab   
            ;Set FiiO K5 Speaker output/Peace EQ 770 80ohm
                K5770EQHK := "<+>^F21"
                hotkey, %K5770EQHK%, K5770EQLab  
            ;Set FiiO K5 Speaker output/Peace EQ MK5  
                K5MK5EQHK := "<+>^F22"
                hotkey, %K5MK5EQHK%, K5MK5EQLab 
    ;HOTKEYS Kasa lighting
        ;Main room Light bulb on/off + brightness
            ;Turn off bulb
                lampOffHK := ">!F21"
                hotkey, %lampOffHK%, lampOffLab              
            ;Turn on/brightness 1%
                lamp1HK := ">!F22"
                hotkey, %lamp1HK%, lamp1Lab 
            ;Turn on/brightness down 10%
                lampBrightDownHK := ">!F23"
                hotkey, %lampBrightDownHK%, lampBrightDownLab 
            ;Turn on/brightness up 10%
                lampBrightUpHK := ">!F24"
                hotkey, %lampBrightUpHK%, lampBrightUpLab  
            ;Lamp Gui
                lampGUIHK := "<+<^<!W"
                hotkey, %lampGUIHK%, lampGUILab
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
                OpenSpreadSheet()
                Return
        ;Active window check
            activeCheckLab:
                GetActiveWindowData()
                Return
        ;All active Windows
            allActiveLab:
                GetAllWindows()
                Return
        ;Script reload
            reloadLab: 
                ReloadScript()
                return
        ;Open helper GUI
            helperGUILab:
                HelperGUI()
                Return
        ;Kill current active process/close tab
            killProcessLab:
                KillProcess()
                Return
        ;OSD Test
            TestLab:
                Return
    ;Application min, max, and monitor cycle
        ;Maximize or restore toggle for active window 
            maxToggleLab:
                MaxToggle()
                Return
        ;Move active window to other monitor
            monitorCycleLab:
                CycleMonitor()
                Return
        ;Set Monitor 1 only
            monitor1OnlyLab:
                Monitor1OnlyConfig()       
                Return
        ;Set monitor 2 only
            monitor2OnlyLab:
                Monitor2OnlyConfig()
                Return
        ;Set extended monitor layout
            monitorExtendLab:
                MonitorExtendConfig()
                Return         
    ;Application open and make active. Cycle tabs
        ;Firefox Default Account make active/cycle tabs
            MainBrowserLab:
                MainBrowerLaunchActive()
                Return
        ;Firefox Alt Account make active/cycle tabs
            SecondBrowserLab:
                SecondBrowerLaunchActive()
                Return
        ;Visual Studio make active/cycle tabs
            VSCodeOpenLab:
                VSCodeLaunchActive()
                Return  
        ;TIDAL make active/open
            tidalOpenLab:
                TidalLaunchActive()
                Return
        ;Pocket Casts make active/open
            PCOpenLab:    
                PCLaunchActive()
                Return
        ;VLC Player make active/open
            vlcOpenLab:
                VLCLaunchActive()
                Return               
        ;Photoshop make active/open cycle tabs  
            psOpenLab:
                PSLaunchActive()
                Return
        ;Steam Main make active/open 
            steamOpenMainLab:
                SteamMainLaunchActive()
                Return
        ;Steam Alt make active/open
            steamOpenAltLab:
                SteamAltLaunchActive()
                Return
        ;Koolertron Editor active/open
            koolertronOpenLab:
                KoolertronLaunchActive()
                Return
        ;Volume mixer open/make active
            volMixOpenLab:
                VolMixerLaunchActive()
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
    ;Volume Controls
        ;Mute channels    
            ;Mute Focused volume
                focusVolMuteLab: 
                    SoundViewtxtFile := ahkHoldPath . "FocusedPercent.txt"
                    FocusedAppHoldFile := ahkHoldPath . "FocusedHold.txt"
                    ActiveAHKID := WinExist("A")
                    WinGet, ActivePID, PID, ahk_id %ActiveAHKID%
                    If (FocusMuteHold != 0)
                    {
                        Run cmd.exe /c start nircmd.exe changeappvolume /%ActivePID% -1 ,,Hide
                        return
                    }
                    Runwait, cmd.exe /c SoundVolumeView.exe /stab "" | GetNir "Volume Percent" "ProcessID= %ActivePID%" > %SoundViewtxtFile% ,,Hide 
                    FileReadLine, PercentVal, %SoundViewtxtFile%, 1
                    StringTrimRight, trimmedPercentVal, PercentVal, 1
                    TempFocusMuteHold := trimmedPercentVal /100
                    IfExist, %FocusedAppHoldFile%
                    {
                        Loop, %FocusedAppHoldFile%
                        {
                            If (A_LoopFileSize = 0)
                            {
                                FileAppend, %ActivePID%\%TempFocusMuteHold%`n, %FocusedAppHoldFile% 
                                return  
                            }
                        }
                        Loop, Read, %FocusedAppHoldFile%
                        {
                            StringSplit, HoldArr, A_LoopReadLine, \
                            If (HoldArr1 = ActivePID && TempFocusMuteHold != 0)
                            {
                                MsgBox, HoldArr1 = Active PID && Current volume of Focused app is not 0
                                
                                Run cmd.exe /c start nircmd.exe changeappvolume /%ActivePID% -1 ,,Hide                               
                                return
                            }                            
                            If (HoldArr1 = ActivePID && TempFocusMuteHold = 0)
                            {
                                MsgBox, HoldArr1 = Active PID && Current volume of Focused app is 0
                                ;because current value is already zero do not change the current written value channel is already muted so just return
                                return
                            }
                        }
                        FileAppend, %ActivePID%\%TempFocusMuteHold%`n, %FocusedAppHoldFile% 
                        return
                    }
                    IfNotExist, %FocusedAppHoldFile%
                    {
                        MsgBox,, Notice, Focused App Hold File Not Found. Creating one now. Rerun Mute, 2
                        FileAppend,, %FocusedAppHoldFile%  
                        return                      
                    }
                    ;IfExist, %FocusedAppHoldFile%
                    ;{
                    ;    Loop, %FocusedAppHoldFile%
                    ;    {
                    ;        MsgBox, looping
                    ;        If (A_LoopFileSize = 0)
                    ;        {
                    ;            MsgBox, FileSize = 0
                    ;            FileAppend, %ActivePID%\%TempFocusMuteHold%`n, %FocusedAppHoldFile%                                
                    ;        }
                    ;    }
                    ;    Loop, Read, %FocusedAppHoldFile%
                    ;    {
                    ;        StringSplit, HoldArr, A_LoopReadLine, \
                    ;        WinGetTitle, currTitle, ahk_pid %HoldArr1%
                    ;        If (HoldArr1 = ActivePID)
                    ;        {
                    ;            MsgBox, HoldArr1 = ActivePID
                    ;            return
                    ;        }
                    ;        Else
                    ;        {
                    ;            FileAppend, %ActivePID%\%TempFocusMuteHold%`n, %FocusedAppHoldFile% 
                    ;        }
                    ;    }
                    ;}
                    ;IfNotExist, %FocusedAppHoldFile%
                    ;{
                    ;
                    ;    MsgBox,, Notice, Focused App Hold File Not Found
                    ;    FileAppend,, %FocusedAppHoldFile%
                    ;    Run cmd.exe /c start nircmd.exe changeappvolume /%ActivePID% -1 ,,Hide  
                    ;}           
                    ;FileDelete, %SoundViewtxtFile%  
                    return     
            ;Unmute/Restore Focused volume
                focusVolUnmuteLab:
                    Run cmd.exe /c start nircmd.exe changeappvolume /%ActivePID% +%FocusMuteHold% ,,Hide
                    FocusMuteHold := 0
                    return                  
            ;Mute Media volume
                mediaVolMuteLab:
                    MediaHoldFilePath := ahkHoldPath . "MediaHold.txt"
                    FileDelete, %MediaHoldFilePath%
                    IfWinExist, -Main-
                    {
                    txtFile := ahkHoldPath . "MainFirefoxPercents.txt"
                    WinGet, ActivePID, PID, -Main-
                    Runwait, cmd.exe /c SoundVolumeView.exe /stab "" | GetNir "Volume Percent" "ProcessID= %ActivePID%" > %txtFile% ,,Hide 
                    FileReadLine, PercentVal, %txtFile%, 1
                    StringTrimRight, trimmedPercentVal, PercentVal, 1
                    decimalPercent := trimmedPercentVal /100
                    FileAppend, %ActivePID%\%decimalPercent%`n, %MediaHoldFilePath%
                    Run cmd.exe /c start nircmd.exe changeappvolume /%ActivePID% -1 ,,Hide
                    }
                    IfWinExist, -Hifi-
                    {
                    txtFile := ahkHoldPath . "HifiFirefoxPercents.txt"
                    WinGet, ActivePID, PID, -Hifi-
                    Runwait, cmd.exe /c SoundVolumeView.exe /stab "" | GetNir "Volume Percent" "ProcessID= %ActivePID%" > %txtFile% ,,Hide 
                    FileReadLine, PercentVal, %txtFile%, 1
                    StringTrimRight, trimmedPercentVal, PercentVal, 1
                    decimalPercent := trimmedPercentVal /100
                    FileAppend, %ActivePID%\%decimalPercent%`n, %MediaHoldFilePath% 
                    Run cmd.exe /c start nircmd.exe changeappvolume /%ActivePID% -1 ,,Hide  
                    }
                    IfWinExist, Google Chrome
                    {
                    txtFile := ahkHoldPath . "ChromePercents.txt"
                    WinGet, ActivePID, PID, Google Chrome
                    Runwait, cmd.exe /c SoundVolumeView.exe /stab "" | GetNir "Volume Percent" "ProcessID= %ActivePID%" > %txtFile% ,,Hide 
                    FileReadLine, PercentVal, %txtFile%, 1
                    StringTrimRight, trimmedPercentVal, PercentVal, 1
                    decimalPercent := trimmedPercentVal /100
                    FileAppend, %ActivePID%\%decimalPercent%`n, %MediaHoldFilePath%
                    Run cmd.exe /c start nircmd.exe changeappvolume /%ActivePID% -1 ,,Hide   
                    }
                    IfWinExist, ahk_exe TIDAL.exe
                    {
                    txtFile := ahkHoldPath . "TidalPercents.txt"
                    WinGet, ActivePID, PID, ahk_exe TIDAL.exe
                    Runwait, cmd.exe /c SoundVolumeView.exe /stab "" | GetNir "Volume Percent" "ProcessID= %ActivePID%" > %txtFile% ,,Hide 
                    FileReadLine, PercentVal, %txtFile%, 1
                    StringTrimRight, trimmedPercentVal, PercentVal, 1
                    decimalPercent := trimmedPercentVal /100
                    FileAppend, %ActivePID%\%decimalPercent%`n, %MediaHoldFilePath% 
                    Run cmd.exe /c start nircmd.exe changeappvolume /%ActivePID% -1 ,,Hide  
                    }
                    IfWinExist, ahk_exe Spotify.exe
                    {
                    txtFile := ahkHoldPath . "SpotifyPercents.txt"
                    WinGet, ActivePID, PID, ahk_exe Spotify.exe
                    Runwait, cmd.exe /c SoundVolumeView.exe /stab "" | GetNir "Volume Percent" "ProcessID= %ActivePID%" > %txtFile% ,,Hide 
                    FileReadLine, PercentVal, %txtFile%, 1
                    StringTrimRight, trimmedPercentVal, PercentVal, 1
                    decimalPercent := trimmedPercentVal /100
                    FileAppend, %ActivePID%\%decimalPercent%`n, %MediaHoldFilePath%
                    Run cmd.exe /c start nircmd.exe changeappvolume /%ActivePID% -1 ,,Hide   
                    }
                    IfWinExist, Pocket Casts
                    {
                    txtFile := ahkHoldPath . "PocketCastsPercents.txt"
                    WinGet, ActivePID, PID, Pocket Casts
                    Runwait, cmd.exe /c SoundVolumeView.exe /stab "" | GetNir "Volume Percent" "ProcessID= %ActivePID%" > %txtFile% ,,Hide 
                    FileReadLine, PercentVal, %txtFile%, 1
                    StringTrimRight, trimmedPercentVal, PercentVal, 1
                    decimalPercent := trimmedPercentVal /100
                    FileAppend, %ActivePID%\%decimalPercent%`n, %MediaHoldFilePath%
                    Run cmd.exe /c start nircmd.exe changeappvolume "Pocket Casts.exe" -1 ,,Hide   
                    }
                    IfWinExist, VLC media player
                    {
                    txtFile := ahkHoldPath . "VLCPercents.txt"
                    WinGet, ActivePID, PID, VLC media player
                    Runwait, cmd.exe /c SoundVolumeView.exe /stab "" | GetNir "Volume Percent" "ProcessID= %ActivePID%" > %txtFile% ,,Hide 
                    FileReadLine, PercentVal, %txtFile%, 1
                    StringTrimRight, trimmedPercentVal, PercentVal, 1
                    decimalPercent := trimmedPercentVal /100
                    FileAppend, %ActivePID%\%decimalPercent%`n, %MediaHoldFilePath%
                    Run cmd.exe /c start nircmd.exe changeappvolume /%ActivePID% -1 ,,Hide   
                    } 
                    return    
            ;Unmute/Restore Media volume
                mediaVolUnmuteLab:
                    MediaHoldFilePath := ahkHoldPath . "MediaHold.txt"                
                    Loop, Read, %MediaHoldFilePath%
                    {
                        StringSplit, HoldArr, A_LoopReadLine, \
                        WinGetTitle, currTitle, ahk_pid %HoldArr1%
                        If (currTitle = "Pocket Casts Desktop")
                        {
                            Run cmd.exe /c start nircmd.exe changeappvolume "Pocket Casts.exe" +%HoldArr2% ,,Hide  
                        }
                        Else
                        {
                            Run cmd.exe /c start nircmd.exe changeappvolume /%HoldArr1% +%HoldArr2% ,,Hide 
                        }
                    }
                    return
            ;Mute Line In volume
                lineVolMuteLab:
                    txtFile := ahkHoldPath . "LineInPercent.txt"
                    Runwait, cmd.exe /c SoundVolumeView.exe /stab "" | GetNir "Volume Percent" "ProcessID= %LineInPID%" > %txtFile% ,,Hide 
                    FileReadLine, PercentVal, %txtFile%, 1
                    StringTrimRight, trimmedPercentVal, PercentVal, 1
                    lineInMuteHold := trimmedPercentVal /100
                    Run cmd.exe /c start nircmd.exe changeappvolume /%LineInPID% -1 ,,Hide                   
                    return     
            ;Unmute/Restore Line In volume
                lineVolUnmuteLab:
                    Run cmd.exe /c start nircmd.exe changeappvolume /%LineInPID% +%lineInMuteHold% ,,Hide 
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
                    LineInTrimmed := Round(LineInTrimmed - 2)
                    If (LineInTrimmed <= 0)
                    {
                        LineInTrimmed := 0
                    }
                    OSDGui("Line In","Volume",LineInTrimmed)
                    Return
            ;Line in volume control up 2% 
                lineVolUp1Lab: 
                    SoundGet, currVol
                    percentCurrVol := currVol / 100
                    percentRecalc := 0.02 / percentCurrVol
                    Run cmd.exe /c start nircmd.exe changeappvolume /%LineInPID% +%percentRecalc% ,,Hide
                    LineInTrimmed := Round(LineInTrimmed + 2)
                    SoundGet, currSysVol
                    If (LineInTrimmed >= currSysVol)
                    {
                        LineInTrimmed := round(currSysVol)
                    }
                    OSDGui("Line In","Volume",LineInTrimmed)
                    Return
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
    ;Kasa lighting
        ;Main room Light bulb on/off + brightness
            ;Turn off bulb
                lampOffLab:
                Runwait cmd.exe /c kasa --host 192.168.1.180 --bulb off ,,Hide 
                MsgBox,, Lamp Notice, Turning lamp off, 1
                lampOnOffState :=0
                return
            ;Turn on/brightness 1%
                lamp1Lab:
                Runwait cmd.exe /c kasa --host 192.168.1.180 --bulb brightness 1 ,,Hide
                lampBrightVal := 1
                lampOnOffState :=1
                MsgBox,, Lamp Notice, Setting lamp to 1 percent brightness, 1            
                return
            ;Turn on @ 10% or Brightness down 10%
                lampBrightDownLab:
                If (lampOnOffState = 0)
                {
                    lampOnOffState := 1
                    lampBrightVal := 10
                    Runwait cmd.exe /c kasa --host 192.168.1.180 --bulb brightness 10 ,,Hide  
                    MsgBox,, Lamp Notice, Setting lamp brightness to 10 , 1                    
                    return                  
                }
                If (lampOnOffState = 1)
                {
                    lampBrightVal := lampBrightVal - 10
                    If (lampBrightVal <= 1)
                    {
                        lampBrightVal := 1
                        Runwait cmd.exe /c kasa --host 192.168.1.180 --bulb brightness %lampBrightVal% ,,Hide
                        MsgBox,, Lamp Notice, lamp brightness bottomed out , 1
                        return 
                    }
                    Runwait cmd.exe /c kasa --host 192.168.1.180 --bulb brightness %lampBrightVal% ,,Hide
                    MsgBox,, Lamp Notice, Decreasing lamp brightness to %lampBrightVal% , 1 
                    return
                }
                return
            ;Turn on @ 30% or Brightness up 10%
                lampBrightUpLab:
                If (lampOnOffState = 0)
                {
                    lampOnOffState := 1
                    lampBrightVal := 30
                    Runwait cmd.exe /c kasa --host 192.168.1.180 --bulb brightness 30 ,,Hide  
                    MsgBox,, Lamp Notice, Setting lamp brightness to 30 , 1                    
                    return                  
                }
                If (lampOnOffState = 1)
                {
                    lampBrightVal := lampBrightVal + 10
                    If (lampBrightVal >= 100)
                    {
                        lampBrightVal := 100
                        Runwait cmd.exe /c kasa --host 192.168.1.180 --bulb brightness %lampBrightVal% ,,Hide
                        MsgBox,, Lamp Notice, lamp brightness maxed out , 1
                        return 
                    }
                    Runwait cmd.exe /c kasa --host 192.168.1.180 --bulb brightness %lampBrightVal% ,,Hide
                    MsgBox,, Lamp Notice, Increasing lamp brightness to %lampBrightVal% , 1 
                    return
                }
                return
            ;Lamp Gui
                lampGUILab:
                lampGuiStatePath := ahkHoldPath . "LampState.txt"
                Runwait, LampGUI.ahk
                Runwait cmd.exe /c kasa --host 192.168.1.180 --bulb > %lampGuiStatePath% ,,Hide
                FileReadLine, pStateFullLine, %lampGuiStatePath%, 21
                StringTrimLeft, pStateNoLeft, pStateFullLine, 13
                StringTrimRight, pStateVal, pStateNoLeft, 32
                If (pStateVal = 0)
                {
                    lampOnOffState := 0
                }
                If (pStateVal > 0)
                {
                    lampOnOffState := 1
                }
                return
    ;Gui Destroy
            Esc::
                IfWinActive, ahk_class AutoHotkeyGUI
                {
                    WinClose, A
                    Return
                }

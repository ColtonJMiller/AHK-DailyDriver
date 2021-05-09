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
#Include, Functions/OneTimeHotKeyFunctions.ahk
#Include, Functions/ApplicationPosFunctions.ahk
#Include, Functions/ApplicationLaunchFunctions.ahk
#Include, Functions/VolumeControlFunctions.ahk
#Include, Functions/SoundOutputEqFunctions.ahk
#Include, Functions/LampFunctions.ahk

reloadBrightness := GetLampBrightness()
;Global variables
    StringReplace, fixedDocPath, A_MyDocuments, \, /, All]
    ahkHoldPath := fixedDocPath . "/AHKPercentHolds/"
    LineInPID := grabInputPID()
    lampBrightVal := 1
    lampOnOffState := GetLampState()
    MsgBox,, Notice, Script load complete, 1
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
            allActiveHK := ">+F22"
            hotkey, %allActiveHK%, allActiveLab
        ;Script reload
            reloadHK := ">+F23"
            hotkey, %reloadHK%, reloadLab
        ;Open helper GUI
            helperGUIHK := "<+<^<!G"
            hotkey, %helperGUIHK%, helperGUILab
        ;Active window check 
            activeCheckHK := ">+F24"
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
            monitor1OnlyHK := ">+>^F22"
            hotkey, %monitor1OnlyHK%, monitor1OnlyLab
        ;Move active window to other monitor    
            monitor2OnlyHK := ">+>^F23"
            hotkey, %monitor2OnlyHK%, monitor2OnlyLab
        ;Move active window to other monitor    
            monitorExtendHK := ">+>^F24"
            hotkey, %monitorExtendHK%, monitorExtendLab
        ;Reset Active Window size    
            activeSizeResetHK := "<+F16"
            hotkey, %activeSizeResetHK%, activeSizeResetLab
    ;HOTKEYS Application open and make active. Cycle tabs
        ;Main Browser Account make active/cycle tabs
            MainBrowserHK := ">^F19"
            hotkey, %MainBrowserHK%, MainBrowserLab
        ;Second Browser Account make active/cycle tabs
            SecondBrowserHK := ">^F20"
            hotkey, %SecondBrowserHK%, SecondBrowserLab
        ;Chrome Work profile open/make active
            ChromeWorkHK := ">!>^F24"
            hotkey, %ChromeWorkHK%, ChromeWorkLab 
        ;Visual Studio make active/cycle tabs
            VSCodeOpenHK := ">+>^F19"
            hotkey, %VSCodeOpenHK%, VSCodeOpenLab
        ;TIDAL make active/open
            tidalOpenHK := ">^F23"
            hotkey, %tidalOpenHK%, tidalOpenLab
        ;Pocket Casts make active/open
            PCOpenHK := "F21"
            hotkey, %PCOpenHK%, PCOpenLab
        ;VLC Player make ative/open
            vlcOpenHK := ">^F24"
            hotkey, %vlcOpenHK%, vlcOpenLab        
        ;Photoshop make active/open cycle tabs
            psOpenHK := ">+>^F20"
            hotkey, %psOpenHK%, psOpenLab
        ;Steam Gui Launch
            steamGuiHK := "F23"
            hotkey, %steamGuiHK%, steamGuiLab
        ;Koolertron Editor active/open
            koolertronOpenHK := ">+>^F20"
            hotkey, %koolertronOpenHK%, koolertronOpenLab
        ;Volume mixer open/make active
            volMixOpenHK := ">+F21"
            hotkey, %volMixOpenHK%, volMixOpenLab  
        ;Twitch app open/make active
            TwitchOpenHK := ">^F21"
            hotkey, %TwitchOpenHK%, TwitchOpenLab
        ;Youtube Hifi open/make active
            YoutubeHifiHK := ">^F22"
            Hotkey, %YoutubeHifiHK%, YoutubeHifiLab 
        ;Appdata open
            AppdataOpenHK := ">!>^F23"
            Hotkey, %AppdataOpenHK%, AppdataOpenLab
    ;HOTKEYS Volume controls
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
            ;main system volume down 4%
                mainSysVolDown4HK := ">+F19"
                hotkey, %mainSysVolDown4HK%, mainSysVolDown4Lab
            ;main system volume up 4%
                mainSysVolUp4HK := ">+F20"
                hotkey, %mainSysVolUp4HK%, mainSysVolUp4Lab
            ;main system volume down 10%
                mainSysVolDown10HK := ">!F19"
                hotkey, %mainSysVolDown10HK%, mainSysVolDown10Lab        
            ;main system volume up 10% 
                mainSysVolUp10HK := ">!F20"
                hotkey, %mainSysVolUp10HK%, mainSysVolUp10Lab   
    ;HOTKEYS EQ and Sound Output
        ;Switch output with EQ change
            ;Set BTA30 Digital output/Peace EQ XM4
                DOEQHK := ">!>^F19"
                hotkey, %DOEQHK%, DOEQLab   
            ;Set Logitech Pro X output/Peace EQ Pro X
                LPXEQHK := ">!>^F20"
                hotkey, %LPXEQHK%, LPXEQLab   
            ;Set FiiO K5 Speaker output/Peace EQ 770 80ohm
                K5770EQHK := ">!>^F21"
                hotkey, %K5770EQHK%, K5770EQLab  
            ;Set FiiO K5 Speaker output/Peace EQ MK5  
                K5MK5EQHK := ">!>^F22"
                hotkey, %K5MK5EQHK%, K5MK5EQLab 
    ;HOTKEYS Kasa lighting
        ;Main room Light bulb on/off + brightness
            ;Turn off bulb
                lampOffHK := "<+>^F19"
                hotkey, %lampOffHK%, lampOffLab              
            ;Turn on/brightness 1%
                lamp1HK := "<+>^F20"
                hotkey, %lamp1HK%, lamp1Lab 
            ;Turn on/brightness down 10%
                lampBrightDownHK := "<+>^F21"
                hotkey, %lampBrightDownHK%, lampBrightDownLab 
            ;Turn on/brightness up 10%
                lampBrightUpHK := "<+>^F22"
                hotkey, %lampBrightUpHK%, lampBrightUpLab  
            ;Lamp Gui
                lampGUIHK := "<+>^F23"
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
                Run HelperGui.ahk
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
        ;Reset Active Window size
            activeSizeResetLab:
                ActiveSizeReset()
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
        ;Chrome Work profile open/make active
            ChromeWorkLab:    
                ChromeWorkLaunchActive()
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
        ;Steam Gui Launch
            steamGuiLab:
                SteamGui()
                Return
        ;Koolertron Editor active/open
            koolertronOpenLab:
                KoolertronLaunchActive()
                Return
        ;Volume mixer open/make active
            volMixOpenLab:
                VolMixerLaunchActive()
                Return
        ;Twitch app open/make active
            TwitchOpenLab:
                TwitchLaunchActive()
                Return
        ;Youtube Hifi open/make active
            YoutubeHifiLab:
                YouTubeHifiLaunch()
                Return 
        ;Open AppData folder
            AppdataOpenLab:
                AppDataLaunch()
                Return
    ;Volume Controls
        ;focused application volumes
            ;focused application volume down 2%
                focusVolDown2Lab:
                    focusVol(2,"-")
                    Return
            ;focused application volume up 2%        
                focusVolUp2Lab:
                    focusVol(2,"+")
                    Return
            ;focused application volume down 5%
                focusVolDown5Lab:
                    focusVol(5,"-")
                    Return
            ;focused application volume up 5%
                focusVolUp5Lab:
                    focusVol(5,"+")
                    Return
            ;focused application volume down 10%
                focusVolDown10Lab:
                    focusVol(10,"-")
                    Return
            ;focused application volume up 10%
                focusVolUp10Lab:
                    focusVol(10,"+")
                    Return
        ;Media volumes
            ;Media volume control down 2%
                mediaVolDown2Lab:
                    MediaVol(2,"-")
                    Return
            ;Media volume control (firefox,chrome,tidal,and spotify) up 2%
                mediaVolUp2Lab:
                    MediaVol(2,"+")
                    Return
            ;Media volume control (firefox,chrome,tidal,and spotify) down 5%
                mediaVolDown5Lab:
                    MediaVol(5,"-")
                    Return
            ;Media volume control (firefox,chrome,tidal,and spotify) up 5%
                mediaVolUp5Lab:
                    MediaVol(5,"+")
                    Return
            ;Media volume control (firefox,chrome,tidal,and spotify) down 10%
                mediaVolDown10Lab:
                    MediaVol(10,"-")
                    Return
            ;Media volume control (firefox,chrome,tidal,and spotify) up 10%
                mediaVolUp10Lab:
                    MediaVol(10,"+")
                    Return
        ;Line in volumes
            ;Line in volume control down 2%
                lineVolDown1Lab:
                    LineInVol(LineInPID,2,"-")
                    Return            
            ;Line in volume control up 2% 
                lineVolUp1Lab: 
                    LineInVol(LineInPID,2,"+")
                    Return       
            ;Line in volume control down 5%
                lineVolDown5Lab:  
                    LineInVol(LineInPID,5,"-")
                    Return       
            ;Line in volume control up 5%  
                lineVolUp5Lab: 
                    LineInVol(LineInPID,5,"+")
                    Return       
            ;Line in volume control down 10%
                lineVolDown10Lab:  
                    LineInVol(LineInPID,10,"-")
                    Return     
            ;Line in volume control up 10%  
                lineVolUp10Lab:  
                    LineInVol(LineInPID,10,"+")
                    Return    
        ;main system volumes
            ;main system volume down 2%
                mainSysVolDown2Lab:
                    MainSysVol(-2)
                    Return
            ;main system volume up 2%
                mainSysVolUp2Lab:
                    MainSysVol(2)
                    Return    
            ;main system volume down 4%
                mainSysVolDown4Lab:
                    MainSysVol(-4)
                    Return
            ;main system volume up 4%
                mainSysVolUp4Lab:
                    MainSysVol(4)
                    Return
            ;main system volume down 10%
                mainSysVolDown10Lab:
                    MainSysVol(-10)
                    Return
            ;main system volume up 10%
                mainSysVolUp10Lab:
                    MainSysVol(10)
                    Return
    ;EQ and Sound Output
        ;Switch output with EQ change
            ;Set BTA30 Digital output/Peace EQ XM4
                DOEQLab:
                    SwitchBTA30(1, "BTA 30", "Sony WH-1000XM4")
                    Sleep, 1000
                    Return
            ;Set Logitech Pro X output/Peace EQ Pro X
                LPXEQLab:
                    SwitchProX(2, "Logitech Pro X", "Pro X") 
                    Sleep, 1000
                    Return
            ;Set FiiO K5 Speaker output/Peace EQ 770 80ohm
                K5770EQLab:
                    SwitchK5Pro(3,"Fiio K5 Pro","Beyerdynamic DT770 80 ohm")
                    Sleep, 1000
                    Return
            ;Set FiiO K5 Speaker output/Peace EQ MK5
                K5MK5EQLab: 
                    SwitchK5Pro(4,"Fiio K5 Pro","Etymotic Research MK5")
                    Sleep, 1000
                    Return
    ;Kasa lighting
        ;Main room Light bulb on/off + brightness
            ;Turn off bulb
                lampOffLab:
                    LampOff()
                    lampOnOffState :=0
                    return
            ;Turn on/brightness 1%
                lamp1Lab:
                    lampBrightVal := LampBrightness(1,lampOnOffState)
                    lampOnOffState := 1            
                    return
            ;Turn on @ 10% or Brightness down 10%
                lampBrightDownLab:
                If (lampOnOffState = 0)
                {
                    lampBrightVal := LampBrightness(10,lampOnOffState)
                    lampOnOffState := 1
                    Return
                }
                If (lampOnOffState = 1)
                {
                    lampBrightVal := LampBrightness(-10,lampOnOffState)
                    Return
                }
                return
            ;Turn on @ 30% or Brightness up 10%
                lampBrightUpLab:
                If (lampOnOffState = 0)
                {
                    lampBrightVal := LampBrightness(30,lampOnOffState)
                    lampOnOffState := 1
                    Return
                }
                If (lampOnOffState = 1)
                {
                    lampBrightVal := LampBrightness(10,lampOnOffState)
                    Return
                }
                return
            ;Lamp Gui
                lampGUILab:
                    SetLampGui()
                    return
    ;Gui Destroy
            Esc::
                IfWinActive, ahk_class AutoHotkeyGUI
                {
                    WinClose, A
                    Return
                }

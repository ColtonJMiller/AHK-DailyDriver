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
; DetectHiddenWindows, on
;Run Script as admin
RunAsAdmin()
;SetNumLockState, AlwaysOn
reloadBrightness := GetLampBrightness()
;Global variables
    ;Row 4 Modifiers
        r4c1 := "NumpadMult" 
        r4c2 := "NumpadDot" 
        r4c3 := "NumpadSub"
        r4c4 := "NumpadAdd"
        r4c5 := "Numpad0"   
    StringReplace, fixedDocPath, A_MyDocuments, \, /, All]
    ahkHoldPath := fixedDocPath . "/AHKPercentHolds/"
    LineInPID := grabInputPID()
    ; MsgBox, %LineInPID%
    ; WinGet, LineInArr, ID, ahk_pid %LineInPID%
    ; MsgBox, %LineInArr%
    ; Loop,%LineInArr%
    ; {
    ;     MsgBox, %A_Index%   
    ; }
    lampBrightVal := 1
    lampOnOffState := GetLampState()
    MsgBox,, Notice, Script load complete, 1  
   
;Main code
    ;Modifier Remaps
        NumpadMult::
            Return
        NumpadDot::
            Return 
        NumpadSub::
            Return
        NumpadAdd::
            Return
        Numpad0::  
            Return 
    ;No Modifer Hotkeys
        #If
        ;MacroPad
            ;Row 1 
                ;Focus volume up 2%   
                F14::
                    focusVol(2,"+")
                    Return
                ;Media volume up 2%  
                F16::
                    MediaVol(2,"+")
                    Return
                ;Line in volume up 2%  
                F18::
                    LineInVol(LineInPID,2,"+")
                    Return 
                ;System volume up 2%  
                F20::
                    MainSysVol(2)
                    Return
                ;Maximize Window Toggle
                F22::
                    MaxToggle()
                    Return
                ;Active Window Monitor Switch
                F24::
                    CycleMonitor()
                    Return
            ;Row 2
                ;Focus volume down 2% 
                F13::
                    focusVol(2,"-")
                    Return
                ;Media volume down 2% 
                F15::
                    MediaVol(2,"-")
                    Return
                ;Line In volume down 2% 
                F17::
                    LineInVol(LineInPID,2,"-")
                    Return
                ;System volume down 2%    
                F19::
                    MainSysVol(-2)
                    Return
                ;Open Pocket Casts
                F21::
                    PCLaunchActive()
                    Return
                ;Open Steam GUI
                F23::
                    SteamGui()
                    Return
            ;Row 3
                ;Launch/ Make Active Main Browser
                NumpadDiv & Numpad1::
                    MainBrowerLaunchActive()
                    Return
                ;Launch/ Make Active Secondary Browser
                NumpadDiv & Numpad2::
                    SecondBrowerLaunchActive()
                    Return
                ;Launch/ Make Active Twitch on Secondary Browser
                NumpadDiv & Numpad3::
                    TwitchLaunchActive()
                    Return
                ;Launch/ Make Active Youtube on Secondary Browser
                NumpadDiv & Numpad4::
                    YouTubeHifiLaunch()
                    Return 
                ;Launch/ Make Active Tidal
                NumpadDiv & Numpad5::
                    TidalLaunchActive()
                    Return
                ;Launch/ Make Active VLC
                NumpadDiv & Numpad6::
                    VLCLaunchActive()
                    Return  
        ;Keyboard
            ;Launch/Make Active Helper Gui
            <+<^<!G::
                Run HelperGui.ahk
                Return 
    ;R4C1 Hotkeys
        #If GetKeyState(r4c1,"p")
        ;MacroPad
            ;Row 1 
                ;Kill Active Window   
                F14::
                    KillProcess()
                    Return
                ;Reset Active Window Size
                F16::
                    ActiveSizeReset()
                    Return  
                F18::
                    Return
                F20::
                    Return
                F22::
                    Return
                F24::
                    Return
            ;Row 2
                ;Media Previous
                F13::
                    Send {Media_Prev}
                    return  
                ;Media Play/Pause
                F15::
                    Send {Media_Play_Pause}
                    return
                ;Media Next
                F17::
                    Send {Media_Next}
                    return
                F19::
                    Return
                F21::
                    Return
                F23::
                    Return
            ;Row 3
                ;Turn Lamp Off
                NumpadDiv & Numpad1::
                    LampOff()
                    lampOnOffState :=0
                    Return
                ;Set Lamp to 1%
                NumpadDiv & Numpad2::
                    lampBrightVal := LampBrightness(1,lampOnOffState)
                    lampOnOffState := 1            
                    Return
                ;Turn on lamp @ 10%/Brightness down 10%
                NumpadDiv & Numpad3::
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
                    Return
                ;Turn on lamp @ 30%/Brightness down 10%
                NumpadDiv & Numpad4::
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
                    Return
                ;Open Lamp GUI
                NumpadDiv & Numpad5::
                    SetLampGui()
                    Return
                NumpadDiv & Numpad6::
                    Return
    ;R4C2 Hotkeys
        #If GetKeyState(r4c2,"p")
        ;MacroPad
            ;Row 1    
                F14::
                    Return
                F16::
                    Return
                F18::
                    Return
                F20::
                    Return
                F22::
                    Return
                F24::
                    Return
            ;Row 2
                F13::
                    Return
                F15::
                    Return
                F17::
                    Return
                F19::
                    Return
                F21::
                    Return
                F23::
                    Return
            ;Row 3
                NumpadDiv & Numpad1::
                    return
                NumpadDiv & Numpad2::
                    Return
                NumpadDiv & Numpad3::
                    Return
                NumpadDiv & Numpad4::
                    Return
                NumpadDiv & Numpad5::
                    Return
                NumpadDiv & Numpad6::
                    Return
    ;R4C3 Hotkeys
        #If GetKeyState(r4c3,"p")
        ;MacroPad
            ;Row 1    
                F14::
                    Return
                F16::
                    Return
                F18::
                    Return
                F20::
                    Return
                F22::
                    Return
                F24::
                    Return
            ;Row 2
                F13::
                    Return
                F15::
                    Return
                F17::
                    Return
                F19::
                    Return
                F21::
                    Return
                F23::
                    Return
            ;Row 3
                NumpadDiv & Numpad1::
                    return
                NumpadDiv & Numpad2::
                    Return
                NumpadDiv & Numpad3::
                    Return
                NumpadDiv & Numpad4::
                    Return
                NumpadDiv & Numpad5::
                    Return
                NumpadDiv & Numpad6::
                    Return
    ;R4C4 Hotkeys
        #If GetKeyState(r4c4,"p")
        ;MacroPad
            ;Row 1    
                ;Focus volume up 10%   
                F14::
                    focusVol(10,"+")
                    Return
                ;Media volume up 10%  
                F16::
                    MediaVol(10,"+")
                    Return
                ;Line in volume up 10%  
                F18::
                    LineInVol(LineInPID,10,"+")
                    Return 
                ;System volume up 10%  
                F20::
                    MainSysVol(10)
                    Return
                F22::
                    Return
                F24::
                    Return
            ;Row 2
                ;Focus volume down 10% 
                F13::
                    focusVol(10,"-")
                    Return
                ;Media volume down 10% 
                F15::
                    MediaVol(10,"-")
                    Return
                ;Line In volume down 10% 
                F17::
                    LineInVol(LineInPID,10,"-")
                    Return
                ;System volume down 10%    
                F19::
                    MainSysVol(-10)
                    Return
                F21::
                    Return
                F23::
                    Return
            ;Row 3
                ;Set BTA30 Digital output/Peace EQ XM4
                NumpadDiv & Numpad1::
                    SwitchBTA30(1, "BTA 30", "Sony WH-1000XM4")
                    Return
                ;Set Logitech Pro X output/Peace EQ Pro X
                NumpadDiv & Numpad2::
                    SwitchProX(2, "Logitech Pro X", "Pro X") 
                    Return
                ;Set FiiO K5 Speaker output/Peace EQ 770 80ohm
                NumpadDiv & Numpad3::
                    SwitchK5Pro(3,"Fiio K5 Pro","Beyerdynamic DT770 80 ohm")
                    Return
                ;Set FiiO K5 Speaker output/Peace EQ MK5
                NumpadDiv & Numpad4::
                    SwitchK5Pro(4,"Fiio K5 Pro","Etymotic Research MK5")
                    Return
                ;Open Appdata Folder in File explorer
                NumpadDiv & Numpad5::
                    AppDataLaunch()
                    Return
                ;Launch/ Make active Chrome Work
                NumpadDiv & Numpad6::
                    ChromeWorkLaunchActive()
                    Return
    ;R4C5 Hotkeys
        #If GetKeyState(r4c5,"p")
        ;MacroPad
            ;Row 1    
                ;Focus volume up 5%   
                F14::
                    focusVol(5,"+")
                    Return
                ;Media volume up 5%  
                F16::
                    MediaVol(5,"+")
                    Return
                ;Line in volume up 5%  
                F18::
                    LineInVol(LineInPID,5,"+")
                    Return 
                ;System volume up 6%  
                F20::
                    MainSysVol(6)
                    Return
                ;All Active Windows GUI
                F22::
                    GetAllWindows()
                    Return
                ;Active Window Info Msg Box
                F24::
                    GetActiveWindowData()
                    Return
            ;Row 2
                ;Focus volume down 5% 
                F13::
                    focusVol(5,"-")
                    Return
                ;Media volume down 5% 
                F15::
                    MediaVol(5,"-")
                    Return
                ;Line In volume down 5% 
                F17::
                    LineInVol(LineInPID,5,"-")
                    Return
                ;System volume down 6%    
                F19::
                    MainSysVol(-6)
                    Return
                ;Launch/ Make Active Volume Mixer
                F21::
                    VolMixerLaunchActive()
                    Return
                ;Reload Script
                F23::
                    ReloadScript()
                    return
            ;Row 3
                ;Launch/Make Active VS Code
                NumpadDiv & Numpad1::
                    VSCodeLaunchActive()
                    Return  
                ;Launch/Make Active Photoshop
                NumpadDiv & Numpad2::
                    PSLaunchActive()
                    Return
                ;Launch/Make Active Koolertron Config
                NumpadDiv & Numpad3::
                    KoolertronLaunchActive()
                    Return
                ;Monitor 1 only desktop config
                NumpadDiv & Numpad4::
                    Monitor1OnlyConfig()       
                    Return
                ;Monitor 2 only desktop config
                NumpadDiv & Numpad5::
                    Monitor2OnlyConfig()
                    Return
                ;Extended monitor desktop config
                NumpadDiv & Numpad6::
                    MonitorExtendConfig()
                    Return  
    ;Gui Handling
        #If WinActive("ahk_class AutoHotkeyGUI")
        Esc::
            WinClose, A
            Return

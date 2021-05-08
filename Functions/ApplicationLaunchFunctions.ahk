;Main Browser/Account open or make active
    MainBrowerLaunchActive()
    {
        exePath := "C:\Program Files\Firefox Nightly\firefox.exe"
        titleTag := "-Main-" 
        appClass := "MozillaWindowClass"
        profileName := "default"
        IfWinExist, %titleTag% ahk_class %appClass%
        {
            IfWinActive, %titleTag% ahk_class %appClass%
            {
                Send, {Ctrl Down}{PgDn}{Ctrl Up} 
                return                  
            }
            IfWinNotActive, %titleTag% ahk_class %appClass%
            {
                WinActivate, %titleTag% ahk_class %appClass%
                Return
            }
            Return
        }
        IfWinNotExist, %titleTag% ahk_class %appClass%
        {
            Run, %exePath% -p %profileName% -new-tab about:home,,,runPID
            WinActivate, ahk_pid runPID 
            Sleep, 1500
            Return
        } 
        Return
    }  
;Second Browser/Account open or make active
    SecondBrowerLaunchActive()
    {
        exePath := "C:\Users\" . A_UserName . "\AppData\Local\Vivaldi\Application\vivaldi.exe"
        titleTag := "Vivaldi" 
        appClass := "Chrome_WidgetWin_1"
        profileName := "Default"
        IfWinExist, %titleTag% ahk_class %appClass%
        {
            IfWinActive, %titleTag% ahk_class %appClass%
            {
                Send, {Ctrl Down}{PgDn}{Ctrl Up} 
                return                  
            }
            IfWinNotActive, %titleTag% ahk_class %appClass%
            {
                WinActivate, %titleTag% ahk_class %appClass%
                Return
            }
            Return
        }
        IfWinNotExist, %titleTag% ahk_class %appClass%
        {
            Run, %exePath% --profile-directory=%profileName%
            WinWait, %titleTag% ahk_class %appClass%
            WinActivate, %titleTag% ahk_class %appClass% 
            Sleep, 1500
            Return
        } 
        Return
    }       
;VS Code open or make active
    VSCodeLaunchActive()
    {
        exePath := "C:\Users\" . A_UserName . "\AppData\Local\Programs\Microsoft VS Code\Code.exe"
        titleTag := "Visual Studio Code"
        appClass := "Chrome_WidgetWin_1"
        IfWinExist, %titleTag% ahk_class %appClass%
        {       
            IfWinActive, %titleTag% ahk_class %appClass%
            {
                Send, {Ctrl Down}{PgDn}{Ctrl Up} 
                return                  
            }
            Else 
            {
                WinActivate, %titleTag% ahk_class %appClass%
                Return
            }
            Return
        }
        IfWinNotExist, %titleTag% ahk_class %appClass%
        {
            RunWait, %exePath%,,,runPID
            WinActivate, %titleTag% ahk_class %appClass%
            Sleep, 500
            Return
        } 
        Return   
    }    
;TIDAL open or make active. Play song on already active
    TidalLaunchActive()
    {
        exePath := "C:\Users\" . A_UserName . "\AppData\Local\TIDAL\app-2.27.6\TIDAL.exe"
        titleTag := "TIDAL"
        appClass := "Chrome_WidgetWin_1"
        IfWinExist, ahk_exe %exePath%
        {
            IfWinActive, ahk_exe %exePath%
            {
                Send, {Space} 
                return                  
            }
            IfWinNotActive, ahk_exe %exePath%
            {  
                WinActivate,  ahk_exe %exePath%
                Return
            }
            Return
        }
        IfWinNotExist, %titleTag% ahk_class %appClass%
        {   
            RunWait, "C:\Users\" . A_UserName . "\AppData\Local\TIDAL\TIDAL.exe",,,runPID
            WinActivate, ahk_pid runPID 
            Sleep, 1000
            Return
        } 
        Return
    }
;Pocket Casts open or make active
    PCLaunchActive()
    {
        exePath := "C:\Users\Colton\Documents\WindowsAppLink\Pocket Casts Desktop"
        titleTag := "Pocket Casts Desktop"
        appClass := "ApplicationFrameWindow"
        IfWinExist, %titleTag% ahk_class %appClass%
        {       
            IfWinActive, %titleTag% ahk_class %appClass%
            {
                Send, {Space}
                return                  
            }
            Else 
            {
                WinActivate,  %titleTag% ahk_class %appClass%
                Return
            }
            Return
        }
        IfWinNotExist, %titleTag% ahk_class %appClass%
        {
            RunWait, %exePath%,,,runPID
            WinActivate, ahk_pid runPID 
            Sleep, 500
            Return
        } 
        Return   
    } 
;VLC Player open or make active
    VLCLaunchActive()
    {
        exePath := "C:\Program Files\VideoLAN\VLC\vlc.exe"
        titleTag := "VLC"
        appClass := "Qt5QWindowIcon"
        selectPath := "C:\Users\" . A_UserName . "\Videos"
        IfWinExist, ahk_class %appClass%
        {
            IfWinActive, ahk_class %appClass% 
            {
                vlcID := WinExist("A")
                FileSelectFile, selectedFile,, %selectPath%
                If !(selectedFile)
                {
                    Return
                }
                Run, %ComSpec% /k cd C:\Program Files\VideoLAN\VLC && %ComSpec% /k vlc "%selectedFile%",,Hide
                WinClose, ahk_id %vlcID%
                return
            }
            IfWinNotActive, ahk_class %appClass% 
            {
                WinActivate,  ahk_class %appClass%
                Return  
            }
        }
        IfWinNotExist, %titleTag% ahk_class %appClass%
        {
            Run, %exePath%,,,runPID
            WinWait, ahk_pid %runPID%
            WinActivate, ahk_pid %runPID%          
            return
        } 
        Return
    }
;Photoshop open or make active
    PSLaunchActive()
    {
        exePath := "C:\Program Files\Adobe\Adobe Photoshop 2020\photoshop.exe"
        appClass := "Photoshop"
        IfWinExist, ahk_exe %exePath%
        {
            IfWinActive, ahk_exe %exePath%
            {
                ;Added more functionality here
                Return
            }
            IfWinNotActive, ahk_exe %exePath%
            {
                WinActivate, ahk_exe %exePath%
                Return 
            }
        }
        IfWinNotExist, ahk_exe photoshop.exe
        {
            Run, "C:\Program Files\Adobe\Adobe Photoshop 2020\photoshop.exe" ,,Hide
            MsgBox,,Notice,Photoshop is Starting,1
            Return
        }
        Return
    } 
;Steam Main account open or make active
    SteamMainLaunchActive()
    {
        titleTag := "Steam"
        appClass := "vguiPopupWindow"
        batPath := A_MyDocuments . "\SteamMain.bat"
        IfWinExist, %titleTag% ahk_class %appClass%
        {
            IfWinActive, %titleTag% ahk_class %appClass%
            {
                Return
            }
            IfWinNotActive, %titleTag% ahk_class %appClass%
            {
                WinActivate, %titleTag% ahk_class %appClass%
                Return
            }
        }
        IfWinNotExist, %titleTag% ahk_class %appClass%
        {
            MsgBox,,, Starting Main Steam, 1
            Process, close, steam.exe
            ;location of .bat must be changed
            Run, %batPath% ,,Hide
        }
        return
    }
;Steam Alt account open or make active
    SteamAltLaunchActive()
    {
        titleTag := "Steam"
        appClass := "vguiPopupWindow"
        batPath := A_MyDocuments . "\SteamPBX.bat"
        IfWinExist, %titleTag% ahk_class %appClass%
        {
            IfWinActive, %titleTag% ahk_class %appClass%
            {
                Return
            }
            IfWinNotActive, %titleTag% ahk_class %appClass%
            {
                WinActivate, %titleTag% ahk_class %appClass%
                Return
            }
        }
        IfWinNotExist, %titleTag% ahk_class %appClass%
        {
            MsgBox,,, Starting Alt Steam, 1
            Process, close, steam.exe
            ;location of .bat must be changed
            Run, %batPath% ,,Hide
        }
        return
    }
;Koolertron Software open or make active 
    KoolertronLaunchActive()
    {
        exePath := A_MyDocuments . "\amag\amag\AMAG_EN\AMAG.exe"
        titleTag := "AMAKeyboardClient"
        appClass := "ApolloRuntimeContentWindow"
        IfWinExist, %titleTag% ahk_class %appClass%
        {
            IfWinActive, %titleTag% ahk_class %appClass%
            {
                Return
            } 
            IfWinNotActive, %titleTag% ahk_class %appClass%
            {
                WinActivate, %titleTag% ahk_class %appClass%
                WinRestore, %titleTag% ahk_class %appClass%
                Return
            }
        }
        IfWinNotExist, %titleTag% ahk_class %appClass%
        {
            Run, %exePath%
            WinWait, %titleTag% ahk_class %appClass%
            WinActivate, %titleTag% ahk_class %appClass%
            WinRestore, %titleTag% ahk_class %appClass% 
            Sleep, 1000
            Return
        }
    }
;Volume Mixer open or make active
    VolMixerLaunchActive()
    {
        exePath := "C:\Windows\System32\SndVol.exe" 
        IfWinExist, ahk_exe %exePath%
        {
            WinActivate, ahk_exe %exePath%
            Return
        }
        IfWinNotExist, ahk_exe %exePath%
        {
            Run %exePath% 
            WinWait, ahk_exe %exePath%   
            WinActivate, ahk_exe %exePath%
            Return               
        }  
        Return
    }
;Twitch App Launch
    TwitchLaunchActive()
    {
        exePath := A_AppData . "\Twitch\Bin\Twitch.exe"
        titleTag := "Twitch"
        appClass := "Chrome_WidgetWin_1"
        IfWinExist, %titleTag% ahk_class %appClass%
        {       
            IfWinActive, %titleTag% ahk_class %appClass%
            {
                Send, {Media_Play_Pause}
                return                  
            }
            Else 
            {
                WinActivate,  %titleTag% ahk_class %appClass%
                Return
            }
            Return
        }
        IfWinNotExist, %titleTag% ahk_class %appClass%
        {
            RunWait, %exePath%,,,runPID
            WinActivate, ahk_pid runPID 
            Sleep, 500
            Return
        } 
        Return   
    } 


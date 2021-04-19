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

;Application open and make active

    ;Firefox Default Account make active
        >^F19::
            IfWinExist, -Main-
            {
                WinGet,ffMainActive,ID, -Main-
                WinActivate, ahk_id %ffMainActive%
                Return
            }
            IfWinNotExist, -Main-
            {
                RunWait, cmd.exe /c start firefox.exe -p default-release ,,Hide
                Return
            } 
    ;Firefox Alt Account make active
        >^F20:: 
            IfWinExist, -Hifi-
            {
                WinGet,ffAltActive,ID, -Hifi-
                WinActivate, ahk_id %ffAltActive%
                Return
            }
            IfWinNotExist, -Hifi-
            {
                RunWait, cmd.exe /c start firefox.exe -p HifiVox ,,Hide
                Return
            } 
    ;Visual Studio
        >^F21::
            IfWinExist, ahk_exe Code.exe
            {
                WinGet,vsCodeActive,ID, ahk_exe Code.exe
                WinActivate, ahk_id %vsCodeActive%
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
                WinGet,psActive,ID, ahk_exe C:\Program Files\Adobe\Adobe Photoshop 2020\photoshop.exe
                WinActivate, ahk_id %psActive%
                Return
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
                MsgBox,,, Starting Main Steam, 3
                Process, close, steam.exe
                ;location of .bat must be changed
                Run, "C:\Users\Colto\Documents\SteamMain.bat" ,,Hide
                Return
            }
            IfWinNotExist, ahk_exe steam.exe
            {
                MsgBox,,, Starting Alt Steam, 3
                ;location of .bat must be changed
                Run, "C:\Users\Colto\Documents\SteamMain.bat" ,,Hide
                Return
            }

    ;Steam Alt
        >+>^F24::
            IfWinExist, ahk_exe steam.exe
            {
                MsgBox, Starting Alt Steam
                Process, close, steam.exe
                ;location of .bat must be changed
                Run, "C:\Users\Colto\Documents\SteamPBX.bat" ,,Hide
                Return
            }
            IfWinNotExist, ahk_exe steam.exe 
            {
                MsgBox, Starting Alt Steam
                ;location of .bat must be changed
                Run, "C:\Users\Colto\Documents\SteamPBX.bat" ,,Hide
                Return
            }
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
            IfWinExist, TIDAL
            {
                Run cmd.exe /c start nircmd.exe changeappvolume TIDALPlayer.exe -0.02 ,,Hide            
            }
            IfWinExist, Spotify
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
            IfWinExist, TIDAL
            {
                Run cmd.exe /c start nircmd.exe changeappvolume TIDALPlayer.exe +0.02 ,,Hide            
            }
            IfWinExist, Spotify
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
            IfWinExist, TIDAL
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
            IfWinExist, TIDAL
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

  

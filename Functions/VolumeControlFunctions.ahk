;focused window function
    focusVol(percent,plusOrMinus)
    {
        SoundGet, currVol
        decimalPercent := percent / 100
        percentCurrVol := currVol / 100
        If !(plusOrMinus = "+" || plusOrMinus = "-")
        {
            MsgBox, second variable must be "+" or "-"
            Return
        }
        percentRecalc := plusOrMinus . (decimalPercent / percentCurrVol)
        currentAHKID := WinExist("A")
        WinGetTitle, focusedTitle, ahk_id %currentAHKID%
        WinGetClass, focusedClass, ahk_id %currentAHKID%
        ;Chromium exceptions
        If (focusedClass = "Chrome_WidgetWin_1")
        {
            ;Vivaldi
            If (focusedTitle ~= "Vivaldi")
            {
                Run cmd.exe /c start nircmd.exe changeappvolume vivaldi.exe %percentRecalc% ,,Hide
            }
            ;Twitch App
            If (focusedTitle ~= "Twitch")
            {
                Run cmd.exe /c start nircmd.exe changeappvolume TwitchUI.exe %percentRecalc% ,,Hide
            }
            ;Chrome
            If (focusedTitle ~= "Google Chrome")
            {
                Run cmd.exe /c start nircmd.exe changeappvolume chrome.exe %percentRecalc% ,,Hide
            }
        }
        If (focusedClass = "Qt5QWindowIcon")
        {
            percentRecalc := percentRecalc / 10
        }
        Run cmd.exe /c start nircmd.exe changeappvolume focused %percentRecalc% ,,Hide 
        Return
    }
;Media application volume control function
    MediaVol(percent,plusOrMinus)
    {
        SoundGet, currVol
        decimalPercent := percent / 100
        percentCurrVol := currVol / 100
        If !(plusOrMinus = "+" || plusOrMinus = "-")
        {
            MsgBox, second variable must be "+" or "-"
            Return
        }
        percentRecalc := plusOrMinus . (decimalPercent / percentCurrVol)
        ;Check for active Firefox
        IfWinExist, ahk_class MozillaWindowClass
        {
            winPIDArr := []
            WinGet, fireFoxWindows, List, ahk_class MozillaWindowClass
            Loop,%fireFoxWindows%
            {
                hold := fireFoxWindows%A_Index%
                WinGet, ffPID, PID, ahk_id %hold%
                winPIDArr.push(ffPID)
            }
            uniqueWins := uniq(winPIDArr)
            For k, v in uniqueWins
            {
                Run cmd.exe /c start nircmd.exe changeappvolume /%v% %percentRecalc% ,,Hide 
            }
        }
        ;Chromium exceptions
        IfWinExist, ahk_class Chrome_WidgetWin_1
        {
            ;Vivaldi
            IfWinExist, Vivaldi
            {
                Run cmd.exe /c start nircmd.exe changeappvolume vivaldi.exe %percentRecalc% ,,Hide
            }
            ;Twitch App
            IfWinExist, Twitch
            {
                Run cmd.exe /c start nircmd.exe changeappvolume TwitchUI.exe %percentRecalc% ,,Hide
            }
            ;Chrome
            IfWinExist, Google Chrome
            {
                Run cmd.exe /c start nircmd.exe changeappvolume chrome.exe %percentRecalc% ,,Hide
            }
        }
        IfWinExist, ahk_exe TIDAL.exe
        {
            Run cmd.exe /c start nircmd.exe changeappvolume TIDAL.exe %percentRecalc% ,,Hide               
            Run cmd.exe /c start nircmd.exe changeappvolume TIDALPlayer.exe %percentRecalc% ,,Hide         
        }
        IfWinExist, ahk_exe Spotify.exe
        {
            Run cmd.exe /c start nircmd.exe changeappvolume Spotify.exe %percentRecalc% ,,Hide            
        }
        IfWinExist, Pocket Casts
        {
            Run cmd.exe /c start nircmd.exe changeappvolume "Pocket Casts.exe" %percentRecalc% ,,Hide                         
        } 
        IfWinExist, VLC media player 
        {
            Run cmd.exe /c start nircmd.exe changeappvolume vlc.exe %percentRecalc% ,,Hide                        
        }
        Return
    }
;Line in volume control function
    LineInVol(pid,percent,plusOrMinus)
    {
        SoundGet, currVol
        decimalPercent := percent / 100
        percentCurrVol := currVol / 100
        If !(plusOrMinus = "+" || plusOrMinus = "-")
        {
            MsgBox, second variable must be "+" or "-"
            Return
        }
        percentRecalc := plusOrMinus . (decimalPercent / percentCurrVol)
        Run cmd.exe /c start nircmd.exe changeappvolume /%pid% %percentRecalc% ,,Hide
        Return       
    }
;System Volume control Functions
    MainSysVol(percent)
    {
        If (percent < 0)
        {
            positiveInt := Round(Abs(percent) / 2)
            Send, {Volume_Down %positiveInt%}
            Return
        }
        If (percent > 0)
        {
            Int := Round(percent / 2)
            Send, {Volume_Up %Int%}
            Return            
        }
    }
;MediaVol Required function
    uniq(nameArray)
    {
    hash := {}
    for i, name in nameArray
        hash[name] := null

    trimmedArray := []
    for name, dummy in hash
        trimmedArray.Insert(name)

    return trimmedArray
    }
;LineInVol Required Function
    grabInputPID()
    {
        tmpFile = ~~TaskListResult~~
        RunWait %comspec% /c tasklist /svc > %tmpFile%,, Hide
        FileRead taskList, %tmpFile%
        FileDelete %tmpFile%

        searchedImage = svchost.exe
        searchedService = Audiosrv 
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
            MsgBox no PID found...
        }
        Return pidNoSpace
    }

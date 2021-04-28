#SingleInstance, Force
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

!R:: 
    currAct := WinActive("A")
    MsgBox, Reloading Script SoundPID ahk
    Reload
    WinActivate, ahk_id %currAct%
    return

!U::
;overwrite file | copy NUL *.txt
ActiveAHKID := WinExist("A")
WinGet, ActivePID, PID, ahk_id %ActiveAHKID%
WinGet, HifiFFPID, PID, -Hifi-
WinGet, MainFFPID, PID, -Main-
WinGet, ChromePID, PID, Google Chrome
WinGet, TidalPID, PID, TIDAL
WinGet, SpotifyPID, PID, Spotify
;get Focused
    Run, cmd.exe /c SoundVolumeView.exe /stab "" | GetNir "Volume Percent" "ProcessID= %ActivePID%" > VolumePercents/FocusedPercent.txt ,,Hide   
;get Media
    If HifiFFPID !=
    {
        Run, cmd.exe /c SoundVolumeView.exe /stab "" | GetNir "Volume Percent" "ProcessID= %HifiFFPID%" > VolumePercents/HifiFirefoxPercents.txt ,,Hide        
    } 
    If MainFFPID != 
    {
        Run, cmd.exe /c SoundVolumeView.exe /stab "" | GetNir "Volume Percent" "ProcessID= %MainFFPID%" > VolumePercents/MainFirefoxPercents.txt ,,Hide
    }
    If ChromePID != 
    {
        Run, cmd.exe /c SoundVolumeView.exe /stab "" | GetNir "Volume Percent" "ProcessID= %ChromePID%" > VolumePercents/ChromePercents.txt ,,Hide
    }
    If TidalPID !=
    {
        Run, cmd.exe /c SoundVolumeView.exe /stab "" | GetNir "Volume Percent" "ProcessID= %TidalPID%" > VolumePercents/TidalPercents.txt ,,Hide
    }
    If SpotifyPID != 
    {
        Run, cmd.exe /c SoundVolumeView.exe /stab "" | GetNir "Volume Percent" "ProcessID= %SpotifyPID%" > VolumePercents/SpotifyPercents.txt ,,Hide 
    }          
;get Line In
    Run, cmd.exe /c SoundVolumeView.exe /stab "" | GetNir "Volume Percent" "ProcessID= %LineInPID%" "Type=Application" "DeviceName= 3- USB Multi-Channel Audio Device" "Direction= Render" > VolumePercents/LineInPercent.txt ,,Hide

;MsgBox, %LineInPID%
Return
!T::
    WinGet, HifiFFPID, PID, -Hifi-
    If HifiFFPID !=
    {
        Run, cmd.exe /c SoundVolumeView.exe /stab "" | GetNir "Volume Percent" "ProcessID= %HifiFFPID%" > VolumePercents/HifiFirefoxPercents.txt ,,Hide        
    } 
    FileReadLine, HifiRead, VolumePercents/HifiFirefoxPercents.txt, 1
    MsgBox, %HifiRead%
    Run, cmd.exe /c echo Null > VolumePercents/HifiFirefoxPercents.txt ,,Hide 
    Return
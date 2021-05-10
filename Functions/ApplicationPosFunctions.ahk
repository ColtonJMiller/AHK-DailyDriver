;Toggle maximize on active window
    MaxToggle()
    {
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
        Return
    }
;Cycle active window between monitor screens
    CycleMonitor()
    {
        Send, {LWinDown}{ShiftDown}{Left}{ShiftUp}{LWinUp}
        Return
    }
;SavePositions for extended monitor config
    SaveWinPositions() 
    {
        WinGet, Windows, List
        SysGet, monitor1Area, MonitorWorkArea, 1
        SysGet, monitor2Area, MonitorWorkArea, 2
        StringReplace, fixedDocPath, A_MyDocuments, \, /, All]
        ahkHoldPath := fixedDocPath . "/AHKPercentHolds/"
        winPosSavePath := ahkHoldPath . "WinConfigPositionSave.txt"
        ;MsgBox, Monitor 1:`n Left: %monitor1AreaLeft% Top: %monitor1AreaTop% Right: %monitor1AreaRight% Bottom: %monitor1AreaBottom%`nMonitor 2:`n Left: %monitor2AreaLeft% Top: %monitor2AreaTop% Right: %monitor2AreaRight% Bottom: %monitor2AreaBottom%
        currentActiveWin := "ahk_id " . WinExist("A")
        FileDelete, %winPosSavePath%
        Loop, %Windows%
        {
            this_ID := Windows%A_Index%
            WinGetTitle, this_title, ahk_id %this_ID%
            WinGet, WinState, MinMax, ahk_id %this_ID%
            If (WinState = 1)
            {
                WinRestore, ahk_id %this_ID%
                WinGetPos, currX, currY, currW, currH, ahk_id %this_ID%
                WinMaximize, ahk_id %this_ID%
            }
            If (WinState = -1)
            {
                WinRestore, ahk_id %this_ID%
                WinGetPos, currX, currY, currW, currH, ahk_id %this_ID%
                WinMinimize, ahk_id %this_ID%                
            }
            If (WinState = 0)
            {
                WinGetPos, currX, currY, currW, currH, ahk_id %this_ID%
            }
            If (this_title)
            {
                If !(this_title = "Switch USB" || this_title = "Program Manager")
                {
                    FileAppend, %currX%|%currY%|%currW%|%currH%|%WinState%|%this_ID%|%this_title%`n, %winPosSavePath%
                }
            }
        }
        WinActivate, %currentActiveWin%        
        Return
    }

;Load Positions for desktop Config extended
    LoadWinPositions()
    {
        WinGet, Windows, List
        SysGet, monitor1Area, MonitorWorkArea, 1
        SysGet, monitor2Area, MonitorWorkArea, 2
        StringReplace, fixedDocPath, A_MyDocuments, \, /, All]
        ahkHoldPath := fixedDocPath . "/AHKPercentHolds/"
        winPosSavePath := ahkHoldPath . "WinConfigPositionSave.txt"
        ;MsgBox, Monitor 1:`n Left: %monitor1AreaLeft% Top: %monitor1AreaTop% Right: %monitor1AreaRight% Bottom: %monitor1AreaBottom%`nMonitor 2:`n Left: %monitor2AreaLeft% Top: %monitor2AreaTop% Right: %monitor2AreaRight% Bottom: %monitor2AreaBottom%
        currentActiveWin := WinExist("A")
        Loop, Read, %winPosSavePath%
        {
            StringSplit, HoldArr, A_LoopReadLine, |
            ;MsgBox,  %A_Space%X: %HoldArr1%`n Y: %HoldArr2%`n W: %HoldArr3%`n H: %HoldArr4%`n WinState: %HoldArr5%`n ID: %HoldArr6%`n Title: %HoldArr7%
            ;If is maximized
            idAtIndex := "ahk_id " . HoldArr6
            WinActivate, %idAtIndex%
            ;MsgBox, %idAtIndex%
            WinRestore, %idAtIndex%
            WinMove, %idAtIndex%,, %HoldArr1%, %HoldArr2%, %HoldArr3%, %HoldArr4%        
            If (HoldArr5 = 1)
            {
                WinMaximize, %idAtIndex%
            }
            If (HoldArr5 = -1)
            {
                WinMinimize, %idAtIndex%
            }
        }   
        WinActivate, ahk_id %currentActiveWin% 
        Return
    }
;Set Desktop config to Monitor 1 only
    Monitor1OnlyConfig()
    {
        SaveWinPositions()
        Run cmd.exe /c C:\Windows\System32\DisplaySwitch.exe /internal ,,Hide
        Return
    }
;Set Desktop config to Monitor 2 only
    Monitor2OnlyConfig()
    {
        SaveWinPositions()
        Run cmd.exe /c C:\Windows\System32\DisplaySwitch.exe /external ,,Hide
        Return
    }
;Set Desktop config for extended displays
    MonitorExtendConfig()
    {
        RunWait, cmd.exe /c C:\Windows\System32\DisplaySwitch.exe /extend ,,Hide
        Sleep, 1000
        LoadWinPositions()
        Return
    }
;Active Window resize
    ActiveSizeReset()
    {
        WinGet, winState, MinMax, A
        If (winState = 1 || winState = -1)
        {
            WinRestore, A          
        }
        WinMove, A,,0,0,500, 500  
        Return
    }

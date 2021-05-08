;Global Variables
StringReplace, fixedDocPath, A_MyDocuments, \, /, All]
ahkHoldPath := fixedDocPath . "/AHKPercentHolds/"

;Function for finding unique strings inside an array
;Used for logic in volume hotkey portion for firefox multiwindow
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
SectionHeader()
{
	SysGet, MonitorCount, MonitorCount
	SysGet, MonitorPrimary, MonitorPrimary
	line=SECTION: Monitors=%MonitorCount%,MonitorPrimary=%MonitorPrimary%

        WinGetPos, x, y, Width, Height, Program Manager
	line:= line . "; Desktop size:" . x . "," . y . "," . width . "," . height

	Return %line%
}
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
getLampBrightness()
{
  StringReplace, fixedDocPath, A_MyDocuments, \, /, All]
  brightnessTxtFile := fixedDocPath . "/AHKPercentHolds/bright.txt"
  Runwait cmd.exe /c kasa --bulb --alias Coltons_Lamp brightness > %brightnessTxtFile% ,,Hide
  FileReadLine, brightLine, %brightnessTxtFile%, 5
  StringRight, brightVal, brightLine, 2
  return brightVal
}

;OSD for vol and lamp
    OSDGui(title,contType,percent)
    {
        global
        currActive := "ahk_id" . WinExist("A")
        SysGet, monitor1Area, MonitorWorkArea, 1
        SysGet, monitor2Area, MonitorWorkArea, 2
        ;MsgBox, Monitor 1:`n Left: %monitor1AreaLeft% Top: %monitor1AreaTop% Right: %monitor1AreaRight% Bottom: %monitor1AreaBottom%`nMonitor 2:`n Left: %monitor2AreaLeft% Top: %monitor2AreaTop% Right: %monitor2AreaRight% Bottom: %monitor2AreaBottom%
        Gui, OSD:New, +AlwaysOnTop -Resize -Caption +ToolWindow
        Gui, Color, 000001, 00FF00
        Gui, Margin, 0, 0
        Gui, Font, s20 c00FF00
        Gui, Add, Text, Y20 x10, %title%
        Gui, Font, s10
        Gui, Add, Text, Y60 x10, %contType%
        Gui, Font, s12
        Gui, Add, Text, y70 x130, %percent%
        ;Gui, Add, Progress, Vertical x150 y20 cRed
        Gui,Add,Progress, w20 h80 x170 y10 cLime Vertical vPercentSlider, %percent%
        GuiControl +Background000000, PercentSlider
        Gui +LastFound
        WinSet, Transparent, 180
        Gui, Show, H120 W200 X1720 Y0
        WinActivate, %currActive%
        Sleep, 200
        Gui,Hide
        Return
    }
;Gui for Sound Output change
    SoundOutGUI(hKNum, output, eQ)
    {
        global
        currActive := "ahk_id" . WinExist("A")
        SysGet, monitor1Area, MonitorWorkArea, 1
        SysGet, monitor2Area, MonitorWorkArea, 2
        ;MsgBox, Monitor 1:`n Left: %monitor1AreaLeft% Top: %monitor1AreaTop% Right: %monitor1AreaRight% Bottom: %monitor1AreaBottom%`nMonitor 2:`n Left: %monitor2AreaLeft% Top: %monitor2AreaTop% Right: %monitor2AreaRight% Bottom: %monitor2AreaBottom%
        Gui, OSD:New, +AlwaysOnTop -Resize -Caption +ToolWindow
        Gui, Color, 000001, 00FF00
        Gui, Font,, Courier New
        Gui, Margin, 0, 0
        If (output = "BTA 30")
        {
            Gui, Font, s25 w600 cFFC300
            Gui, Add, Text, Y10 x140, %output%

        }
        If (output = "Logitech Pro X")
        {
            Gui, Font, s25 w600 c00FF00
            Gui, Add, Text, Y10 x55, %output%
        }
        If (output = "Fiio K5 Pro")
        {
            If (eQ = "Beyerdynamic DT770 80 ohm")
            {
                Gui, Font, c3edef4
            }
            If (eQ = "Etymotic Research MK5")
            {
                Gui, Font, cfef128    
            }
            Gui, Font, s25 w600 
            Gui, Add, Text, Y10 x90, %output%    
        }
        If (eQ = "Sony WH-1000XM4")
        {
            Gui, Font, s15
            Gui, Add, Text, Y50 x55, Preset: %eQ%
        }
        If (eQ = "Pro X")
        {
            Gui, Font, s15
            Gui, Add, Text, Y50 x115, Preset: %eQ%
        }
        If (eQ = "Beyerdynamic DT770 80 ohm")
        {
            Gui, Font, s11
            Gui, Add, Text, Y50 x36, Preset: %eQ%
        }
        If (eQ = "Etymotic Research MK5")
        {
            Gui, Font, s11
            Gui, Add, Text, Y50 x55, Preset: %eQ%           
        }
        Gui, Font, s19
        Gui, Add, Text, y0 x4, %hKNum%
        Gui +LastFound
        WinSet, Transparent, 200
        Gui, Show, h80 W400 X1520 Y960
        WinActivate, %currActive%
        Sleep, 3000
        Gui,Hide
        Return
    }

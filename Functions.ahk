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
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
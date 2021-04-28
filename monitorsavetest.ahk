;#InstallKeybdHook
#SingleInstance, Force

!R:: 
	currAct := WinActive("A")
	MsgBox, Reloading Script monitorsavetest.ahk
	Reload
	WinActivate, ahk_id %currAct%
	return

#Y::
	FileDelete, AllWinPos.txt
	FileDelete, MonitorPos.txt
	SysGet, numOfMonitors, MonitorCount
	SysGet, priMonitor, MonitorPrimary
	SysGet, mon1, Monitor, 1
	SysGet, mon2, Monitor, 2
	MsgBox, Number of Monitors = %numOfMonitors%`n Primary Monitor = %priMonitor%`n Workarea Monitor 1 = Left: %Mon1Left% -- Top: %Mon1Top% -- Right: %Mon1Right% -- Bottom %Mon1Bottom%.`n Workarea Monitor 2 = Left: %Mon2Left% -- Top: %Mon2Top% -- Right: %Mon2Right% -- Bottom %Mon2Bottom%.
	FileAppend,%mon1left% %mon1Top% %mon1Right% %mon1Bottom%`n, MonitorPos.txt
	FileAppend,%mon2left% %mon2Top% %mon2Right% %mon2Bottom%, MonitorPos.txt
	WinGet,Windows,List
	;MsgBox, %Windows%
	Loop,%Windows%
	{
		this_id := "ahk_id " . Windows%A_Index%
		WinGetTitle, this_title, %this_id%
		WinGetClass, this_class, %this_id%
		WinGet, this_PID, PID, %this_id%
		WinGet, Winstate, MinMax, %this_id%
		
		;MsgBox, Title = %this_title%`n Class = %this_class%`n PID = %this_PID%
		WinGetPos, currX, currY, currH, currW, %this_id%
		;MsgBox, %currX%
		FileAppend, %currX%\%currY%\%currH%\%currW%\%Winstate%\%this_title%`n, AllWinPos.txt
	}
>^Y::
	Loop, Read, AllWinPos.txt
	{
		;MsgBox, %A_LoopReadLine%
		StringSplit, HoldArr, A_LoopReadLine, \
		If (HoldArr6)
		{
			WinMove, %HoldArr6%,, %HoldArr1%, %HoldArr2%, %HoldArr3%, %HoldArr4%, %HoldArr5%
			If (HoldArr5 = 1)
			{
				WinMaximize, %HoldArr6%
			}
		}

	}
	Return



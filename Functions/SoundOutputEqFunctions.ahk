;Switch Output device to BTA 30
    SwitchBTA30(hKNum, output, eQ)
    {
        Run %ComSpec% /c start nircmd.exe setdefaultsounddevice "Digital Output" 1 ,,Hide 
        Run %ComSpec% /c start nircmd.exe setdefaultsounddevice "Digital Output" 2 ,,Hide
        Send, {ShiftDown}{AltDown}{CtrlDown}{Numpad0}{CtrlUp}{AltUp}{ShiftUp}
        SoundOutGUI(hKNum,output,eQ)
        Return
    }
;Switch Output device to Logitech Pro X
    SwitchProX(hKNum, output, eQ)
    {
        Run %ComSpec% /c start nircmd.exe setdefaultsounddevice "Pro X" 1 ,,Hide
        Run %ComSpec% /c start nircmd.exe setdefaultsounddevice "Pro X" 2 ,,Hide
        Send, {ShiftDown}{AltDown}{CtrlDown}{Numpad1}{CtrlUp}{AltUp}{ShiftUp}
        SoundOutGUI(hKNum,output,eQ)     
        Return   
    }
;Switch Output device to Fiio K5 Pro
    SwitchK5Pro(hKNum, output, eQ)
    {
        If (eQ = "Beyerdynamic DT770 80 ohm")
        {
            Run %ComSpec% /c start nircmd.exe setdefaultsounddevice "K5 Pro" 1 ,,Hide
            Run %ComSpec% /c start nircmd.exe setdefaultsounddevice "K5 Pro" 2 ,,Hide
            Send, {ShiftDown}{AltDown}{CtrlDown}{Numpad2}{CtrlUp}{AltUp}{ShiftUp}
            SoundOutGUI(hKNum,output,eQ)
            Return
        }
        If (eQ = "Etymotic Research MK5")
        {
            Run %ComSpec% /c start nircmd.exe setdefaultsounddevice "K5 Pro" 1 ,,Hide
            Run %ComSpec% /c start nircmd.exe setdefaultsounddevice "K5 Pro" 2 ,,Hide
            Send, {ShiftDown}{AltDown}{CtrlDown}{Numpad3}{CtrlUp}{AltUp}{ShiftUp}
            SoundOutGUI(hKNum,output,eQ)
            return 
        }
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
        Sleep, 2000
        Gui,Hide
        Return
    }
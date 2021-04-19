DetectHiddenWindows, on
auditionID := ""
    <+F24::
        currentActive := WinExist("A")
        IfWinNotExist, ahk_exe Adobe Audition CC.exe
        {
            Run, "C:\Program Files\Adobe\Adobe Audition CC 2015\Adobe Audition CC.exe" ,,Hide
            WinWait, Adobe Audition CC 2015 
            WinActivate,  ahk_exe Adobe Audition CC.exe
            auditionID := WinExist("A")
            Send, {CtrlDown}n{CtrlUp}}
            Sleep, 50
            Send, {enter}
            Sleep, 50
            Send, {left}{enter}
            Sleep,50
            Send, {ctrldown}{altdown}{shiftdown}={ctrlup}{altup}{shiftup}
            Sleep, 50
            Send, {ctrldown}{altdown}{shiftdown}-{ctrlup}{altup}{shiftup}
            Sleep, 50
            WinActivate, ahk_id %currentActive% 
            WinHide, ahk_exe Adobe Audition CC.exe
            Return                 
        }
        IfWinExist, ahk_exe Adobe Audition CC.exe
        {
            WinActivate,  ahk_exe Adobe Audition CC.exe         
            Send, {ctrldown}{altdown}{shiftdown}={ctrlup}{altup}{shiftup}
            Sleep, 50
            Send, {ctrldown}{altdown}{shiftdown}-{ctrlup}{altup}{shiftup}
            Sleep, 50
            WinActivate, ahk_id %currentActive%
            WinHide, ahk_exe Adobe Audition CC.exe
            Return        
        }
        Return
    <+F23::
        WinShow, ahk_exe Adobe Audition CC.exe
        Return
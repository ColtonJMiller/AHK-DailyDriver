#NoTrayIcon
DetectHiddenWindows, on
auditionID := ""
;HOTKEYS 
    ;open and start monitor Audition
        auditionMonitorHK := "<+F24"
        hotkey, %auditionMonitorHK%, auditionMonitorLab
    ;show audition   
        auditionShowHK := "<+F23"
        hotkey, %auditionShowHK%, auditionShowLab
;Audition open and show    
    ;open and start monitor Audition
        auditionMonitorLab:
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
    ;Audition show
        auditionShowLab:
            WinShow, ahk_exe Adobe Audition CC.exe
            Return
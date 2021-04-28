#SingleInstance, Force
                
!R::               
    currAct := WinActive("A")
    MsgBox, Reloading Script SoundGetApp.ahk
    Reload
    WinActivate, ahk_id %currAct%
    return
!u::
    controlsArr := []
    SetFormat, FloatFast, 0 ; set the numbers to a workable format
    Run, sndvol.exe,,Minimize ; sndvol.exe is the Volume Mixer program. I would have used Hide, but Minimize makes it better.
    WinWait, ahk_exe SndVol.exe
    WinGet, listVar, ControlList, ahk_exe SndVol.exe ; Collect all of the controls in the list
    Loop, parse, listVar, `n, `r
    {
        ControlGetText, text, %A_LoopField% ; each item in the list is checked for its text
        ;MsgBox, %text%
        If text contains Mozilla Firefox
        {
            controlsArr.Push(A_loopField) ; this will store a value of Static_ where _ is some number.
        }
        If text contains Audient
        {
            controlsArr.Push(A_loopField) ; this will store a value of Static_ where _ is some number.
        }
    }

    for k,v in controlsArr
    {
        ;MsgBox, %k% %v%
        StringTrimLeft, staticNumber, v, 6
        staticNumber++ ; add 1 to this number
        suffix:=staticNumber/3 ; find out how many times this can be divided by 3, stored in variable suffix
        suffix+=320 ; add 320 to suffix
        ;MsgBox, staticNumber = %staticNumber%`n suffix = %suffix%
        ControlSend, msctls_trackbar%suffix%, {up 1}, ahk_exe SndVol.exe
    }
    ;WinClose, ahk_exe SndVol.exe
    return
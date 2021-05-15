#SingleInstance, Force
    HotKeyHold := ""
    Gui, Font, s50 
    Gui, add, Picture,x0 y0 w900 h-1, Info/HelperGUIPhotos/NoModifier.png
    Gui, show,w900 h800,Helper Gui
    Return

    GuiClose:
    ExitApp
    GuiEscape:
    ExitApp
    IfWinActive, Helper Gui, 
    {
        Numpad0::
            GuiControl,, Info/HelperGUIPhotos/NoModifier.png, Info/HelperGUIPhotos/RShift.png
            KeyWait, Numpad0
            GuiControl,, Info/HelperGUIPhotos/NoModifier.png, Info/HelperGUIPhotos/NoModifier.png
            Return
        NumpadMult::
            GuiControl,, Info/HelperGUIPhotos/NoModifier.png, Info/HelperGUIPhotos/LShift.png
            KeyWait, NumpadMult
            GuiControl,, Info/HelperGUIPhotos/NoModifier.png, Info/HelperGUIPhotos/NoModifier.png 
            Return   
        NumpadAdd::
            GuiControl,, Info/HelperGUIPhotos/NoModifier.png, Info/HelperGUIPhotos/RAlt.png
            KeyWait, NumpadAdd
            GuiControl,, Info/HelperGUIPhotos/NoModifier.png, Info/HelperGUIPhotos/NoModifier.png
            Return
        ~LAlt::
            Return
        ;No Mod Key Exit
            >^F19::  
                ExitApp
            >^F20:: 
                ExitApp
            >^F21:: 
                ExitApp
            >^F22:: 
                ExitApp
            >^F23:: 
                ExitApp
            >^F24:: 
                ExitApp
            F13::
                ExitApp
            F14::
                ExitApp
            F15::
                ExitApp
            F16::
                ExitApp
            F17::
                ExitApp
            F18::
                ExitApp
            F19::
                ExitApp
            F20::
                ExitApp
            F21::
                ExitApp
            F22::
                ExitApp
            F23::
                ExitApp
            F24::      
                ExitApp 
        ;RShift Key Exit
            >+>^F19:: 
                ExitApp
            >+>^F20:: 
                ExitApp
            >+>^F21:: 
                ExitApp
            >+>^F22:: 
                ExitApp
            >+>^F23:: 
                ExitApp
            >+>^F24:: 
                ExitApp
            >+F13::
                ExitApp
            >+F14::
                ExitApp
            >+F15::
                ExitApp
            >+F16::
                ExitApp
            >+F17::
                ExitApp
            >+F18::
                ExitApp
            >+F19::
                ExitApp
            >+F20::
                ExitApp
            >+F21::
                ExitApp
            >+F22::
                ExitApp
            >+F23::
                ExitApp
            >+F24::      
                ExitApp   
        ;RAlt Key Exit
            >!>^F19:: 
                ExitApp
            >!>^F20:: 
                ExitApp
            >!>^F21:: 
                ExitApp
            >!>^F22:: 
                ExitApp
            >!>^F23:: 
                ExitApp
            >!>^F24:: 
                ExitApp
            >!F13::
                ExitApp
            >!F14::
                ExitApp
            >!F15::
                ExitApp
            >!F16::
                ExitApp
            >!F17::
                ExitApp
            >!F18::
                ExitApp
            >!F19::
                ExitApp
            >!F20::
                ExitApp
            >!F21::
                ExitApp
            >!F22::
                ExitApp
            >!F23::
                ExitApp
            >!F24::      
                ExitApp
    }
;Return keystroke





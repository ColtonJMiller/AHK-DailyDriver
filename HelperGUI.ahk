#SingleInstance, Force
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
        ~Rshift::
        GuiControl,, Info/HelperGUIPhotos/NoModifier.png, Info/HelperGUIPhotos/RShift.png
        KeyWait, RShift
        GuiControl,, Info/HelperGUIPhotos/NoModifier.png, Info/HelperGUIPhotos/NoModifier.png
        Return
        ~LShift::
        GuiControl,, Info/HelperGUIPhotos/NoModifier.png, Info/HelperGUIPhotos/LShift.png
        KeyWait, LShift
        GuiControl,, Info/HelperGUIPhotos/NoModifier.png, Info/HelperGUIPhotos/NoModifier.png 
        Return   
        RAlt::
        GuiControl,, Info/HelperGUIPhotos/NoModifier.png, Info/HelperGUIPhotos/RAlt.png
        KeyWait, RAlt
        GuiControl,, Info/HelperGUIPhotos/NoModifier.png, Info/HelperGUIPhotos/NoModifier.png
        Return
        LAlt::
        Return
    }





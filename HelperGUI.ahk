#SingleInstance, force

gui, -dpiscale

Gui, Show, w1000 h800,Koolertron Keybinds
GuiControlGet, guiInfo,Pos, text1
gui, Show
GuiControl, Move, text1, % "x" guiWidth/2 - guiInfoW/2
Gui, +Theme +Resize
Gui, Color, 484848
Gui, Font, s15
Gui, add, Picture,w-1 h400, Info/MacropadTemplate.jpg
Gui, Add, ListView, r20 w800, Keybind|No Modifier|R Shift|L Shift|L Ctrl|L Alt|LS + LC|LS + LA|LC + LA|SCA

LV_Add(, Test c1, Test c2,Test c2,Test c2,Test c2,Test c2,Test c2,Test c2,Test c2,Test c2)
Gui, add, text, Center, Koolertron Keybinds
Gui, Add, Text, center, Test 1
Gui, Add, Text, center x60, Test 2
Gui, Add, Text, center x120, Test 3
return

GuiClose:
ExitApp
#SingleInstance, force

Gui, -dpiscale
Gui, Margin, 0, 0
Gui, Show, w500 h800,Kasa Main Lamp Controls
Gui, Color, 484848
Gui, Font, s30 cWhite
Gui, Add, Text,, Kasa Lamp Controls
;On/Off Area
    Gui, Font, s20 cWhite
    Gui, Add, Text,, Turn On/Off
    Gui Margin, 0, 10
    Gui, Font, s14 cWhite    
    Gui, Add, Radio, vOnState, On
    Gui, Add, Radio, vOffState, Off
;Brightness Area
    Gui, Font, s20 cWhite
    Gui, Add, Text,, Brightness
    Gui, Font, s8
    Gui, Margin, 0, -5
    Gui, Add, Text,, Number value from 1 to 100
    Gui, Font, s10 cBlack
    Gui, Margin, 0, 10
    Gui, Add, Edit, r1 vBrightnessState w135 Number
;Temperature Area
    Gui, Font, s20 cWhite
    Gui, Add, Text,, Temperature
    Gui, Font, s8
    Gui, Margin, 0, -5
    Gui, Add, Text,, Number value from 2500 (warm) to 9000 (cool) 5000 is middle
    Gui, Font, s10 cBlack
    Gui, Margin, 0, 10
    Gui, Add, Edit, r1 vTemperatureState w135 Number
    Gui, Add, Button, ,Submit
Return

ButtonSubmit:
Gui, Submit
    If (OnState = 1)
    {
        If (BrightnessState)
        {
            Runwait cmd.exe /c kasa --bulb --alias Coltons_Lamp brightness %BrightnessState% ,,Hide
        }  
        If (TemperatureState)   
        {
            Runwait cmd.exe /c kasa --bulb --alias Coltons_Lamp temperature %TemperatureState% ,,Hide   
        }
        If (!BrightnessState && !TemperatureState)
        {
            Runwait cmd.exe /c kasa --bulb --alias Coltons_Lamp on ,,Hide             
        }   

    }
    If (OffState = 1)
    {
        Runwait cmd.exe /c kasa --bulb --alias Coltons_Lamp off ,,Hide 
    }
ExitApp


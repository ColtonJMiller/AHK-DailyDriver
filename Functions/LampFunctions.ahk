;Lamp off function
    LampOff()
    {
        Runwait cmd.exe /c kasa --host 192.168.1.180 --bulb off ,,Hide 
        MsgBox,, Lamp Notice, Turning lamp off, 1 
        Return      
    }
;Lamp on/set brightness
    LampBrightness(brightness,lampState)
    {
        If (lampState = 0)
        {
            Runwait cmd.exe /c kasa --host 192.168.1.180 --bulb brightness %brightness% ,,Hide
            MsgBox,, Lamp Notice, Setting lamp to %brightness% percent brightness, 1
            Return brightness
        }
        If (lampState = 1)
        {
            currentBrightness := GetLampBrightness()
            brightness := currentBrightness + brightness
            If (brightness <= 1)
            {
                brightness := 1
            }
            If (brightness >= 100)
            {
                brightness := 100
            }
            Runwait cmd.exe /c kasa --host 192.168.1.180 --bulb brightness %brightness% ,,Hide
            MsgBox,, Lamp Notice, Setting lamp to %brightness% percent brightness, 1
            Return brightness
        }

        Return brightness
    }
;Get brightness
    GetLampBrightness()
    {
        StringReplace, fixedDocPath, A_MyDocuments, \, /, All]
        brightnessTxtFile := fixedDocPath . "/AHKPercentHolds/bright.txt"
        Runwait cmd.exe /c kasa --bulb --host 192.168.1.180 brightness > %brightnessTxtFile% ,,Hide
        FileReadLine, brightLine, %brightnessTxtFile%, 1
        StringTrimLeft, brightVal, brightLine, 12
        return brightVal
    }
    GetLampState()
    {
        StringReplace, fixedDocPath, A_MyDocuments, \, /, All]
        TxtFile := fixedDocPath . "/AHKPercentHolds/LampState.txt"
        Runwait cmd.exe /c kasa --bulb --host 192.168.1.180 state > %TxtFile% ,,Hide
        FileReadLine, stateLine, %TxtFile%, 21
        StringSplit, stateArr, stateLine, %A_Space%
        StringTrimRight, trimmedPowerState, stateArr2, 1
        If (trimmedPowerState > 0)
        {
            Return 1
        }
        If (trimmedPowerState = 0)
        {
            Return 0
        }
        Return
    }
    SetLampGui()
    {
        global
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
                    Runwait cmd.exe /c kasa --host 192.168.1.180 --bulb brightness %BrightnessState% ,,Hide
                }  
                If (TemperatureState)   
                {
                    Runwait cmd.exe /c kasa --host 192.168.1.180 --bulb temperature %TemperatureState% ,,Hide   
                }
                If (!BrightnessState && !TemperatureState)
                {
                    Runwait cmd.exe /c kasa --host 192.168.1.180 --bulb on ,,Hide             
                }   

            }
            If (OffState = 1)
            {
                Runwait cmd.exe /c kasa --host 192.168.1.180 --bulb off ,,Hide 
            }
        Gui, Destroy
        Return
    }

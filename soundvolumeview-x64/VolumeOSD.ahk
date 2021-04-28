;Windows 8 inspired GDIP volume OSD
;	http://www.autohotkey.com/board/topic/94248-windows-8-inspired-gdip-volume-osd/
;Made by Rijul Ahuja
;       rijul13.wordpress.com
;Thanks to tic (Tariq Porter) for his GDI+ Library and rseding91 for making it all compatible
;   http://www.autohotkey.com/forum/viewtopic.php?t=32238
;Get the GDIP_all.ahk from here and place it in <location of Autohotkey.exe>\lib\GDIP.ahk
;   http://www.autohotkey.net/~Rseding91/Gdip%20All/Gdip_All.ahk
;Uncomment if GDIP.ahk is not in your library, put it in the script directory.
#Include GDIP.ahk
;===========================Configuration=========================================

;Leave any hotkey blank if you like
VolUpHotkey:="F14"
VolDownHotkey:="F13"
VolMuteHotkey:="!w"

;Position of OSD
PosOSD:="BottomRight"  ;TopLeft / TopRight / TopCenter / BottomLeft / BottomCenter / BottomRight
                    ;case insensitive, Center can be written as centre

;Change volume display font
Font:="Arial"

;Change colour of volume level (ARGB)
VolColour:="0xFF00FF00"

;Should OSD animate on leave? (experimental)
AnimateWindow:=true

;Set to true if OSD should not disappear when mouse is over it.
ShouldMouse:=true

;==========================Config complete========================================
;Do not edit anything below this unless you know what you are doing

#SingleInstance Force
#NoEnv
GetPos(PosOSD)
SetWorkingDir, % A_ScriptDir
SetHotkeys()
If !pToken := Gdip_Startup()
{
	MsgBox, 48, gdiplus error!, Gdiplus failed to start. Please ensure you have GDI+ on your system.
	ExitApp
}
If !Gdip_FontFamilyCreate(Font)
{
   MsgBox, 48, Font error!, The font you have specified does not exist on the system
   ExitApp
}
Gui, VolOSD: -Caption +E0x80000 +LastFound +AlwaysOnTop +ToolWindow +OwnDialogs
Gui, VolOSD: Show, NA Center Hide, % SubStr(A_ScriptName,1,-4)
OnExit, Exit
OnMessage(0x201,"WM_LButtonDown")
;The smallest auto exec of my scripts is complete!
return

WM_LButtonDown(wParam,lParam)
{
    X := lParam & 0xFFFF, Y := lParam >> 16
    If ((X<19) or (X>29)) and (Y<15)
        {}
    else if (Y<115)
        {
        While(GetKeyState("LButton","P"))
            {
            MouseGetPos, , Y
            Volume:=115-Y
            SoundSet, % Volume
            StartOSD()
            }
        }
    else if (Y>=125) and (Y<=140) and (X>=18) and (X<=32)
        {
        SoundSet, +1, , Mute
        StartOSD()
        }
    return 0
}

SetHotkeys()
{
	global VolUpHotkey, VolDownHotkey, VolMuteHotkey
	If VolUpHotkey
		Hotkey, % VolUpHotkey, VolUpLabel
	If VolDownHotkey
		Hotkey, % VolDownHotkey, VolDownLabel
	If VolMuteHotkey
		Hotkey, % VolMuteHotkey, VolMuteLabel

	Hotkey, If, MouseIsOver("ahk_class Shell_TrayWnd")
    
    Hotkey, WheelUp, VolUpLabel
    Hotkey, WheelDown, VolDownLabel
    Hotkey, If
    
    Hotkey, $Volume_Up, VolUpLabel
    Hotkey, $Volume_Down, VolDownLabel
    Hotkey, $Volume_Mute, VolMuteLabel
}

#If MouseIsOver("ahk_class Shell_TrayWnd")
#If

Exit:
Gdip_Shutdown(pToken)
ExitApp

VolDownLabel:
VolMuteLabel:
VolUpLabel:
ToSend:=(A_ThisLabel="VolDownLabel") ? "{Volume_Down}" : ( (A_ThisLabel="VolMuteLabel") ? "{Volume_Mute}" : "{Volume_Up}" )
Send % ToSend
StartOSD()
VarSetCapacity(ToSend,0)
return

StartOSD()
{
	SoundGet, Volume
	SoundGet, Muted, Master, Mute
	Muted:=(Muted="On") ? 1 : 0
	MakeSlider(round(Volume),Muted)
	SetTimer, KillVolOSD, -2500
}

KillVolOSD:
Gui, VolOSD:+Lastfound
If ShouldMouse
{
	SetTimer, KillVolOSD, Off
	MouseGetPos,,,hwndM
	If (hwndM=WinExist())
	{
	    SetTimer, KillVolOSD, 100
	    return
	}
	VarSetCapacity(hwndM,0)
}
If AnimateWindow
    AnimateWindow(WinExist(),300,0x90000)
Gui, VolOSD:+E0x80000
Gui, VolOSD:Submit
return

AnimateWindow(hWnd,Duration,Flag) 
	{
	Return DllCall("AnimateWindow","UInt",hWnd,"Int",Duration,"UInt",Flag)
	}

MakeSlider(Volume,Muted)
{
    static hwnd1
	global XPos,YPos,Font,VolColour
    If !hwnd1
        {
        Gui, VolOSD:+Lastfound
        hwnd1:=WinExist()
        }    
    hbm := CreateDIBSection(50,150)
    hdc := CreateCompatibleDC()
    obm := SelectObject(hdc, hbm)
    G := Gdip_GraphicsFromHDC(hdc)
    Gdip_SetSmoothingMode(G, 4)
    pBrush := Gdip_BrushCreateSolid(0xD2000000)          ;background part
    Gdip_FillRectangle(G, pBrush, 0, 0, 50, 150)
    Gdip_DeleteBrush(pBrush)
    If !Muted
        pBrush := Gdip_BrushCreateSolid(VolColour)      ;Volume Level
    else
        pBrush:=Gdip_BrushCreateSolid(0xFF808080)
    Gdip_FillRectangle(G, pBrush, 19, 15, 10, 100)
    Gdip_DeleteBrush(pBrush)
    pBrush := Gdip_BrushCreateSolid(0xFF606060)            ;slider background colour
    Gdip_FillRectangle(G, pBrush, 19, 15, 10, 100-Volume)
    Gdip_DeleteBrush(pBrush)
    If !Mutedq
        pBrush := Gdip_BrushCreateSolid(0xFFFFFFFF)
    else
        pBrush := Gdip_BrushCreateSolid(0xFFd3d3d3)
    Gdip_FillRectangle(G,pBrush,19,110-(19*Volume)/20,10,5)
    Gdip_DeleteBrush(pBrush)
    If !Muted
        GDIP_TextToGraphics(G,Volume,"x25 y125 cffffffff r4 s14 Center",Font)    ;volume text
    else
        GDIP_TextToGraphics(G,"X","x25 y125 cffffffff r4 s14 Bold Center",Font)    ;volume text
    UpdateLayeredWindow(hwnd1, hdc, XPos, YPos,50,150)
    Gui, VolOSD:Show, NA
    SelectObject(hdc, obm)
    DeleteObject(hbm)
    DeleteDC(hdc)
    Gdip_DeleteGraphics(G)
}

MouseIsOver(WinTitle) 
	{
        MouseGetPos,,, Win
        return WinExist(WinTitle . " ahk_id " . Win)
	}
    
GetPos(ByRef Var)
{
    Global XPos,YPos
    Found:=false
    HayStack:="topleft,topcenter,topright,bottomleft,bottomright,bottomcenter"
    ;Ensure position is correct.
    Loop, Parse, HayStack, `,
        If (RegExMatch(Var,"i)" . A_LoopField)=1)
        {
            Found:=true
            break
        }
    If !Found
    {
        MsgBox, 8208, % SubStr(A_ScriptName,1,-4), Error! Incorrect position of OSD.
        ExitApp
    }
    
    If Instr(Var,"Top")
        YPos:=70
    else
        YPos:=A_ScreenHeight-185
    
    If InStr(Var,"Left")
        XPos:=55
    else if InStr(Var,"Center") or InStr(Var,"Centre")
        XPos:=(A_ScreenWidth/2)-55
    else 
        XPos:=A_ScreenWidth-55
    VarSetCapacity(Var,0)       ;free memory
}
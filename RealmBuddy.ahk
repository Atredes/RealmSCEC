#NoEnv
#SingleInstance force
SendMode Input
SetWorkingDir %A_ScriptDir%
SetKeyDelay 0
SetMouseDelay 0
SetTitleMatchMode 2
#Hotstring EndChars `n

; Check saved window title settings
IniRead, WinTitle, config.ini,  Settings, WindowTitle
; Check saved quality settings
IniRead, quality, config.ini,  Settings, Quality 
; Make sure that in settings window you can see your current quality
if quality=High
	QualitySaved=Choose1
else if quality=Middle
	QualitySaved=Choose2
else if quality=Low
	QualitySaved=Choose3

; Check saved last server
IniRead, server, config.ini,  Settings, LastServer
if server
{}
Else
server= Waiting...



StayOnTop = OFF
StopAtCharScreen = 0


arrayEU := array("EUWest", "EUWest2", "EUSouth", "EUSouthWest", "EUNorth", "EUNorth2","EUEast")
arrayUS := array("USWest","USWest2","USEast","USEast2","USEast3","USSouth","USSouth2","USSouth3","USSouthWest","USMidWest","USMidWest2","USNorthWest")
arrayRealms :=array("Beholder","Cyclops","Medusa","Djinn","Ogre")


ServersGUIButtonAdd(Name,Custom=""){
	Gui, ServersGUI:Add, Text,	 gPickServerGUI %Custom% h20 w100 center, %Name%
	Gui, ServersGUI:Add, Picture, yp-4 BackgroundTrans, files/button_bg.png
}

ServersListButtonAdd(Name,Custom=""){
	Gui, ServerList:Add, Button, %Custom% w90 h24 gPickServerGui, %Name%
}


IniRead, ServerGUIHotkey, config.ini, Hotkeys, ServerGuiHotkey
Hotkey, %ServerGUIHotkey%, ServerGUISub

IniRead, ServerMenuHotkey, config.ini, Hotkeys, ServerMenuHotkey
Hotkey, %ServerMenuHotkey%, ServerMenuSub

IniRead, EventGUIHotkey, config.ini, Hotkeys, EventGuiHotkey
Hotkey, %EventGUIHotkey%, EventGUISub

IniRead, EventMenuHotkey, config.ini, Hotkeys, EventMenuHotkey
Hotkey, %EventMenuHotkey%, EventMenuSub

IniRead, InteractionKey, config.ini, Hotkeys, InteractionKey
Hotkey, ~%InteractionKey%, FindRealmSub
Hotkey, ~LButton, FindRealmSubClick

IniRead, OptionsKey, config.ini, Hotkeys, OptionsKey
if OptionsKey = ESC
	isESC = Checked
else
	isESC = 
Gui 1:+LabelRealmBuddy
Gui, RealmBuddy:Margin, 5, 5
Gui, RealmBuddy:font, s9, Tahoma
Gui, RealmBuddy:Add, Text, w80 h15 Center vREALM, Waiting...
Gui, RealmBuddy:Add, Text,  w80 h15 Center vSERVER, %server%
Gui, RealmBuddy:Add, Text,  w80 h15 cGreen Center vERROR, GOOD


Gui, RealmBuddy:font, s7, Tahoma
Gui, RealmBuddy:Add, CheckBox, w80 h20 gCHAR_CHECKBOX vCHAR Center, Char Change
Gui, RealmBuddy:Add, Button,  w80 h25 Center  gCHARSCREEN, Char Screen


Gui, RealmBuddy:Add, Button,   w80 h30 gServerList, Server List
Gui, RealmBuddy:Add, Button,   w80 h30 gRealmCaller, Realm Caller
Gui, RealmBuddy:Add, Button,   w80 h30 gSettings, Settings
Gui, RealmBuddy:Add, Button,   w80 h30 vTOP gONTOP, Always on top`nOFF

Gui, RealmBuddy:font, s7, Tahoma,  Center
RealmBuddyX := (A_ScreenWidth - 110) ; Get position for main GUI window, right border of screen.
Gui, RealmBuddy:Show, x%RealmBuddyX% , Realm Buddy






Gui 2:+LabelServerList
Gui, ServerList:+ownerRealmBuddy
Gui, ServerList:font, s8, Tahoma
Gui, ServerList:Add, Tab2,h24 Buttons,EU/ASIA|US| 

Gui, ServerList:font, s7, Tahoma
;Use first tab for EU and Asia servers
;Create buttons for EU servers
for k, v in arrayEU {
	if (k==1) {
		ServersListButtonAdd(v,"x5 yp25")
	}
	else {
		ServersListButtonAdd(v)
	}
}
;Create separtor line, no reason why. Just because.
Gui ServerList:Font, S1
Gui ServerList:Add, GroupBox, w90 h2, 

;Create buttons for Asia servers, no need for loop since there are only two. Loop = overkill  
Gui, ServerList:font, s7, Tahoma
ServersListButtonAdd("AsiaSouthEast")
ServersListButtonAdd("AsiaEast")


;Create tab for US servers
Gui, ServerList:Tab, 2

;Create buttons for US servers
for k, v in arrayUS {
	if (k==1) {
		ServersListButtonAdd(v,"x5 yp-248")
	}
	else {
		ServersListButtonAdd(v)
	}
}



Gui, ServerList:Tab  
Gui, ServerList:Show, x10 w100 Hide,Servers List
Gui, ServerList:+ToolWindow

SubmitServersList(){
Gui, RealmBuddy:Submit, NoHide
}





Gui 3:+LabelEventList
Gui, EventList:+ownerRealmBuddy


Loop, read, callouts.ini
{
	callout := A_LoopReadLine
	StringSplit, callout, callout, =,
	Gui, EventList:Add, Button, w80 h25 gCallForEvent, %callout1%
}

EvenListX := (A_ScreenWidth - 230)
Gui, EventList:Show, x%EvenListX% Hide,Realm Caller
Gui, EventList:+ToolWindow


Gui 4:+LabelSettings
Gui, Settings:+ownerRealmBuddy
Gui, Settings:Add, Text,, RoTMG window title:
Gui, Settings:Add, Edit, w300 r1 vTitleEdit,%WinTitle%


Gui, Settings:Add, GroupBox, w130 , Quality Settings
Gui, Settings:Add, DropDownList, w120 yp20 xp5 %QualitySaved% vquality, High|Middle|Low

Gui, Settings:Add, GroupBox, w300 h120 xp165 yp-20, Hotkeys ;Hotkeys Settings
Gui, Settings:Add, Text, w100 yp20 xp5, Servers List GUI: ;Server GUI hotkey
Gui, Settings:Add, Hotkey, vServerNewGUIHotkey h20 w40 yp-4 xp95,%ServerGuiHotkey%

Gui, Settings:Add, Text, w90 yp20 yp3 xp50, Servers List Menu: ;Server MENU hotkey
Gui, Settings:Add, Hotkey, vServerNewMenuHotkey h20 w40 yp-4 xp95 ,%ServerMenuHotkey%

Gui, Settings:Add, Text,w100 yp30 xp-240, Event Callouts GUI: ;Event Callout GUI hotkey
Gui, Settings:Add, Hotkey, vEventNewGUIHotkey h20 w40 yp-4 xp95,%EventGuiHotkey%

Gui, Settings:Add, Text, w90 yp20 yp3 xp50, Event List Menu: ;Event MENU hotkey
Gui, Settings:Add, Hotkey, vEventNewMenuHotkey h20 w40 yp-4 xp95 ,%EventMenuHotkey%

Gui, Settings:Add, Text,w120 yp30 xp-240, In-Game Interaction Key: ;Interaction hotkey
Gui, Settings:Add, Hotkey, vInteractionNewHotkey h20 w40 yp-4 xp120,%InteractionKey%

Gui, Settings:Add, Text,w120 yp30 xp-120, In-Game Options Key: ;Options hotkey
Gui, Settings:Add, Hotkey, vOptionsNewHotkey h20 w40 yp-4 xp120,%OptionsKey%

Gui, Settings:Add, Checkbox, xp50 vOptionsNewHotkeyESC %isESC%, Esc
Gui, Settings:Add, Button, center x300 w80 h25 , Cancel
Gui, Settings:Add, Button, center yp0 xp85  h25 gSaveSettings, Save and Reload
Gui, Settings:Show, Hide ,Settings
Gui, Settings:+ToolWindow


Gui 21:+LabelServersGUI
Gui, ServersGUI:Margin,0,0
Gui, ServersGUI:Font, S14 cWhite b
Gui, ServersGUI:Add, Text, w105 h40 Left, %A_SPACE% Server List:

Gui, ServersGUI:Font, S10 c84E060 w1000
Gui, ServersGUI:Add, Text,vRealmGUI yp5 xp105 w215 h20 Right,%server%
Gui, ServersGUI:Add, Picture, xp-105 yp-9 h30  BackgroundTrans,files/servers_bg.png

Gui, ServersGUI:Margin,0,10 
Gui, ServersGUI:Font, S10 cWhite w450

;Create buttons for EU servers
for k, v in arrayEU {
		ServersGUIButtonAdd(v)
}
;Create buttons for US servers
for k, v in arrayUS {
	if (k==1) {
		ServersGUIButtonAdd(v,"xp+110 yp-182")
	}
	else {
		ServersGUIButtonAdd(v)
	}
}
;Create buttons for Asia servers, no need for loop since there are only two. Loop = overkill
ServersGUIButtonAdd("AsiaSouthEast","xp+110 yp-337")
ServersGUIButtonAdd("AsiaEast")

Gui, ServersGUI:Font, S9
Gui, ServersGUI:Color, 363636
Gui, ServersGUI:Add, CheckBox, w100 h40 gCHAR_CHECKBOX2 vCHAR2  c84E060, C h a r`nC h a n g e
Gui, ServersGUI:+ToolWindow -Caption +AlwaysOnTop
Gui, ServersGUI:Show, Hide w320 h430, ServGUI

CloseServersGUI(){
	Gui, ServersGUI:Submit, Hide
}

number_of_events = 0
Gui 22:+LabelEventsGUI
Gui, EventsGUI:Margin, 0, 0

Loop, read, callouts.ini
{
	callout := A_LoopReadLine
	StringSplit, callout, callout, =,
	event = events/%callout1%.png
	vLabel := RegExReplace(callout1, A_SPACE, "_")
	if (FileExist(event))
	{	
		if (number_of_events == 0)
			Gui, EventsGUI:Add, Picture,gCallForEvent v%vLabel%, %event%
		else
			Gui, EventsGUI:Add, Picture,gCallForEvent xp45 yp0 v%vLabel%, %event%
		++number_of_events
		}
}

EventsGUI_H := number_of_events *40

; Gui, EventsGUI:Add, Picture,gLord xp45 yp-20, quests/lord.png
Gui, EventsGUI:Color, 363636
Gui, EventsGUI:+ToolWindow -Caption +AlwaysOnTop
Gui, EventsGUI:Show, Hide h%EventsGUI_H%, EventsGUI
WinSet, TransColor, 363636 220, EventsGUI




; EU Servers List
for k, v in arrayEU {
		Menu, EUmenu, Add, %v%, PickServerMENU
}
Menu, ServersMenu, Add, EU Servers, :EUmenu

; US Servers List
for k, v in arrayUS {
		Menu, USmenu, Add, %v%, PickServerMENU
}
Menu, ServersMenu, Add, US, :USmenu


; Asia Servers List
Menu, ASIAmenu, Add, AsiaSouthEast, PickServerMENU
Menu, ASIAmenu, Add, AsiaEast, PickServerMENU

Menu, ServersMenu, Add, ASIA, :ASIAmenu


Loop, read, callouts.ini
{
	callout := A_LoopReadLine
	StringSplit, callout, callout, =,
	Menu, RealmCaller, Add, %callout1%, CallForEvent2
}
return




ServerMenuSub:
	Menu, ServersMenu, Show
return
EventMenuSub:
	Menu, RealmCaller, Show 
return

ServerList:
	Gui, ServerList:Show
return

RealmCaller:
	Gui, EventList:Show
return

Settings:
	Gui, Settings:Show
return

SaveSettings:
	Gui, Settings:Submit, Hide
	IniWrite, %TitleEdit%, config.ini,  Settings, WindowTitle
	IniWrite, %quality%, config.ini,  Settings, Quality
	Iniread, ServerGUIHotkey, config.ini, Hotkeys, ServerGuiHotkey
	Hotkey, %ServerGUIHotkey%, ServerGUISub, Off
	IniWrite, %ServerNewGUIHotkey%, config.ini, Hotkeys, ServerGuiHotkey
	
	Iniread, ServerMenuHotkey, config.ini, Hotkeys, ServerMenuHotkey
	Hotkey, %ServerMenuHotkey%, ServerMenuSub, Off
	IniWrite, %ServerNewMenuHotkey%, config.ini, Hotkeys, ServerMenuHotkey
	
	Iniread, EventGUIHotkey, config.ini, Hotkeys, EventGuiHotkey
	Hotkey, %EventGUIHotkey%, EventGUISub, Off
	IniWrite, %EventNewGUIHotkey%, config.ini, Hotkeys, EventGuiHotkey

	Iniread, EventMenuHotkey, config.ini, Hotkeys, EventMenuHotkey
	Hotkey, %EventMenuHotkey%, EventMenuSub, Off
	IniWrite, %EventNewMenuHotkey%, config.ini, Hotkeys, EventMenuHotkey	
	
	IniWrite, %InteractionNewHotkey%, config.ini, Hotkeys, InteractionKey
	IniRead, InteractionKey, config.ini, Hotkeys, InteractionKey
	if OptionsNewHotkeyESC
	{
		OptionsNewHotkey = ESC
	}
	IniWrite, %OptionsNewHotkey%, config.ini, Hotkeys, OptionsKey
	IniRead, OptionsKey, config.ini, Hotkeys, OptionsKey
	
	IniRead, WinTitle, config.ini,  Settings, WindowTitle
	Reload
return


CHAR_CHECKBOX:
	Gui, RealmBuddy:Submit, NoHide
	GuiControlGet, CHAR, RealmBuddy:
	if CHAR = 0
		GuiControl,ServersGUI:, CHAR2,0
	Else
		GuiControl,ServersGUI:, CHAR2,1
return

CHAR_CHECKBOX2:
	Gui, ServersGUI:Submit, NoHide
	GuiControlGet, CHAR2, ServersGUI:
	if CHAR2 = 0
		GuiControl,RealmBuddy:, CHAR,0
	Else
		GuiControl,RealmBuddy:, CHAR,1
return


ONTOP:
	WinSet, AlwaysOnTop, toggle, Realm Buddy
	if StayOnTop = OFF
	{
		GuiControl,, TOP, Always on top`nON
		StayOnTop = ON
	}
	else 
	{
		GuiControl,, TOP, Always on top`nOFF
		StayOnTop = OFF		
	}
	SubmitServersList()
return



PickServerGUI:
	picked_server := A_GuiControl
	Gosub, PickServer
return

PickServerMENU:
	picked_server := A_ThisMenuItem
	Gosub, PickServer
return


PickServer:
{
	SubmitServersList()
	CloseServersGUI()
	IniRead, serverX, config.ini,  %picked_server%, X
	IniRead, serverY, config.ini,  %picked_server%, Y
	IniRead, scroll, config.ini,  %picked_server%, Scroll
	server = %picked_server%
	Gosub, ChangeServer
}
return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CHARSCREEN:
{
	SubmitServersList()
	CloseServersGUI()
	StopAtCharScreen = 1
	Gosub, ChangeServer
}
return


ChangeServer:
	KillScript = 0
IfWinExist, %WinTitle%
{
	WinActivate, %WinTitle%
	Loop
	{
		ImageSearch, bagX, bagY, 0, 0, A_ScreenWidth, A_ScreenHeight, *24 files\bag.png
		if ErrorLevel = 1
		{
			if a_index > 2
			{
				KillScript = 1
				break
			}
			else
			{
				KillScript = 0
				continue
			}
		}
		else
			break
	}
	
	if KillScript = 1
	{
		Gui, Font, cRed 
		GuiControl, Font, ERROR 
		GuiControl,, ERROR, ERROR
		Gosub, ChangeServer2
	Return

	}
	else
	{
		Gui, Font, cGreen  
		GuiControl, Font, ERROR  
		GuiControl,, ERROR, GOOD
	
		Click %bagX%, %bagY%
		Send {o}
		GuiControl,RealmBuddy:, REALM, Waiting...
		realm = 
		Loop
		{
			PixelSearch, PCx, PCy, 0, 0, A_ScreenWidth, A_ScreenHeight, 0x3434E0, 0, Fast
				If ErrorLevel
				{
					PixelSearch, PCx, PCy, 0, 0, A_ScreenWidth, A_ScreenHeight, 0xE08460, 0, Fast
						If ErrorLevel
							break
				}
				Else
					Continue
		}
		
		HomeX := (bagX + 70)
		HomeY := (bagY + 187) 


		Click %HomeX%, %HomeY%
		Gosub, ChangeServer2
	Return
	}
}
Else
{
	MsgBox, 0x30,Required Window Title,The window specified in config file does not exist`nMake sure to edit config.ini or use the Settings option
return
}
ChangeServer2:
	KillScript = 0
	Loop
	{
		ImageSearch, positionX, positionY, 0, 0, A_ScreenWidth, A_ScreenHeight, *24 files\position.png
		if ErrorLevel = 1
		{
			if a_index > 25
			{
				KillScript = 1
				break
			}
			else
			{
				KillScript = 0
				Sleep 10
				continue				
			}
		}
		else
			break

	}
if KillScript = 1
{
	Gui, RealmBuddy:Font, cRed 
	GuiControl, RealmBuddy:Font, ERROR 
	GuiControl ,RealmBuddy:, ERROR, ERROR
Return
	
}
else
{
	Gui, RealmBuddy:Font, cGreen  
	GuiControl, RealmBuddy:Font, ERROR  
	GuiControl,RealmBuddy:, ERROR, GOOD
	GuiControl,RealmBuddy:, SERVER, %server%

	if StopAtCharScreen = 0 
	{
		MouseClick, Left, positionX-462, positionY+511 ; MAIN button
			Sleep 50
		MouseClick, Left, positionX-462, positionY+511 ; SERVERS button
			Sleep 50

			if scroll = 1
			{
				MouseClickDrag, L, positionX+13, positionY+101, positionX+13, positionY+481
			}
			MouseClick, Left, positionX - serverX, positionY + serverY ; Server name
			
			MouseClick, Left, positionX - 373, positionY + 515 ; DONE button
				Sleep 50
			MouseClick, Left, positionX - 373, positionY + 515 ; DONE button
				Sleep 50
			MouseMove, positionX - 382, positionY + 501
			GuiControlGet, CHAR, RealmBuddy:
			if CHAR = 0 
			{
				MouseClick, Left, positionX - 373, positionY + 515 ; DONE button
				Sleep 50
				MouseMove, positionX - 382, positionY + 221
			}
			IniWrite, %server%, config.ini,  Settings, LastServer
	} ; StopAtCharScreen
	
	
	StopAtCharScreen = 0

Return
}
; ...........................................................................
IfWinActive, %WinTitle%
{
FindRealmSubClick:
	PortalClicked = 1
	GoSub, FindRealmSub
return

FindRealmSub:
	MouseGetPos, mouseX, mouseY 
	ImageSearch, bagX, bagY, 0, 0, A_ScreenWidth, A_ScreenHeight, *24 files\bag.png

	EnterPor1X := (bagX + 50)
	EnterPor2X := (bagX + 115) 

	EnterPor1Y := (bagY + 191)
	EnterPor2Y := (bagY + 226)

	RealmName1X := (bagX - 5)
	RealmName2X := (bagX + 175)

	RealmName1Y := (bagY + 141)
	RealmName2Y := (bagY + 181)

	If PortalClicked
	{
		if mouseX > %EnterPor1X%  and mouseX < %EnterPor2X% and mouseY > %EnterPor1Y% and mouseY < %EnterPor2Y%
		{
			GoSub,FindRealm
		}
	}
	Else
	{
		GoSub, FindRealm
	}
	PortalClicked = 0
return
}


FindRealm:
	for k, v in arrayRealms {
		ImageSearch, realmX, realmY, %RealmName1X%, %RealmName1Y%, %RealmName2X%, %RealmName2Y%, *24 realms\%quality%\%v%.png
			if ErrorLevel
			{}
			else
			{
				realm = %v%
				GuiControl,RealmBuddy:, REALM, %v%
			}
	}
return



FastChat:
	Blockinput, on
	Send {Enter}
	Send ^a
	Send ^v
	Send {Enter}
	Blockinput, off
return

CallForEvent2:
	event_from_menu = 1
	GoSub, CallForEvent
return


CallForEvent:
	if (event_from_menu == 1)	{
		event := A_ThisMenuItem
	}
	else {
		event := A_GuiControl
		event := RegExReplace(event, "_", A_SPACE)
		
	}
	
	Loop, read, callouts.ini
	{
		callout := A_LoopReadLine
		StringSplit, callout, callout, =,
		if (callout1 == event) {
			event := callout2
			event := RegExReplace(event, "\$server", server)
			event := RegExReplace(event, "\$realm", realm)	
			break
		}
	}
	WinActivate, %WinTitle%
	clipboard = %event%
	GoSub, FastChat
	event_from_menu == 0
return

ServerGUISub:
CoordMode, Pixel, Screen
ImageSearch, bagX, bagY, 0, 0, A_ScreenWidth, A_ScreenHeight, *58 files/bag.png
	if errorlevel=0
	{
		ServGuiX := (bagX - 470)
		ServGuiY := (bagY - 300)
		InGame = 1
			
	
	}
	else
	{
		PixelSearch, Px, Py, 0, 0, A_ScreenWidth, A_ScreenHeight, 0x00FFEA, 0, Fast
		if ErrorLevel = 0 
		{
		ServGuiX := (Px - 564)
		ServGuiY := (Py + 31)
		InGame = 0
		}
		else
		{
		InGame = Error
		}
	}
CoordMode, Pixel, Relative
If InGame != Error
{
	GuiControl,ServersGUI:, RealmGui,%server%  %realm%%A_SPACE%
	Gui, ServersGUI:Show, x%ServGuiX% y%ServGuiY%, ServGUI
	WinActivate, %WinTitle%
	if InGame = 1
	{
		WinSet, TransColor, 363636 255, ServGUI
	}
	Else
	{
		WinSet, TransColor, 363636 255, ServGUI
	}
	KeyWait, %ServerGUIHotkey%
	Gui, ServersGUI:Show, Hide
	WinActivate, %WinTitle%
}
return


EventGuiSub:
CoordMode, Pixel, Screen
ImageSearch, bagX, bagY, 0, 0, A_ScreenWidth, A_ScreenHeight, *58 files/bag.png
	if errorlevel=0
	{	
		EventsGuiX := (bagX - 334)
		EventsGuiY := (bagY - 5)
		EventsGuiX := (EventsGuiX - (number_of_events * 39)/2) 

		InGame = 1
			
	
	}
	else
	{
	InGame = 0
	}
CoordMode, Pixel, Relative

if InGame = 1
{
	Gui,EventsGUI:Show, x%EventsGuiX% y%EventsGuiY%, EventsGUI
	WinActivate, %WinTitle%
	WinSet, TransColor, 363636 255, EventsGUI
	KeyWait, %EventGuiHotkey% 
	Gui, EventsGUI:Show, Hide
	WinActivate, %WinTitle%
}

return


RealmBuddyGuiClose: 
{
	IniWrite, %server%, config.ini,  Settings, LastServer
	ExitApp
}
return

;Commands... I'm not happy with this solution but for now I wasn't able to find anything better

::/euw::
	picked_server := "EUWest"
	Gosub, PickServer
return

::/euw2::
	picked_server := "EUWest2"
	Gosub, PickServer
return


::/eun::
	picked_server := "EUNorth"
	Gosub, PickServer
return

::/eun2::
	picked_server := "EUNorth2"
	Gosub, PickServer
return

::/eusw::
	picked_server := "EUSouthWest"
	Gosub, PickServer
return

::/eue::
	picked_server := "EUEast"
	Gosub, PickServer
return
::/usw::
	picked_server :="USWest"
	Gosub, PickServer
return 

::/usw2::
	picked_server :="USWest2"
	Gosub, PickServer
return 

::/use::
	picked_server :="USEast"
	Gosub, PickServer
return 

::/use2::
	picked_server :="USEast2"
	Gosub, PickServer
return 

::/use3::
	picked_server :="USEast3"
	Gosub, PickServer
return 

::/uss::
	picked_server :="USSouth"
	Gosub, PickServer
return 

::/uss2::
	picked_server :="USSouth2"
	Gosub, PickServer
return 

::/uss3::
	picked_server :="USSouth3"
	Gosub, PickServer
return 

::/ussw::
	picked_server :="USSouthWest"
	Gosub, PickServer
return 

::/usmw::
	picked_server :="USMidWest"
	Gosub, PickServer
return 

::/usmw2::
	picked_server :="USMidWest2"
	Gosub, PickServer
return 

::/usnw::
	picked_server :="USNorthWest"
	Gosub, PickServer
return 

::/ae::
	picked_server :="AsiaEast"
	Gosub, PickServer
return 

::/ase::
	picked_server :="AsiaSouthEast"
	Gosub, PickServer
return 
#NoEnv
#SingleInstance force
SendMode Input
SetWorkingDir %A_ScriptDir%
Thread,interrupt,0
#KeyHistory 0
#MaxThreads 255
#MaxMem 4095
#MaxThreadsBuffer On
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
Process, Priority, , R
SetTitleMatchMode fast
SetKeyDelay, -1, -1, -1
SetMouseDelay, -1
SetWinDelay, -1
SetControlDelay, -1
#Persistent

getaccelstate()
s:= "Script started in the [" getaccelstate() "] state"
TrayTip,Mouse Precision Enhancement,%s%,10
Return

Pause::
Reload
Return

F12::
ExitApp
Return

F11::
state := !state
RegWrite,REG_SZ,HKEY_CURRENT_USER,Control Panel\Mouse,MouseSpeed,%state%

if !state {
	TrayTip,Mouse Precision Enhancement,Enabled,10
} else {
	TrayTip,Mouse Precision Enhancement,Disabled,10
}
s:= "Changed to [" getaccelstate() "]"
TrayTip,Mouse Precision Enhancement,%s%,10
togglestate()


Return



getaccelstate() {
	global state,mthresh1,mthresh2
	RegRead,state,HKEY_CURRENT_USER,Control Panel\Mouse,MouseSpeed
	RegRead,mthresh1,HKEY_CURRENT_USER,Control Panel\Mouse,MouseThreshold1
	RegRead,mthresh2,HKEY_CURRENT_USER,Control Panel\Mouse,MouseThreshold2
	if !state
		s=Disabled
	else
		s=Enabled
	return s
}

;Notes: user32\SystemParametersInfoW has 4 args. Unused args set to 0 or NULL.
;		arg0: uiAction  //int indicating the action this call will perform
;		arg1: uiParam,  //int indicating add'l arguments. Mouse doesn't use this
;		arg2: pvParam,  //*void indicating where function data is stored/retrieved
;		arg3: fWinIni   //int, tells winmanager what to do if uiAction sets stuff
;		
togglestate() {
	global state,mthresh1,mthresh2
	VarSetCapacity(pvparam,256,0)		;PREPARE VARIABLE FOR HOLDING ARRAY
	Ptr := A_PtrSize ? "Ptr" : "UInt"	;COMPATIBILITY WITH OLDER AHK SCRIPTS
	SPI_GETMOUSE    := 0x0003
	SPI_SETMOUSE    := 0x0004
	SPIF_SENDCHANGE := 0x02
	rval := DllCall("user32\SystemParametersInfoW","UInt",SPI_GETMOUSE,"UInt",0,Ptr,&pvparam,"UInt",0,"Cdecl Int")
	if (ErrorLevel || !rval) {
		s := "First call. AHK Errorlevel:" ErrorLevel ", DLL return value: " rval
		TrayTip,DLL CALL FAILURE,%s%,10
		Return
	}
	NumPut(state,pvparam,8,"Int")
	;s:=  &pvparam "::" Ptr ":" rval ", Values: [" NumGet(pvparam,0,"Int") "], [" NumGet(pvparam,4,"Int") "], [" NumGet(pvparam,8,"Int") "], [" NumGet(pvparam,12,"Int") "]"
	;TrayTip,DEBUGSET,%s%
	rval := DllCall("user32\SystemParametersInfoW","UInt",0x0004,"UInt",0,Ptr,&pvparam,"UInt",SPIF_SENDCHANGE,"Cdecl Int")
	if (ErrorLevel || !rval) {
		s := "Second call. AHK Errorlevel:" ErrorLevel ", DLL return value: " rval
		TrayTip,DLL CALL FAILURE,%s%,10
		Return
	}
}



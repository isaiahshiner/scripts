#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force
ControlMusicBee = 1

DetectHiddenWindows, On

; Get the HWND of the Spotify main window.
getSpotifyHwnd() {
	WinGet, spotifyHwnd, ID, ahk_exe spotify.exe
	Return spotifyHwnd
}

; Send a key to Spotify.
spotifyKey(key) {
	spotifyHwnd := getSpotifyHwnd()
	; Chromium ignores keys when it isn't focused.
	; Focus the document window without bringing the app to the foreground.
	ControlFocus, Chrome_RenderWidgetHostHWND1, ahk_id %spotifyHwnd%
	ControlSend, , %key%, ahk_id %spotifyHwnd%
	Return
}

sendMusicBeeOrSpotify(mKey, sKey) {
	global
	if (ControlMusicBee) {
		Send %mKey% ; targets musicbee
	} else {
		spotifyKey(sKey) ; targets spotify
	}
	return
}

;For youtube controls
F21::
	Send ^w ;close tab
return

F17::
	Send f ;fullscreen
return

F13::
	Send g ;2x speed using Video Speed Controller extension
return

F22::
	Send j ;rewind 10 secs
return

F18::
	Send k ;pause
return

F14::
	Send l ;forward 10 secs
return

;For VSCode debug controls
^F22::
	Send ^{Numpad1} ;
return

^F18::
	Send ^{Numpad2}
return

^F14::
	Send ^{Numpad3}
return

^F21::
	Send ^{Numpad4}
return

^F17::
	Send ^{Numpad5}
return

^F13::
	Send ^{Numpad6}
return

;For MusicBee and spotify controls
+^F11:: ;used for when no mouse is avaialble
^F19::
	ControlMusicBee := !ControlMusicBee ; True by default, set at the top
return

; Next Song
^F12:: ; no mouse
$F15:: ; with mouse
	sendMusicBeeOrSpotify("{F15}", "^{Right}")
return

; Pause
^F11::
$F19::
	sendMusicBeeOrSpotify("{F19}", "{Space}")
return

; Previous Song
^F10::
$F23::
	sendMusicBeeOrSpotify("{F23}", "^{Left}")
return

; Volume Up
$^F16::
	sendMusicBeeOrSpotify("{^F16}", "^{Up}")
return

; Volume Down
$^F24::
	sendMusicBeeOrSpotify("{^F15}", "^{Down}")
return

; Seek forward
$F16::
	sendMusicBeeOrSpotify("{F16}", "+{Right}")
return

; Seek backward
$F24::
	sendMusicBeeOrSpotify("{F24}", "+{Left}")
return

;For MusicBee status display when no mouse is available
^F9::
	Send {F20}
return

;Disable numlock, could be used for another hotkey
NumLock::
return


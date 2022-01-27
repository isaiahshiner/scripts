;Default AHK env settings.
#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance, Force

ControlMusicBee = 1 ; Global toggle for controlling MusicBee or Spotify
DetectHiddenWindows, On ; Detect spotify if it's mimimized to the system tray

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

; Pause Song
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

; For MusicBee status display when no mouse is available
^F9::
	Send {F20}
return

; Disable numlock, could be used for another hotkey
NumLock::
return

; For youtube controls
F21::
	Send ^w ; Close tab
return

F17::
	Send f ; Fullscreen
return

F13::
	Send g ; 2x speed using Video Speed Controller extension
return

F22::
	Send j ; Rewind 10 secs
return

F18::
	Send k ; Pause
return

F14::
	Send l ; Forward 10 secs
return

; For VSCode debug controls
; Numpad allows use of controls when no mouse is available.
^F22::
	Send ^{Numpad1} ; Step over
return

^F18::
	Send ^{Numpad2} ; Step into
return

^F14::
	Send ^{Numpad3} ; Step out
return

^F21::
	Send ^{Numpad4} ; Start debugging
return

^F17::
	Send ^{Numpad5} ; Restart debugging
return

^F13::
	Send ^{Numpad6} ; Stop debugging
return

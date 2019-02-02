/*
    Script to run druid PL
    Make sure to have yourself targeted when you start the script
*/

; Forces only one instance of this script
#SingleInstance force

; Set application path
sbLocation = "E:\Shadowbane-SBEmu2.1\Shadowbane - Throne of Oblivion - SBEmu 2.1\sb.exe"

; Variables to keep track of repeated skills
; AOE state
aState := True
; Secondary State
sState := 1

/* 
    If our scripted window isn't running then launch it
    and give it our unique title
*/
IfWinNotExist sbLock
{
    ; run, %sbLocation%
    WinWaitActive, Shadowbane
    WinSetTitle, Shadowbane, , sbLock
}
; Get window's unique identifier
WinGet, sbID, ID, sbLock

; Launch script with Window Key + Alt + 1
!#1::
Loop
{
    ; Thorns
    ControlSend,, 3, ahk_id %sbID%
    ; 3 second cast time
    sleep, 4000
	
    ; Fires aoe twice
    Loop, 2
    {
		; target self
		ControlSend,, {End}, ahk_id %sbID%
        ; EQ
        ControlSend,, 1, ahk_id %sbID%
        ; 6 second cast time
        sleep, 6500
		; Call Lightning
        ControlSend,, 2, ahk_id %sbID%
        ; 3 second cast time
        sleep, 3500
        ; 10 sec cooldown
        If aState
            sleep, 10000
        aState := not aState
    }
    
    /*
        Secondary ability
        order is:
        - State 1 = heal (4)
        - State 2 = stam heal (5)
        - State 3 = heal (6)
    */
    if sState = 1
    {
        ; heal "Regrowth"
        ControlSend,, 4, ahk_id %sbID%
        ; Cast time 2.5 sec
        sleep, 2500
        ; Remaining Thorns duration
        sleep, 20000
        sState++
    }
    else if sState = 2
    {
        ; Stance
		ControlSend,, c, ahk_id %sbID%
		sleep, 500
        ControlSend,, 5, ahk_id %sbID%
		sleep, 700
		ControlSend,, c, ahk_id %sbID%
		sleep, 500

		; Single Target Blight
		ControlSend,, `;, ahk_id %sbID%
		sleep, 500
		ControlSend,, 6, ahk_id %sbID%
		sleep, 3500
		ControlSend,, {End}, ahk_id %sbID%
		
        ; Remaining AoE cooldown
        sleep, 20000
        sState := 1
    }
}

; Pause pauses the script
Pause::Pause
; Escape closes the script
Esc::ExitApp

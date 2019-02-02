/*
    Macro to run track:
        - Assumes track assigned to tilde
    
    Will pause on enter press so that you can type,
    and resume on second enter press.
    
    Will pause when you hold down middle mouse button
    to reposition camera.
    
    Escape exits the app.
*/

#singleInstance forced

^`::
{
    tracking := true
    winGet, trackID, ID, Shadowbane
    
    loop
    {
        getKeyState, mmbState, MButton
        if tracking and (mmbState = "U")
        {
            controlSend,, ``, ahk_id %trackID%
        }
        sleep, 500
    }
}

esc::
{
    exitApp
}

; Pause pauses the script
Pause::Pause

$r::
{
	tracking := false
	Send, r
	return
}

$enter::
{
	if tracking
	{
		tracking := false
    }
	else
	{
    	tracking := true
    }
	Send, {enter}
	return
}
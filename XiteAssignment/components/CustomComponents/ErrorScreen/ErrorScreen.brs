' ----------------------------------------------------------------
REM : This component contains some configuration & focus handling related code for Error Sceen
' ----------------------------------------------------------------

sub init()
    m.top.setFocus(true)
    m.tempTimer = CreateObject("roSGNode", "Timer")
    m.tempTimer.duration = 2
    m.tempTimer.repeat = false
    m.tempTimer.observeField("fire", "removeErrorScreen")
    m.tempTimer.control = "start"
end sub

' ----------------------------------------------------------------
REM : Error Sceen is removed here
' ----------------------------------------------------------------
sub removeErrorScreen()
    m.tempTimer = invalid
    m.top.dismiss = true
end sub

' ----------------------------------------------------------------
REM : This method gets called when any remote key is pressed at Error Sceen
' ----------------------------------------------------------------
function onKeyEvent(key as String, press as Boolean) as Boolean
    result = true
    if press
    end if
    return result
end function

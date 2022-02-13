' ----------------------------------------------------------------
REM : This is the parent scene of the application and contains some events which are executed when app launches
' ----------------------------------------------------------------

' ----------------------------------------------------------------
REM : This method checks internet connection and makes api call accordingly
' ----------------------------------------------------------------
sub init()
    if (getDeviceData().isInternetAvailable)
        m.top.showProgressDialog = true
        fetchMusicVideos()
    else
        m.top.errorTitle = getErrorTitle()
        m.top.errorMessage = getInternetErrorMessage()
        m.top.showErrorDialog = true
    end if
end sub

' ----------------------------------------------------------------
REM : This method gets called when any remote key is pressed
' ----------------------------------------------------------------
function onKeyEvent(key as String, press as Boolean) as Boolean
    result = false
    return result
end function

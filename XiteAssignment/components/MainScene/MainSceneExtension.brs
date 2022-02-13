' ----------------------------------------------------------------
REM : This component contains all the utility code used in Main Scene
' ----------------------------------------------------------------

' ----------------------------------------------------------------
REM : This method presents Error Dialog
' ----------------------------------------------------------------
sub onErrorDialogShown()
    if m.rokuAlert = invalid
        m.rokuAlert =  m.top.createChild("DialogUtility")
    end if
    m.rokuAlert.errorTitle = m.top.errorTitle
    m.rokuAlert.errorMessage = m.top.errorMessage
    m.rokuAlert.enableErrorDialog = true
end sub

' ----------------------------------------------------------------
REM : This method hides Error Dialog
' ----------------------------------------------------------------
sub onErrorDialogHidden()
    if m.top.dialog <> invalid
        m.top.dialog.close = true
    end if
    m.rokuAlert = invalid
end sub

' ----------------------------------------------------------------
REM : This method presents Progress Dialog
' ----------------------------------------------------------------
sub onProgressDialogShown()
    if m.rokuAlert = invalid
        m.rokuAlert =  m.top.createChild("DialogUtility")
    end if
    m.rokuAlert.enableProgressDialog = true
end sub

' ----------------------------------------------------------------
REM : This method hides Progress Dialog
' ----------------------------------------------------------------
sub onProgressDialogHidden()
    m.rokuAlert.disableProgressDialog = true
    m.rokuAlert = invalid
end sub



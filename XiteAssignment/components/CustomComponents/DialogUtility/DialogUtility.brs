' ----------------------------------------------------------------
REM : This component contains some utility methods which are to be used throughout the application for showing Progress & Error Dialogs
' ----------------------------------------------------------------

' ----------------------------------------------------------------
REM : Common variables are initialized here 
' ----------------------------------------------------------------
sub init()
    m.top.setFocus(false)
end sub

' ----------------------------------------------------------------
REM : This method presents Progress Dialog 
' ----------------------------------------------------------------
sub onProgressDialogEnabled()
    if m.top.isProgressDialogVisible <> true
        pdialogAuth = CreateObject("roSGNode", "ProgressDialog")
        pdialogAuth.title = "Please wait..."
        pdialogAuth.setFocus(false)
        m.top.isProgressDialogVisible = true
        m.top.getScene().dialog = pdialogAuth
    end if
end sub

' ----------------------------------------------------------------
REM : This method hides Progress Dialog
' ----------------------------------------------------------------
sub onProgressDialogDisabled()
    m.top.isProgressDialogVisible = false
    if m.top.getScene().dialog <> invalid
        m.top.getScene().dialog.close = true
    end if
end sub

' ----------------------------------------------------------------
REM : This method presents Error Dialog
' ----------------------------------------------------------------
sub onErrorDialogEnabled()
    if m.top.isErrorDialogVisible <> true
        m.top.isErrorDialogVisible = true
        errorDialog = CreateObject("roSGNode", "Dialog")
        errorDialog.ObserveField("wasClosed", "onDialogWasClosed")
        errorDialog.title = m.top.errorTitle
        errorDialog.optionsDialog = true
        errorDialog.iconUri = ""
        errorDialog.message = m.top.errorMessage
        errorDialog.width = 1200
        errorDialog.buttons = ["OK"]
        errorDialog.optionsDialog = true
        errorDialog.observeField("buttonSelected", "removeErrorDialog")
        m.top.getScene().dialog = errorDialog
    end if
end sub

' ----------------------------------------------------------------
REM : This method hides Error Dialog
' ----------------------------------------------------------------
sub removeErrorDialog()
    m.top.isErrorDialogVisible = false
    m.top.getScene().hideErrorDialog = true
end sub

' ----------------------------------------------------------------
REM : This method gets called when the dialog has been closed
' ----------------------------------------------------------------
sub onDialogWasClosed()
    m.top.getScene().exitApp = "exitApp"
end sub

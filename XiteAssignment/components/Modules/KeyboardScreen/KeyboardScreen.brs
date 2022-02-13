' ----------------------------------------------------------------
REM : This component contains some configuration & focus handling related code for Keyboard Screen
' ----------------------------------------------------------------

sub init()
    m.top.setFocus(true)
    configUI()
end sub

' //**** All the Keyboard Screen related components are being initialized in this method ****//
sub configUI()
    m.prevText = "Search content here...."

    m.keyboardContainer = m.top.findNode("keyboardContainer")
    m.keyboard = m.top.findNode("keyboard")
    m.keyboard.textEditBox.secureMode = false

    m.doneButtonContainer = m.top.findNode("doneButtonContainer")
    m.doneButton = m.top.findNode("doneButton")
    m.doneButton.observeField("buttonSelected", "doneButtonTapped")
    m.doneLabel = m.top.findNode("doneLabel")
end sub

' //**** This method sets focus on the Done Button ****//
sub setFocusOnDoneButton()
    m.doneButton.setFocus(true)
    addBorderToRectangleWithBorderWidth(m.doneButtonContainer, 5, "#FFFFFF")
end sub

' //**** This method removes focus from the Done Button ****//
sub removeFocusFromDoneButton()
    m.doneButton.setFocus(false)
    removeBorderFromRectangle(m.doneButtonContainer)
end sub

' //**** This method sets focus on the Keyboard ****//
sub setFocusOnKeyboard()
    m.keyboard.setFocus(true)
end sub

' //**** This method removes focus from the Keyboard ****//
sub removeFocusFromKeyboard()
    m.keyboard.setFocus(false)
end sub

' //**** This method sets focus to the focusable item at Keyboard Screen ****//
sub setFocusOnRequiredComponent()
    if m.currentFocus = "Keyboard"
        setFocusOnKeyboard()
        removeFocusFromDoneButton()
    else if m.currentFocus = "DoneButton"
        setFocusOnDoneButton()
        removeFocusFromKeyboard()
    end if
end sub

' //**** This method shows native keyboard ****// 
sub showNativeKeyboard()
    m.prevText = m.top.keyboardText
    m.currentFocus = "Keyboard"
    setFocusOnRequiredComponent()

    if m.top.keyboardText.Len() <> 0 and m.top.keyboardText <> "Search content here...."
        m.keyboard.textEditBox.text =  m.top.keyboardText
        m.keyboard.textEditBox.cursorPosition = m.top.keyboardText.Len()
    else
        m.keyboard.textEditBox.text = ""
    end if
end sub

' //**** This method gets data from keyboard ****// 
sub getTextFromKeyBoard()
    if m.keyboard.text.Len() = 0
        m.prevText = "Search content here...."
    else
        m.prevText = m.keyboard.text
    end if
    m.top.parent.searchKey = m.prevText
end sub

' //**** This method gets called when user taps Done button from Keybaord ****//
sub doneButtonTapped()
    getTextFromKeyBoard()
end sub

' //**** This method gets called when any key from remote is pressed ****// 
function onKeyEvent(key as String, press as Boolean) as Boolean
    result = true
    if press
        if key = "up"
            if m.currentFocus = "DoneButton"
                m.currentFocus = "Keyboard"
                setFocusOnRequiredComponent()
            end if
            result = true
        else if key = "down"
            if m.currentFocus = "Keyboard"
                m.currentFocus = "DoneButton"
                setFocusOnRequiredComponent()
            end if
            result = true
        else if key = "left"
            result = true
        else if key = "right"
            result = true
        else if key = "Ok"
            result = true
        else if key = "back"
            m.top.dismiss = true
            result = true
        end if
    end if
    return result
end function
' ----------------------------------------------------------------
REM : This component contains some configuration & focus handling related code for DropDown
' ----------------------------------------------------------------

' ----------------------------------------------------------------
REM : All UI components are being intialized here
' ----------------------------------------------------------------
sub init()
    configUI()
end sub

' ----------------------------------------------------------------
REM : All the UI specific fields for DropDown are configurd here
' ----------------------------------------------------------------
sub configUI()
    m.dropDownList = m.top.findNode("dropDownList")
    m.doneButtonContainer = m.top.findNode("doneButtonContainer")
    m.doneButtton = m.top.findNode("doneButtton")
    m.doneButtton.observeField("buttonSelected", "removeDropDown")
end sub

' ----------------------------------------------------------------
REM : All the UI specific fields for DropDown are getting populated with some data here
' ----------------------------------------------------------------
sub onDropDownContentReceived()
    if m.top.dropDownContent <> invalid
        if m.top.contentType = "release_year"
            m.dropDownList.itemSize = [200, 80]
        else
            m.dropDownList.itemSize = [450, 80]
        end if

        m.dropDownList.content = getDropDownData()
        m.dropDownList.checkedState = m.top.dropDownStates
        m.dropDownList.setFocus(true)

        animateToItem = 0
        for index = 0 to m.top.dropDownStates.count() - 1
            if m.top.dropDownStates[index]
                animateToItem = index
                exit for
            end if
        end for
        m.dropDownList.jumpToItem = animateToItem

        rect = m.dropDownList.boundingRect()
        centerx = (getDeviceData().displayWidth - rect.width) / 2
        m.dropDownList.translation = [centerx, 70]
    else
        m.top.stFocus(true)
    end if
end sub

' ----------------------------------------------------------------
REM : This method loads DropDown
' ----------------------------------------------------------------
function getDropDownData() as Object
    parentContentNode = CreateObject("roSGNode", "ContentNode")

    for each item in m.top.dropDownContent
        data = parentContentNode.CreateChild("ContentNode")
        if m.top.contentType = "release_year"
            data.title = item.release_year.toStr()
        else
            data.title = item.name
        end if
    end for
    return parentContentNode
end function

' ----------------------------------------------------------------
REM : DropDown is removed here
' ----------------------------------------------------------------
sub removeDropDown()
    if m.top.contentType = "release_year"
        m.top.parent.releaseYearStates = m.dropDownList.checkedState
    else if m.top.contentType = "genre"
        m.top.parent.genreStates = m.dropDownList.checkedState
    end if
end sub

' ----------------------------------------------------------------
REM : This method gets called when any remote key is pressed at DropDown
' ----------------------------------------------------------------
function onKeyEvent(key as String, press as Boolean) as Boolean
    result = true
    if press
        if key = "back"
            m.top.dismiss = true
        else if key = "up"
            if m.doneButtton.hasFocus()
                m.dropDownList.setFocus(true)
                removeBorderFromRectangle(m.doneButtonContainer)
            end if
        else if key = "down" or key = "left" or key = "right"
            if m.dropDownList.hasFocus()
                m.doneButtton.setFocus(true)
                addBorderToRectangleWithBorderWidth(m.doneButtonContainer, 5, "#FFFFFF")
            end if
        end if
    end if
    return result
end function

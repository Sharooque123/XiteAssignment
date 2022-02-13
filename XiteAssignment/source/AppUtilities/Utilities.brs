' ----------------------------------------------------------------
REM : This components contains some utilities methods which are to be used throughout the application
' ----------------------------------------------------------------

' ----------------------------------------------------------------
REM : This method provides device's meta data
' ----------------------------------------------------------------
function getDeviceData() as Object
    deviceStatus = {}
    deviceInfo = CreateObject("roDeviceInfo")
    
    displaySize = deviceInfo.GetDisplaySize()
    deviceStatus.displayHeight = displaySize.h
    deviceStatus.displayWidth = displaySize.w
    deviceStatus.isInternetAvailable = deviceInfo.GetLinkStatus()

    return deviceStatus
end function

REM : **** This Method adds border to a given Rectanngle object with given width & color ****
function addBorderToRectangleWithBorderWidth(rectangle as object,borderWidth as Integer,color as String)
    removeBorderFromRectangle(rectangle)
    m.rectTop=createObject("roSGNode", "Rectangle")
    m.rectTop.id = "border1"
    m.rectTop.width = rectangle.width
    m.rectTop.height = borderWidth
    m.rectTop.color = color
    m.rectTop.translation = [0, 0]
    
    m.rectBottom=createObject("roSGNode", "Rectangle")
    m.rectBottom.id = "border2"
    m.rectBottom.width = rectangle.width
    m.rectBottom.height = borderWidth
    m.rectBottom.color = color
    m.rectBottom.translation = [0, rectangle.height-borderWidth]
    
    m.rectLeft=createObject("roSGNode", "Rectangle")
    m.rectLeft.id = "border3"
    m.rectLeft.width = borderWidth
    m.rectLeft.height = rectangle.height
    m.rectLeft.color = color
    m.rectLeft.translation = [0, 0]
    
    m.rectRight=createObject("roSGNode", "Rectangle")
    m.rectRight.id = "border4"
    m.rectRight.width = borderWidth
    m.rectRight.height = rectangle.height
    m.rectRight.color = color
    m.rectRight.translation = [rectangle.width-borderWidth,0]


    m.rectMain = createObject("roSGNode", "Rectangle")
    m.rectMain.id = "mainBorder"
    m.rectMain.width = rectangle.width
    m.rectMain.height = rectangle.height
    m.rectMain.color = "#ffffff00"
    m.rectMain.appendChild(m.rectTop)
    m.rectMain.appendChild(m.rectBottom)
    m.rectMain.appendChild(m.rectLeft)
    m.rectMain.appendChild(m.rectRight)

    rectangle.appendChild(m.rectMain)
end function

REM : **** This Method removes border from a given Rectanngle object ****
function removeBorderFromRectangle(rectangle as object)
    if rectangle <> invalid
        for index = 0 to rectangle.getChildCount() - 1
            rect = rectangle.getChild(index)
            if rect <> invalid and (rect.id = "mainBorder")
                rectangle.removeChild(rect)
            end if
        end for
    end if
end function

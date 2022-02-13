' ----------------------------------------------------------------
REM : This is the entry point of application. Code inside this component gets executed when app is launched
' ----------------------------------------------------------------

sub Main()
    showChannelSGScreen()
end sub

sub showChannelSGScreen()
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    scene = screen.CreateScene("MainScene")
    screen.show()
    scene.observeField("exitApp", m.port)
    while (true)
        msg = Wait(0, m.port)
        msgType = Type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        else if msgType = "roSGNodeEvent"
            if msg.GetData() = "exitApp"
                screen.Close()
            end if
        end if
    end while
end sub

' ----------------------------------------------------------------
REM : This component contains some configuration & focus handling related code for Player Screen
' ----------------------------------------------------------------

' ----------------------------------------------------------------
REM : All UI components are being intialized here
' ----------------------------------------------------------------
sub init()
    m.top.setFocus(true)
end sub

' ----------------------------------------------------------------
REM : Video is configured and streamed in this method
' ----------------------------------------------------------------
sub onConfigureVideo()
    if m.videoPlayer <> invalid
        if m.videoPlayer.state = "playing" or m.videoPlayer.state = "buffering" or m.videoPlayer.state = "paused"
            m.videoPlayer.control = "stop"
            m.videoPlayer = invalid
        end if
    end if
    m.videoPlayer = m.top.findNode("videoPlayer")
    m.videoPlayer.observeField("state", "OnVideoPlayerStateChange")

    videoContent = CreateObject("roSGNode", "ContentNode")

    videoContent.AdaptiveMaxStartBitrate = 564000
    videoContent.AdaptiveMinStartBitrate = 16000

    videoContent.url = getVideoUrl()
    videoContent.streamFormat = getStreamFormat()
    videoContent.title = "Sample Video"

    m.videoPlayer.content = videoContent
    m.videoPlayer.visible = true
    m.videoPlayer.control = "play"
    m.videoPlayer.setFocus(true)
end sub

' ----------------------------------------------------------------
REM : This method gets called when any remote key is pressed at Player Screen
' ----------------------------------------------------------------
function onKeyEvent(key as String, press as Boolean) as Boolean
    result = true
    if press
        if key = "back"
            goBackToMovieScreen()
        end if
    end if
    return result
end function

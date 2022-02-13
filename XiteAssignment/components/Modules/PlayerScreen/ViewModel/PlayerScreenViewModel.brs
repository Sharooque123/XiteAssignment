' ----------------------------------------------------------------
REM : All the business logic for Player Screen has been written here
' ----------------------------------------------------------------

' ----------------------------------------------------------------
REM : This method gets called whenever state of video player is changed
' ----------------------------------------------------------------
sub OnVideoPlayerStateChange()
    if m.videoPlayer.state = "finished" or m.videoPlayer.state = "error"
        goBackToMovieScreen()
    end if
end sub

' ----------------------------------------------------------------
REM : This method takes useer to Movie Screen
' ----------------------------------------------------------------
sub goBackToMovieScreen()
    if m.videoPlayer <> invalid
        m.videoPlayer.unobserveField("state")
        m.videoPlayer.control = "stop"
        m.videoPlayer = invalid
    end if
    m.top.dismiss = true
end sub

' ----------------------------------------------------------------
REM : This method identifies the stram format and returns the same
' ----------------------------------------------------------------
function getStreamFormat() as String
    streamFormat = ""
    url = getVideoUrl()
    if url.InStr(".mp4") <> - 1
        if url.InStr(".m3u8") <> - 1
            streamFormat = "hls"
        else
            streamFormat = "mp4"
        end if
    else if url.InStr("mpd") <> - 1
        streamFormat = "dash"
    end if
    return streamFormat
end Function
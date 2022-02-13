' ----------------------------------------------------------------
REM : All the business logic for Main Scene has been written here
' ----------------------------------------------------------------

' ----------------------------------------------------------------
REM : This method triggers Music Videos Api call
' ----------------------------------------------------------------
sub fetchMusicVideos()
    m.musicVideosDataTask = CreateObject("roSGNode", "MusicVideosDataTask")
    m.musicVideosDataTask.observeField("content", "onMusicVideosDataReceived")
    m.musicVideosDataTask.control = "RUN"
end sub

' ----------------------------------------------------------------
REM : This method gets called when response is received from Music Videos Api
' ----------------------------------------------------------------
sub onMusicVideosDataReceived()
    m.top.hideProgressDialog = true
    taskResponse = m.musicVideosDataTask.content
    m.musicVideosDataTask.control = "STOP"
    m.musicVideosDataTask = invalid
    
    if taskResponse.error
        m.top.errorTitle = getErrorTitle()
        m.top.errorMessage = getCustomErrorMessage()
        m.top.showErrorDialog = true
    else
        showLandingScren(taskResponse.videos, taskResponse.genres, taskResponse.videosByReleaseYears)
    end if
end sub

' ----------------------------------------------------------------
REM : This method presents Landing Screen
' ----------------------------------------------------------------
sub showLandingScren(videos as Object, genres as Object, videosByReleaseYears as Object)
    m.landingScreen = m.top.createChild("LandingScreen")
    m.landingScreen.ObserveField("dismiss", "onRemoveLandigScreen")
    m.landingScreen.visible = true
    m.landingScreen.setFocus(true)
    m.landingScreen.genres = genres
    m.landingScreen.releaseYears = videosByReleaseYears
    m.landingScreen.pageContent = videos
end sub

' ----------------------------------------------------------------
REM : This method gets called when remote back key is pressed at Landing Screen
' ----------------------------------------------------------------
sub onRemoveLandigScreen()
    if m.landingScreen <> invalid
        m.top.removeChild(m.landingScreen)
        m.landingScreen = invalid
        m.top.currrentScreenReference = m.top
        m.top.exitApp = "exitApp"
    end if
end sub

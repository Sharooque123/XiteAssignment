' ----------------------------------------------------------------
REM : This component contains MusicVideos Api call & parsing logic
' ----------------------------------------------------------------

sub init()
    m.top.functionName = "getMusicVideosData"
end sub

' ----------------------------------------------------------------
REM : MusicVideos Data Task is invoked in this method
' ----------------------------------------------------------------
sub getMusicVideosData()
    urlPath = getBaseUrl()
    urlEndPoint = getMusicVidosDataTaskEndPoint()
    urlPath = urlPath + urlEndPoint
    params = ""
    jsonObject = apiCallWithGetRequest(urlPath, invalid)
    response = CreateObject("roSGNode", "Status")
    if jsonObject <> invalid
        if (jsonObject.videos <> invalid and jsonObject.videos.count() <> 0) And (jsonObject.genres <> invalid and jsonObject.genres.count() <> 0)
            response.error = false
            response.videos = parseVideosData(jsonObject.videos)
            m.videos = response.videos
            response.genres = parseGenresData(jsonObject.genres)
            response.videosByReleaseYears = getVideosByReleaseYear(m.videos)
        else
            response.error = true
        end if
    else
        response.error = true
    end if
    m.top.content = response
end sub

' ----------------------------------------------------------------
REM : Videos Data is parsed in this method
' ----------------------------------------------------------------
function parseVideosData(videos as Object) as Object
    videosData = []
    for index = 0 to videos.count() - 1
        videoModel = CreateObject("roSGNode", "Videos")
        model = videos[index]

        image_url = ""
        if model.image_url <> invalid
            image_url = model.image_url
        end if
        videoModel.image_url = image_url

        title = ""
        if model.title <> invalid
            title = model.title
        end if
        videoModel.title = title

        artist = ""
        if model.artist <> invalid
            artist = model.artist
        end if
        videoModel.artist = artist

        if model.id <> invalid
            videoModel.id = model.id
        end if

        if model.genre_id <> invalid
            videoModel.genre_id = model.genre_id
        end if

        if model.release_year <> invalid
            videoModel.release_year = model.release_year
        end if
        videosData.Push(videoModel)
    end for
    return videosData
end function

' ----------------------------------------------------------------
REM : Genres Data is parsed in this method
' ----------------------------------------------------------------
function parseGenresData(genres as Object) as Object
    genresData = []
    for index = 0 to genres.count() - 1
        genreModel = CreateObject("roSGNode", "Genres")
        model = genres[index]

        name = ""
        if model.name <> invalid
            name = model.name
        end if
        genreModel.name = name

        if model.id <> invalid
            genreModel.id = model.id

            videos = []
            for each video in m.videos
                if model.id = video.genre_id
                    videos.Push(video)
                end if
            end for
            genreModel.videos = videos
        end if
        genresData.Push(genreModel)
    end for
    return genresData
end function

' ----------------------------------------------------------------
REM : Release Years Data is parsed in this method
' ----------------------------------------------------------------
function getVideosByReleaseYear(videos as Object) as Object
    releaseYearData = []
    for index = 0 to videos.count() - 1
        isExist = validateReleaseYear(videos[index].release_year, releaseYearData)

        if isExist = false
            releaseYearModel = CreateObject("roSGNode", "ReleaseYears")
            releaseYearModel.release_year = videos[index].release_year
            videosWithSameReleaseYears = []
            for myIndex = 0 to videos.count() - 1
                if videos[index].release_year = videos[myIndex].release_year
                    videosWithSameReleaseYears.Push(videos[myIndex])
                end if
            end for
            releaseYearModel.videos =  videosWithSameReleaseYears
            releaseYearData.Push(releaseYearModel)
        end if
    end for
    return releaseYearData
end function

' ----------------------------------------------------------------
REM : This method validates existance of a Release Year in the given source
' ----------------------------------------------------------------
function validateReleaseYear(videoReleaseYear as Integer, source as Object) as Boolean
    isExist = false
    if source.count() <> 0
        for each item in source
            if item.release_year = videoReleaseYear
                isExist = true
                exit for
            end if
        end for
    end if
    return isExist
end function
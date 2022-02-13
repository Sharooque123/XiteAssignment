' ----------------------------------------------------------------
REM : This components contains some constant strings/mssages/literels which are to be used throughout the application
' ----------------------------------------------------------------

Function getBaseUrl() as String
        return "https://raw.githubusercontent.com/XiteTV/frontend-coding-exercise/main/data/"
End Function

Function getMusicVidosDataTaskEndPoint() as String
        return "dataset.json"
End Function

Function getErrorTitle() as String
     return "Oops"     
end Function 

Function getInternetErrorMessage() as String
     return "You don't seem to have an internet connection. Please have one."     
end Function

Function getCustomErrorMessage() as String
     return "It seems to be a technical issue currently. Please try later."     
end Function 

function getVideoUrl() as String
    return "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
end function

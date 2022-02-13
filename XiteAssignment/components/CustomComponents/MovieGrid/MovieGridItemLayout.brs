' ----------------------------------------------------------------
REM : All UI components for Movie Grid are being intialized here
' ----------------------------------------------------------------
sub init()
    m.musicArtistLabel = m.top.findNode("musicArtistLabel")
    m.musicPoster = m.top.findNode("musicPoster")
    m.musicTitleLabel = m.top.findNode("musicTitleLabel")
end sub

' ----------------------------------------------------------------
REM : All UI components for MovieGrid are being populated with some data here
' ----------------------------------------------------------------
function itemContentChanged() as Void
    itemData = m.top.itemContent
    if itemData.musicTitle <> invalid
        m.musicTitleLabel.text = itemData.musicTitle
    end if

    if itemData.musicArtist <> invalid
        m.musicArtistLabel.text = itemData.musicArtist
    end if

    if itemData.musicPosterUrl <> invalid
        m.musicPoster.uri = itemData.musicPosterUrl
    end if
end function

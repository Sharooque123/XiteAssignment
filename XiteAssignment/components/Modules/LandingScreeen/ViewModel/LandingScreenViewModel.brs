' ----------------------------------------------------------------
REM : All the business logic for Landing Screen has been written here
' ----------------------------------------------------------------

sub initVariables()
    m.searchApplied = false
    m.genreFiterApplied = false
    m.yearFilterApplied = false
    m.filteredItems = []
    m.filteredYeas = []
    m.filteredGenres = []
end sub

' ----------------------------------------------------------------
REM : This method parses data for Movie Grid
' ----------------------------------------------------------------
function getMovieGridData(videos as Object) as Object
    data = CreateObject("roSGNode", "ContentNode")

    for index = 0 to videos.count() - 1
        dataItem = data.CreateChild("MovieGridItemData")
        model = videos[index]
        musicPosterUrl = ""
        if model.image_url <> invalid
            musicPosterUrl = model.image_url
        end if
        dataItem.musicPosterUrl = musicPosterUrl

        musicTitle = ""
        if model.title <> invalid
            musicTitle = model.title
        end if
        dataItem.musicTitle = musicTitle

        musicArtist = ""
        if model.artist <> invalid
            musicArtist = model.artist
        end if
        dataItem.musicArtist = musicArtist
    end for
    return data
end function

' ----------------------------------------------------------------
REM : Below section contains some methods written for handling DropDown
' ----------------------------------------------------------------
sub showRelaseYearsDropDown()
    m.filterType = "release_year"
    showDropDown(m.filterType)
end sub

sub showGenresDropDown()
    m.filterType = "genre"
    showDropDown(m.filterType)
end sub

sub showDropDown(dropDownType as String)
    m.dropDown = m.top.createChild("DropDownComponent")
    m.dropDown.ObserveField("dismiss", "onRemoveDropDown")
    m.dropDown.visible = true
    m.dropDown.setFocus(true)
    m.dropDown.contentType = dropDownType
    m.dropDown.parent = m.top
    if dropDownType = "release_year"
        m.dropDown.dropDownStates = getReleaseYearStates()
        m.dropDown.dropDownContent = m.top.releaseYears
    else if dropDownType = "genre"
        m.dropDown.dropDownStates = getGenresStates()
        m.dropDown.dropDownContent = m.top.genres
    end if
end sub

sub onRemoveDropDown()
    if m.dropDown <> invalid
        m.top.removeChild(m.dropDown)
        m.dropDown = invalid
        setFocusOnRequiredComponent()
    end if
end sub
' ----------------------------------------------------------------
' ----------------------------------------------------------------

' ----------------------------------------------------------------
REM : Below section contains some methods written for handling Keyboard Screen
' ----------------------------------------------------------------
sub showKeyboardScreen()
    m.keyboardScreen = m.top.createChild("KeyboardScreen")
    m.keyboardScreen.ObserveField("dismiss", "onRemoveKeyboardScreen")
    m.keyboardScreen.visible = true
    m.keyboardScreen.setFocus(true)
    m.keyboardScreen.parent = m.top
    m.keyboardScreen.keyboardText = m.searchLabel.text
end sub

sub onRemoveKeyboardScreen()
    if m.keyboardScreen <> invalid
        m.top.removeChild(m.keyboardScreen)
        m.keyboardScreen = invalid
        setFocusOnRequiredComponent()
    end if
end sub
' ----------------------------------------------------------------
' ----------------------------------------------------------------

' ----------------------------------------------------------------
REM : Below section contains some methods written for handling Error Screen
' ----------------------------------------------------------------
sub showErrorScreen()
    m.errorScreen = m.top.createChild("ErrorScreen")
    m.errorScreen.ObserveField("dismiss", "onRemoveErrorScreen")
    m.errorScreen.visible = true
    m.errorScreen.setFocus(true)
end sub

sub onRemoveErrorScreen()
    if m.errorScreen <> invalid
        m.top.removeChild(m.errorScreen)
        m.errorScreen = invalid
        setFocusOnRequiredComponent()
    end if
end sub
' ----------------------------------------------------------------
' ----------------------------------------------------------------

' ----------------------------------------------------------------
REM : Below section contains some methods written for handling Player Screen
' ----------------------------------------------------------------
sub showPlayerScreen()
    m.playerScreen = m.top.createChild("PlayerScreen")
    m.playerScreen.ObserveField("dismiss", "onRemovePlayerScreen")
    m.playerScreen.visible = true
    m.playerScreen.setFocus(true)
    m.playerScreen.configureVideo = true
end sub

sub onRemovePlayerScreen()
    if m.playerScreen <> invalid
        m.top.removeChild(m.playerScreen)
        m.playerScreen = invalid
        setFocusOnRequiredComponent()
    end if
end sub
' ----------------------------------------------------------------
' ----------------------------------------------------------------

' ----------------------------------------------------------------
REM : Below method validates if an array contains a value
' ----------------------------------------------------------------
function arrayContainsValue(sourceArray as Object, itemToSearch as Object) as Boolean
    contains = false
    if sourceArray.count() <> 0
        for each item in sourceArray
            if item.title = itemToSearch.title
                contains = true
                exit for
            end if
        end for
    end if
    return contains
end function

' ----------------------------------------------------------------
REM : Below method reloads movie grid with some new data
' ----------------------------------------------------------------
sub updateMovieGrid(source as Object)
    m.filteredItems = source
    m.movieGrid.content = getMovieGridData(m.filteredItems)
end sub

' ----------------------------------------------------------------
REM : Below method removes all the applied filtes and reloads movie grid
' ----------------------------------------------------------------
sub refreshList()
    if m.searchApplied or m.genreFiterApplied or m.yearFilterApplied
        initVariables()
        m.genresLabel.text = "Select genre"
        m.top.genreStates = []
        m.releaseYearLabel.text = "Select year"
        m.top.releaseYearStates = []
        m.searchLabel.text = "Search content here...."
        m.movieGrid.content = getMovieGridData(m.top.pageContent)
    end if
end sub

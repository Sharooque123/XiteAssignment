' ----------------------------------------------------------------
REM : This component contains some configuration & focus handling related code for Landing Screen
' ----------------------------------------------------------------

' ----------------------------------------------------------------
REM : All UI components are being intialized here
' ----------------------------------------------------------------
sub init()
    configUI()
end sub

' ----------------------------------------------------------------
REM : All the UI specific fields for Landing Screen are configurd here
' ----------------------------------------------------------------
sub configUI()
    m.movieGrid = m.top.findNode("movieGrid")
    m.movieGrid.observeField("itemSelected", "showPlayerScreen")

    m.searchTextBox = m.top.findNode("searchTextBox")
    m.searchButtton = m.top.findNode("searchButtton")
    m.searchLabel = m.top.findNode("searchLabel")
    m.searchButtton.observeField("buttonSelected", "showKeyboardScreen")

    m.releaseYearBox = m.top.findNode("releaseYearBox")
    m.releaseYearButtton = m.top.findNode("releaseYearButtton")
    m.releaseYearLabel = m.top.findNode("releaseYearLabel")
    m.releaseYearButtton.observeField("buttonSelected", "showRelaseYearsDropDown")

    m.genresBox = m.top.findNode("genresBox")
    m.genresButtton = m.top.findNode("genresButtton")
    m.genresLabel = m.top.findNode("genresLabel")
    m.genresButtton.observeField("buttonSelected", "showGenresDropDown")
    
    m.refreshBox = m.top.findNode("refreshBox")
    m.refreshButtton = m.top.findNode("refreshButtton")
    m.refreshLabel = m.top.findNode("refreshLabel")
    m.refreshButtton.observeField("buttonSelected", "refreshList")

    initVariables()
end sub

' ----------------------------------------------------------------
REM : All the UI specific fields for Landing Screen are getting populated with some data here
' ----------------------------------------------------------------
sub onPageContentReceived()
    if m.top.pageContent <> invalid
        m.movieGrid.content = getMovieGridData(m.top.pageContent)
        m.currentFocus = "MovieGrid"
    else
        m.currentFocus = "Self"
    end if
    setFocusOnRequiredComponent()
    m.top.signalBeacon("AppLaunchComplete")
end sub

' ----------------------------------------------------------------
REM : Below section contains focus handling related methods 
' ----------------------------------------------------------------
sub setFocusOnRequiredComponent()
    if m.currentFocus = "MovieGrid"
        setFocusOnMovieGrid()
        removeFocusFromGenreButton()
        removeFocusFromSearchButton()
        removeFocusFromYearButton()
        removeFocusFromRefreshButton()
    else if m.currentFocus = "GenreButton"
        setFocusOnGenreButton()
        removeFocusFromSearchButton()
        removeFocusFromYearButton()
        removeFocusFromMovieGrid()
        removeFocusFromRefreshButton()
    else if m.currentFocus = "SearchButton"
        setFocusOnSearchButton()
        removeFocusFromYearButton()
        removeFocusFromMovieGrid()
        removeFocusFromGenreButton()
        removeFocusFromRefreshButton()
    else if m.currentFocus = "YearButton"
        setFocusOnYearButton()
        removeFocusFromMovieGrid()
        removeFocusFromGenreButton()
        removeFocusFromSearchButton()
        removeFocusFromRefreshButton()
    else if m.currentFocus = "Self"
        setFocusOnSelf()
        removeFocusFromMovieGrid()
        removeFocusFromGenreButton()
        removeFocusFromSearchButton()
        removeFocusFromYearButton()
        removeFocusFromRefreshButton()
    else if m.currentFocus = "RefreshButton"
        setFocusOnRefreshButton()
        removeFocusFromMovieGrid()
        removeFocusFromGenreButton()
        removeFocusFromSearchButton()
        removeFocusFromYearButton()
    end if
end sub

sub setFocusOnRefreshButton()
    m.refreshButtton.setFocus(true)
    addBorderToRectangleWithBorderWidth(m.refreshBox, 5, "#FFFFFF")
end sub

sub removeFocusFromRefreshButton()
    m.refreshButtton.setFocus(false)
    removeBorderFromRectangle(m.refreshBox)
end sub

sub setFocusOnGenreButton()
    m.genresButtton.setFocus(true)
    addBorderToRectangleWithBorderWidth(m.genresBox, 5, "#FFFFFF")
end sub

sub removeFocusFromGenreButton()
    m.genresButtton.setFocus(false)
    removeBorderFromRectangle(m.genresBox)
end sub

sub setFocusOnSearchButton()
    m.searchButtton.setFocus(true)
    addBorderToRectangleWithBorderWidth(m.searchTextBox, 5, "#FFFFFF")
end sub

sub removeFocusFromSearchButton()
    m.searchButtton.setFocus(false)
    removeBorderFromRectangle(m.searchTextBox)
end sub

sub setFocusOnYearButton()
    m.releaseYearButtton.setFocus(true)
    addBorderToRectangleWithBorderWidth(m.releaseYearBox, 5, "#FFFFFF")
end sub

sub removeFocusFromYearButton()
    m.releaseYearButtton.setFocus(false)
    removeBorderFromRectangle(m.releaseYearBox)
end sub

sub setFocusOnMovieGrid()
    m.movieGrid.setFocus(true)
end sub

sub removeFocusFromMovieGrid()
    m.movieGrid.setFocus(false)
end sub

sub setFocusOnSelf()
    m.top.setFocus(true)
end sub
' ----------------------------------------------------------------
' ----------------------------------------------------------------

' ----------------------------------------------------------------
REM : This method gets called when any remote key is pressed at Landing Screen
' ----------------------------------------------------------------
function onKeyEvent(key as String, press as Boolean) as Boolean
    result = true
    if press
        if key = "back"
           m.top.dismiss = true
        else if key = "up"
            if m.movieGrid.hasFocus()
                m.currentFocus = "GenreButton"
            else if m.genresButtton.hasFocus()
                m.currentFocus = "SearchButton"
            else if m.releaseYearButtton.hasFocus()
                    m.currentFocus = "RefreshButton"
            end if
            setFocusOnRequiredComponent()
        else if key = "down"
            if m.releaseYearButtton.hasFocus() or m.genresButtton.hasFocus()
                m.currentFocus = "MovieGrid"
            else if m.searchButtton.hasFocus()
                m.currentFocus = "GenreButton"
            else if m.refreshButtton.hasFocus()
                m.currentFocus = "YearButton"    
            end if
            setFocusOnRequiredComponent()
        else if key = "left"
            if m.releaseYearButtton.hasFocus()
                m.currentFocus = "GenreButton"
            else if m.refreshButtton.hasFocus() 
                    m.currentFocus = "SearchButton"    
            end if
            setFocusOnRequiredComponent()
        else if key = "right"
            if m.genresButtton.hasFocus()
                m.currentFocus = "YearButton"
            else if m.searchButtton.hasFocus() 
                    m.currentFocus = "RefreshButton"    
            end if
            setFocusOnRequiredComponent()
        end if
    end if
    return result
end function

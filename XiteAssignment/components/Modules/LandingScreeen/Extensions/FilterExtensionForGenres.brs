' ----------------------------------------------------------------
REM : All the business logic for filtering content based on Genres has been written here
' ----------------------------------------------------------------

sub onGenreStatesChanged()
    onRemoveDropDown()
    if m.top.genreStates <> invalid and m.top.genreStates.count() <> 0
        filterGenres()
    end if
end sub

sub filterGenres()
    localCopy = []
    genresString = ""
    genresData = findGenresData()
    localCopy = genresData.Genres
    genresString = genresData.genreString

    if localCopy.count() > 0
        if (m.yearFilterApplied = false and m.searchApplied = false)
            updateMovieGridForGenres(localCopy, genresString)
        else
            filteredGenres = []
            if m.yearFilterApplied
                for each genre in localCopy
                    for each year in m.filteredYeas
                        if genre.release_year = year.release_year
                            filteredGenres.Push(genre)
                            exit for
                        end if
                    end for
                end for

                for each year in m.filteredYeas
                    for each genre in localCopy
                        if year.genre_id = genre.genre_id
                            if arrayContainsValue(filteredGenres, year) = false
                                filteredGenres.Push(year)
                            end if
                            exit for
                        end if
                    end for
                end for
                if filteredGenres.count() = 0
                    validateExistingFiltersForGenres()
                else
                    validateSearch(filteredGenres, genresString, "genre")
                end if
            else
                validateSearch(localCopy, genresString, "genre")
            end if
        end if
    else
        validateExistingFiltersForGenres()
    end if
end sub

function findGenresData() as Object
    genresData = CreateObject("roAssociativeArray")
    localCopy = []
    genresString = ""
    for index = 0 to m.top.genreStates.count() - 1
        if m.top.genreStates[index]
            for each video in m.top.genres[index].videos
                localCopy.Push(video)
            end for
            if genresString.Len() = 0
                genresString = m.top.genres[index].name
            else
                genresString = genresString + " | " + m.top.genres[index].name
            end if
        end if
    end for
    m.filteredGenres = localCopy
    genresData.AddReplace("Genres", localCopy)
    genresData.AddReplace("genreString", genresString)
    return genresData
end function

sub updateMovieGridForGenres(source as Object, filterStr as String)
    updateMovieGrid(source)
    m.genresLabel.text = filterStr
    m.genreFiterApplied = true
end sub

sub validateExistingFiltersForGenres()
    allUnchecked = true
    for each item in m.top.genreStates
        if item
            allUnchecked = false
            exit for
        end if
    end for
    if allUnchecked = false
        showErrorScreen()
    end if
    m.genreFiterApplied = false
    m.genresLabel.text = "Select genre"
    m.filteredItems = []
    m.top.genreStates = []
    m.filteredGenres = []
    if (m.searchApplied and m.yearFilterApplied) or (m.searchApplied = false and m.yearFilterApplied)
        filterYears()
    else if m.searchApplied and m.yearFilterApplied = false
        applyKeySearch()
    else if m.searchApplied = false and m.yearFilterApplied = false
        m.movieGrid.content = getMovieGridData(m.top.pageContent)
    end if
end sub

function getGenresStates() as Object
    if m.top.genreStates <> invalid and m.top.genreStates.count() <> 0
        return m.top.genreStates
    else
        states = []
        for each year in m.top.genres
            states.Push(false)
        end for
        return states
    end if
end function

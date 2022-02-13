' ----------------------------------------------------------------
REM : All the business logic for filtering content based on Release Years has been written here
' ----------------------------------------------------------------

sub onReleaseYearStatesChanged()
    onRemoveDropDown()
    if m.top.releaseYearStates <> invalid and m.top.releaseYearStates.count() <> 0
        filterYears()
    end if
end sub

sub filterYears()
    localCopy = []
    releaseYeasString = ""
    yearsData = findYearsData()
    localCopy = yearsData.Years
    releaseYeasString = yearsData.YearStr

    if localCopy.count() > 0
        if (m.genreFiterApplied = false and m.searchApplied = false)
            updateMovieGridForYears(localCopy, releaseYeasString)
        else
            filteredYears = []
            if m.genreFiterApplied
                for each year in localCopy
                    for each genre in m.filteredGenres
                        if year.genre_id = genre.genre_id
                            filteredYears.Push(year)
                            exit for
                        end if
                    end for
                end for

                for each genre in m.filteredGenres
                    for each year in localCopy
                        if genre.release_year = year.release_year
                            if arrayContainsValue(filteredYears, genre) = false
                                filteredYears.Push(genre)
                            end if
                            exit for
                        end if
                    end for
                end for
                if filteredYears.count() = 0
                    validateExstingFiltersForReleaseYears()
                else
                    validateSearch(filteredYears, releaseYeasString, "year")
                end if
            else
                validateSearch(localCopy, releaseYeasString, "year")
            end if
        end if
    else
        validateExstingFiltersForReleaseYears()
    end if
end sub

function findYearsData() as Object
    yearsData = CreateObject("roAssociativeArray")
    localCopy = []
    releaseYeasString = ""
    for index = 0 to m.top.releaseYearStates.count() - 1
        if m.top.releaseYearStates[index]
            for each video in m.top.releaseYears[index].videos
                localCopy.Push(video)
            end for
            if releaseYeasString.Len() = 0
                releaseYeasString = m.top.releaseYears[index].release_year.toStr()
            else
                releaseYeasString = releaseYeasString + " | " + m.top.releaseYears[index].release_year.toStr()
            end if
        end if
    end for
    m.filteredYeas = localCopy
    yearsData.AddReplace("Years", localCopy)
    yearsData.AddReplace("YearStr", releaseYeasString)
    return yearsData
end function

sub updateMovieGridForYears(source as Object, filterStr as String)
    updateMovieGrid(source)
    m.releaseYearLabel.text = filterStr
    m.yearFilterApplied = true
end sub

sub validateExstingFiltersForReleaseYears()
    allUnchecked = true
    for each item in m.top.releaseYearStates
        if item
            allUnchecked = false
            exit for
        end if
    end for
    if allUnchecked = false
        showErrorScreen()
    end if
    m.releaseYearLabel.text = "Select year"
    m.yearFilterApplied = false
    m.filteredItems = []
    m.top.releaseYearStates = []
    m.filteredYeas = []

    if (m.searchApplied and m.genreFiterApplied) or (m.searchApplied = false and m.genreFiterApplied)
        filterGenres()
    else if m.searchApplied and m.genreFiterApplied = false
        applyKeySearch()
    else if m.searchApplied = false and m.genreFiterApplied = false
        m.movieGrid.content = getMovieGridData(m.top.pageContent)
    end if
end sub

function getReleaseYearStates() as Object
    if m.top.releaseYearStates <> invalid and m.top.releaseYearStates.count() <> 0
        return m.top.releaseYearStates
    else
        states = []
        for each year in m.top.releaseYears
            states.Push(false)
        end for
        return states
    end if
end function
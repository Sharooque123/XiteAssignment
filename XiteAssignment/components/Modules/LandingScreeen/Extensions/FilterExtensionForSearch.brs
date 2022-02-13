' ----------------------------------------------------------------
REM : All the business logic for searching content based on some key has been written here
' ----------------------------------------------------------------

sub onSearchChanged()
    onRemoveKeyboardScreen()
    if m.top.searchKey = "Search content here...."
        validateExistingFiltesForSearch()
    else
        searchedItems = []
        if m.yearFilterApplied and m.genreFiterApplied
            if m.top.searchSource <> invalid and m.top.searchSource.count() = 0
                m.top.searchSource = m.filteredItems
            end if
            searchedItems = applySearch(m.top.searchSource)
        else if m.yearFilterApplied
            searchedItems = applySearch(m.filteredYeas)
        else if m.genreFiterApplied
            searchedItems = applySearch(m.filteredGenres)
        else
            searchedItems = applySearch(m.top.pageContent)
        end if
        if searchedItems.count() <> 0
            m.searchLabel.text = m.top.searchKey
            m.searchApplied = true
            m.filteredItems = searchedItems
            m.movieGrid.content = getMovieGridData(m.filteredItems)
        else
            showErrorScreen()
            validateExistingFiltesForSearch()
        end if
    end if
end sub

sub applySearch(source as Object) as Object
    searchedItems = []
    for each item in source
        itemTitle = LCase(item.title)
        key = LCase(m.top.searchKey)
        if itemTitle.InStr(key) <> - 1
            searchedItems.Push(item)
        end if
    end for
    return searchedItems
end sub

sub applyKeySearch()
    m.top.searchSource = m.top.pageContent
    searchedItems = applySearch(m.top.searchSource)
    if searchedItems.count() <> 0
        updateMovieGrid(searchedItems)
    end if
end sub

sub validateSearch(source as Object, filterString as String, flag as String)
    if m.searchApplied
        if m.top.searchSource <> invalid
            m.top.searchSource = source
        end if
        searchedItems = applySearch(m.top.searchSource)
        if searchedItems.count() = 0
            if flag = "year"
                validateExstingFiltersForReleaseYears()
            else
                validateExistingFiltersForGenres()
            end if
        else
            if flag = "year"
                updateMovieGridForYears(searchedItems, filterString)
            else
                updateMovieGridForGenres(searchedItems, filterString)
            end if
        end if
    else
        if flag = "year"
            updateMovieGridForYears(source, filterString)
        else
            updateMovieGridForGenres(source, filterString)
        end if
    end if
end sub

sub validateExistingFiltesForSearch()
    m.searchLabel.text = "Search content here...."
    m.searchApplied = false
    m.filteredItems = []
    if (m.yearFilterApplied and m.genreFiterApplied) or m.yearFilterApplied
        filterYears()
    else if m.genreFiterApplied
        filterGenres()
    else if m.yearFilterApplied = false and m.genreFiterApplied = false
        m.movieGrid.content = getMovieGridData(m.top.pageContent)
    end if
end sub
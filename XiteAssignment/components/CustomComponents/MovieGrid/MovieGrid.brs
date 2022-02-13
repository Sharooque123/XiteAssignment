' ----------------------------------------------------------------
REM : Movie Grid is being configured here 
' ----------------------------------------------------------------
sub init()
    m.top.itemComponentName = "MovieGridItemLayout"
    m.top.numRows = 3
    m.top.numColumns = 4
    m.top.itemSize = [430, 350]
    m.top.rowHeights = [350]
    m.top.columnWidths = [430]
    m.top.itemSpacing = [30, 30]
    m.top.visible = true
    m.top.vertFocusAnimationStyle = "fixedFocus"
    m.top.drawFocusFeedbackOnTop = true
    m.top.drawFocusFeedback = true
end sub
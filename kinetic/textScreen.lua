function showTextScreen(strings)
    _update60=updateTextScreen
    _draw=drawTextScreen
    textStrings=strings
end

function updateTextScreen()
    if (btnp(btnJump) or btnp(btnWhip)) sfx(30) showTitleScreen()
end

function drawMenuScreen()
    cls(12)
    rect(0,0,127,127,1)
    drawTitle(24,6)

    color(0)
end

function drawTextScreen()
    drawMenuScreen()
    
    for segment in all(split(textStrings,'|')) do
        tokens=split(segment,';')
        print(tokens[1],tokens[2],tokens[3])
    end
end
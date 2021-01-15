function showLevelSelect()
    _update60=updateLevelSelect
    _draw=drawLevelSelect
    option=min(#levels,beatLevel+1)
    levelNames={}
    for i=1,option do
        name=levels[i].name
        if perfectLevels&(1<<i)!=0 then
            name=name..",15"
        end
        add(levelNames,name)
    end
end

function updateLevelSelect()
    if (btnp(btnWhip)) sfx(31) showTitleScreen()
    if (btnp(btnJump)) sfx(30) beginGame(levels[option])
    adjustOption(#levelNames)
end

function drawLevelSelect()
    drawMenuScreen()
    palt(12)

    print("level select",40,32)

    drawMenuOptions(42,levelNames)
end
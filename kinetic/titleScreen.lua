function showTitleScreen()
    _update60=updateTitleScreen
    _draw=drawTitleScreen
    showMenu=false
    music(-1,100)
    menuitem(1)
    menuitem(2)
end

function adjustOption(menuMax)
    if (btnp(3)) option+=1 sfx(29)
    if (btnp(2)) option-=1 sfx(29)
    option=clamp(option,1,menuMax)
end

function updateTitleScreen()
    if showMenu then
        if btnp(btnJump) then
            sfx(30)
            titleAccept()
            return
        elseif btnp(btnWhip) then
            sfx(31)
            showMenu=false
        end
        adjustOption(3)
    else
        if btnp(btnJump) then
            sfx(30)
            showMenu=true
            option=1
        end
    end
end

function drawTitle(startX,startY)
    sspr(0,56,40,8,startX,startY,80,16)
end

titleOptions={
    "55,66,start",
    "40,79,instructions",
    "50,69,credits"
}

function drawMenuOptions(posY,menuOptions)
    for i=1,#menuOptions do
        startX,endX,text,bonusSprite=unpack(split(menuOptions[i]))
        if option==i then
            spr(117,startX-8,posY-2)
            spr(118,endX+8,posY-2)
        end
        if bonusSprite then
            spr(bonusSprite,startX-18,posY-2)
        end
        print(text,startX,posY)
        posY+=9
    end
end

function drawTitleScreen()
    cls(12)

    palt(0b1000000000001000)
    map(unpack(split("0,48,0,0,16,16")))
    palt(0b0000000000001000)
    spr(unpack(split("10,29,80,1,1,1")))
    line(29,84,12,84,11)

    drawTitle(24,20)

    color(0)
    if showMenu then
        drawMenuOptions(52,titleOptions)
    else
        print("press 🅾️",48,60)
    end
end

function titleAccept()
    if option==1 then
        showLevelSelect()
    elseif option==2 then
        showInstructions()
    else
        showCredits()
    end
end
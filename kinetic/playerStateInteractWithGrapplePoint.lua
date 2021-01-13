psGrapMod={
    start=function()        
        player.facing=sgn(playerGrap.pos.x-player.pos.x)
        _update60=updateOnlyPlayer
    end,
    stop=function()
        _update60=updateDefault
    end,
    update=function()
        if (btnp(0)) changeGrapType(-1)
        if (btnp(1) or btnp(btnJump)) changeGrapType(1)
    end,
    checkTransition=function()
        if (btnp(btnWhip)) return psGrap
    end,
    draw=drawWhipToGrap
}
setmetatable(psGrapMod,ps)

function changeGrapType(delta)
    sfx(28)
    currentTypeIndex=indexOf(grapTypes,playerGrap.type)
    newTypeIndex=currentTypeIndex+delta
    if (newTypeIndex<1) newTypeIndex+=#grapTypes
    if (newTypeIndex>#grapTypes) newTypeIndex-=#grapTypes
    setGrapType(playerGrap,grapTypes[newTypeIndex])
end
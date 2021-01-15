function createGrap(pos,type)
    grap={
        pos=pos,
        collisionRect=unitRect,
        type=grapBasic,
        minimapColor=11
    }
    setGrapType(grap,type)
    add(graps,grap)
end

function setGrapType(grap,type)
    if grap.type!=grapBasic then
        for mod in all(grapMods) do
            if (mod.pos==grap.pos) del(grapMods,mod)
        end
    end
    if type!=grapBasic then
        grapMod={
            pos=grap.pos,
            type=type,
            collisionRect=grappleModColRect
        }
        absorbTable(grapMod,type)
        add(grapMods,grapMod)
    end
    grap.type=type
    grap.anim=startAnim(type.anim)
end

grapBasic={
    anim=16
}
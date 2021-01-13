function flipVelX(grapMod,collider)
    collider.vel.x=-collider.vel.x
    return true
end

function flipVelY(grapMod,collider)
    collider.vel.y=-collider.vel.y
    if collider==player and collider.vel.y<0 then
        collider.vel.y=min(collider.vel.y,btn(btnJump) and -0.4 or -0.25)
    end
    return true
end

function passThroughPortal(grapMod,collider)
    otherType=grapMod.type==portalA and portalB or portalA
    nearest=nil
    nearestDist=1000
    for otherMod in all(grapMods) do
        if otherMod.type==otherType then
            dist=#(grapMod.pos-otherMod.pos)
            if dist < nearestDist then
                nearest = otherMod
                nearestDist=dist
            end
        end
    end
    if nearest then
        collider.latestMod=nearest
        collider.pos=nearest.pos
        collider.vel=-1*collider.vel
        return true
    end
end

function thrust(grapMod,collider)
    alignment=collider.vel:dot(grapMod.thrustDir)
    collider.vel+=max(0.3,0.3-alignment)*grapMod.thrustDir
    return true
end

function grapModCollide(grapMod,collider)
    if (collider.latestMod==grapMod and collider.latestModTicks>0) return
    collider.latestMod=grapMod
    collider.latestModTicks=30
    if grapMod:collisionResponse(collider) and not collider.isDummy then
        sfx(grapMod.modSfx)
    end
end

grappleModColRect=rectString("-0.375,-0.375,0.375,0.375")

portalA={
    collisionResponse=passThroughPortal,
    numbers=
[[anim=19
modSfx=55]]
}

portalB={
    collisionResponse=passThroughPortal,
    numbers=
[[anim=20
modSfx=55]]
}

function makeThruster(animNum,x,y)
    return {
        anim=animNum,
        collisionResponse=thrust,
        thrustDir=vec2(x,y),
        modSfx=62
    }
end

allGrapTypes={
    grapBasic,
    {
        collisionRect=rectString("-0.25,-0.5,0.25,0.5"),
        collisionResponse=flipVelX,
        numbers=
[[anim=17
modSfx=54]]
    },
    {
        collisionRect=rectString("-0.5,-0.25,0.5,0.25"),
        collisionResponse=flipVelY,
        numbers=
[[anim=18
modSfx=54]]
    },
    portalA,
    portalB,
    makeThruster(21,0,-0.5),
    makeThruster(22,0.5,0),
    makeThruster(277,0,1),
    makeThruster(-22,-0.5,0)
}
foreach(allGrapTypes,parseNumbers)
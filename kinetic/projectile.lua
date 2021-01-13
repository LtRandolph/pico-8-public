function createProj(pos,vel,sourceMachine,def,isDummy)
    proj={
        pos=pos,
        anim=startAnim(def.animIdle,5),
        update=updateProj,
        vel=vel,
        isDummy=false,
        sourceMachine=sourceMachine,
        collisionRect=rectString("-0.25,-0.25,0.25,0.25"),
        isDummy=isDummy
    }
    absorbTable(proj,def)

    if (not isDummy) sfx(def.launchSfx)

    add(projs,proj)
    return proj
end

function updateProj(proj)
    updateProjLifetime(proj)
    if (proj.dead) return

    proj.vel.y+=proj.gravity

    collisionRect=getCollisionRect(proj)
    collided,collideT,collideNormal=collideWithMap(collisionRect,proj.vel,3)

    if collided then
        collisionPos=proj.pos+collideT*proj.vel
        proj:terrainCollision(collisionPos,collideNormal)
        return
    end

    proj.pos+=proj.vel

    if not proj.isDummy then
        collideType(proj,enemies,projHitEnemy)
    end

    collideType(proj,grapMods,grapModCollide)

    updateAnim(proj.anim)
end

function projDeathEffect(proj,hitEnemy,pos)
    createEffect(4,EDPixelSpray(pos,proj.impactEffectColors,vec2(1,0),1,0.05,0.12,5.5,8))
    if (not proj.isDummy) sfx(hitEnemy and proj.hitSfx or proj.missSfx)
end

function projCollision(proj,collisionPos,normal,hitEnemy)
    del(projs,proj)
    proj.dead=true
    if (proj.isDummy) return
    
    projDeathEffect(proj,hitEnemy,collisionPos)
end

function projHitEnemy(enemy,proj)
    if (proj.dead) return
    projCollision(proj,0.5*(enemy.pos+proj.pos),nil,true)
    enemyTakeDamage(enemy)
end

function sparkTerrain(proj,collisionPos,collisionNormal)
    proj.speed=allMachineTypes[4].launchSpeed
    if (collisionNormal.x!=0) proj.vel.x=0
    if (collisionNormal.y!=0) proj.vel.y=0
    if (#proj.vel==0) proj.vel=vec2(collisionNormal.y,collisionNormal.x)
    proj.vel:normalize()
    proj.vel=proj.speed*proj.vel
    proj.update=updateSpark
    proj.down=-proj.speed*collisionNormal
    proj.pos=collisionPos+proj.vel
end

function updateSpark(proj)
    updateProjLifetime(proj)
    if (proj.dead) return
    
    collisionRect=getCollisionRect(proj)
    if collideWithMap(collisionRect,proj.vel,3) then
        swapVal=proj.vel
        proj.vel=-proj.down
        proj.down=swapVal
    elseif not collideWithMap(collisionRect,proj.down,3) then
        swapVal=proj.vel
        proj.vel=proj.down
        proj.down=-swapVal
    end

    proj.pos+=proj.vel

    if not proj.isDummy then
        collideType(proj,enemies,projHitEnemy)
    end

    updateAnim(proj.anim)
end

function updateProjLifetime(proj)
    if proj.lifetime then
        proj.lifetime-=1
        if proj.lifetime==0 then
            del(projs,proj)
            proj.dead=true
            if (not proj.isDummy) projDeathEffect(proj,false,proj.pos)
        end
    end
end

function traceDummyProj(machine,callback)
    dummyProj=machineMakeProj(machine,true)
    if (not dummyProj) return
    
    dummyProj.isDummy=true

    while not dummyProj.dead do
        dummyProj:update()
        callback(dummyProj)
    end
end

pinkGoo={
    impactEffectColors={8,14},
    terrainCollision=projCollision,
    numbers=
[[gravity=0.00625
minimapColor=14
launchSfx=44
missSfx=45
hitSfx=46
animIdle=48]]
}
parseNumbers(pinkGoo)

blueDart={
    animIdle={right={53},diag={54},up={55}},
    impactEffectColors={1,13},
    terrainCollision=projCollision,
    numbers=
[[minimapColor=12
gravity=0
launchSfx=59
missSfx=60
hitSfx=61]]
}
parseNumbers(blueDart)

yellowSpark={
    impactEffectColors={9,10},
    terrainCollision=sparkTerrain,
    numbers=
[[minimapColor=10
gravity=0
lifetime=90
launchSfx=56
missSfx=57
hitSfx=58
animIdle=32,33,288,-289,-32,289,-288,33]]
}
parseNumbers(yellowSpark)
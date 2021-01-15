squidBasics=
[[speed=0.0125
jumpSpeed=0.04666
minimapColor=8
gravity=0.002666
animUp=102
animDown=103
animLand=100,101,100
animCrouch=100,101
animWalk=96,97,98,99
]]

tankBasics=
[[speed=0.0075
jumpSpeed=0.035
minimapColor=8
gravity=0.0015
animWalk=80,81,82
animCrouch=83,84
animLand=84,83,80
animUp=85,86,87
animDown=85,86,87
]]

squidA={
    numbers=squidBasics ..
[[deathFXColor=5
health=2
palette=5,2,3,4,5,6,7,10]]
}
squidB={
    numbers=squidBasics ..
[[deathFXColor=1
health=3
palette=1,2,3,4,5,6,7,8]]
}
squidC={
    numbers=squidBasics ..
[[deathFXColor=0
health=4
palette=0,2,3,4,5,6,7,2]]
}
parseNumbers(squidA)
parseNumbers(squidB)
parseNumbers(squidC)

tankA={
    numbers=tankBasics ..
[[deathFXColor=3
health=4
palette=3,2,3,4,5,6,7,7]]
}
tankB={
    numbers=tankBasics ..
[[deathFXColor=1
health=5
palette=1,2,3,4,5,6,7,8]]
}
tankC={
    numbers=tankBasics ..
[[deathFXColor=0
health=6
palette=0,2,3,4,5,6,7,2]]
}
parseNumbers(tankA)
parseNumbers(tankB)
parseNumbers(tankC)

function createEnemy(def)
    spawnPos=entryDoor.pos
    targetPos=exitDoor.pos

    local enemy={
        pos=spawnPos,
        target=targetPos,
        anim=startAnim(def.animWalk,16),
        update=updateEnemy,
        behavior=behaveWalk,
        facing=sgn(targetPos.x-spawnPos.x),
        collisionRect=rectString("-0.375,-0.5,0.375,0.375"),
        whipStunTicks=-90,
        maxHealth=def.health
    }
    absorbTable(enemy,def)
    enemy.defaultFacing=enemy.facing
    enemy.vel=vec2(enemy.facing*enemy.speed,0.125)
    enemyCheckTile(enemy)
    add(enemies,enemy)

    enemyMove(enemy)
end

function enemyMove(enemy)
    enemy.vel.y+=enemy.gravity
    enemy.pos+=collideMove(collisRect(enemy),enemy.vel)
end

function updateEnemy(enemy)
    enemy:behavior()

    if (enemy.defaultFacing*(enemy.pos.x-enemy.target.x)>0) enemyArrived(enemy)

    if enemy.whipStunTicks>-90 then
        enemy.whipStunTicks-=1
    end

    if enemy.whipStunTicks<=-1 then
        updateAnim(enemy.anim)
    end
end

function drawEnemy(enemy)
    pal(split(enemy.palette))
    drawGameObject(enemy)
    center=8*enemy.pos
    if enemy.whipStunTicks>=0 then
        theta=enemy.whipStunTicks/20
        pset(center.x+cos(theta)*4,center.y+sin(theta)-4,10)
    end
    leftX=center.x-4
    y=center.y+4
    line(leftX+enemy.maxHealth-1,y,leftX,y,0)
    color(8)
    line(leftX+enemy.health-1,y)
end

function behaveWalk(enemy)
    if (enemy.whipStunTicks>=0) return
    
    enemyMove(enemy)

    if (enemy.vel.y!=0) startBehaveAir(enemy)

    enemyCheckTile(enemy)
end

function startBehaveAir(enemy)
    enemy.behavior=behaveAir
    enemy.anim=startAnim(enemy.vel.y>0 and enemy.animDown or enemy.animUp,8)
end

function behaveAir(enemy)
    offsetX=enemy.nextTile.x+0.5-enemy.pos.x
    if enemy.speed>=abs(offsetX) then
        enemy.pos.x+=offsetX
        enemy.vel.x=0
    end

    wasGoingUp=enemy.vel.y<0
    enemyMove(enemy)

    if collidedAxes.y!=0 then
        enemy.behavior=behaveLand
        enemy.landTicks=16
        enemy.anim=startAnim(enemy.animLand,6)
    elseif wasGoingUp!=(enemy.vel.y<0) then
        enemy.anim=startAnim(enemy.vel.y>0 and enemy.animDown or enemy.animUp,8)
    end
end

function behaveLand(enemy)
    if (enemy.whipStunTicks>=0) return

    enemy.landTicks-=1
    if enemy.landTicks==0 then
        enemy.vel=vec2(enemy.facing*enemy.speed,0)
        enemy.anim=startAnim(enemy.animWalk,16)
        enemy.behavior=behaveWalk
    end
end

function behavePrepJump(enemy)
    if (enemy.whipStunTicks>=0) return

    jumpStartPos=enemy.currentTile+halfVec
    offset=jumpStartPos-enemy.pos

    enemy.facing=sgn(offset.x)

    if enemy.speed>=abs(offset.x) then
        enemy.pos.x=jumpStartPos.x
        enemy.vel.x=0
        if enemy.vel.y==0 then
            enemy.facing=enemy.defaultFacing
            enemy.behavior=behaveCrouch
            enemy.crouchTicks=30
            enemy.anim=startAnim(enemy.animCrouch,15,false)
        end
    else
        enemy.vel.x=enemy.speed*enemy.facing
    end
    
    enemyMove(enemy)
end

function behaveCrouch(enemy)
    if (enemy.whipStunTicks>=0) return

    enemy.crouchTicks-=1
    if enemy.crouchTicks==0 then
        enemy.vel=enemyJumpVel(enemy,enemy.currentTile,enemy.nextTile)
        startBehaveAir(enemy)
    end
end

function enemyArrived(enemy)
    removeEnemy(enemy)
    lives-=1
    if lives==0 then
        defeat()
    else        
        sfx(41)
    end
end

function removeEnemy(enemy)
    del(enemies,enemy)
end

function enemyJumpVel(enemy,startPos,endPos)
    offset=endPos-startPos
    t=abs(offset.x)/enemy.jumpSpeed
    return vec2(sgn(offset.x)*enemy.jumpSpeed,offset.y/t-0.5*enemy.gravity*t)
end

function enemyCheckTile(enemy)
    currentTile=enemy.pos:floored()
    if currentTile!=enemy.currentTile then
        currentInfo=getTileInfo(currentTile)
        if currentInfo and #currentInfo.nextTiles>0 then
            enemy.nextTile=rnd(currentInfo.nextTiles)
            if #(currentInfo.nextTiles[1]-currentTile)==1 and rnd(1)<0.4 then
                enemy.nextTile=currentInfo.nextTiles[1]
            end
            offset=enemy.nextTile-currentTile

            jumping=offset.x!=enemy.defaultFacing or offset.y<0

            enemy.behavior=jumping and behavePrepJump or behaveWalk
        end
        enemy.currentTile=currentTile
    end
end

function enemyTakeDamage(enemy)
    enemy.health-=1
    if enemy.health<=0 then
        removeEnemy(enemy)
        createEffect(4,EDPixelSpray(enemy.pos,enemy.deathFXColor,vec2(1,0),1,0.05,0.12,8.5,10))
    end
end
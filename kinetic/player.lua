pCollision=rectString("-0.375,-0.5,0.25,0.375")
pAnimWalk="1,2,1,3"
pAnimSpin,
pAnimStop,
pAnimUp,
pAnimDown,
pAnimPeak,
pAnimAdjust,
pAnimGrapForward,
pAnimGrapUp,
pAnimGrapBack=unpack(split("4,5,6,7,8,11,12,13,14"))
pAnimWhip="9,10"

function setPlayerSpawnPos(pos)
    pSpawnPos=pos
end

function initPlayer()
    player={
        pos=pSpawnPos,
        vel=vec2(0,0),
        anim=startAnim(pAnimWalk,-1),
        facing=-enemyDir,
        collisionRect=pCollision,
        minimapColor=7
    }
    pState=psGround
    pAirFrames=0
    pState.start()
    
    player.pos+=collideMove(getCollisionRect(player),vec2(0,0.125))
end

function updatePlayer()
    dx=0
    if (btn(0)) dx-=1
    if (btn(1)) dx+=1

    onGround=collideWithMap(getCollisionRect(player),vec2(0,0.01),3)

    if onGround then
        player.immuneToEnemies=false
        pAirFrames=0
    else
        pAirFrames+=1
    end

    if player.latestModTicks then
        player.latestModTicks-=1
        if (player.latestModTicks==0) then
            player.latestModTicks=nil
            player.latestMod=nil
        end
    end

    collideType(player,enemies,pCollideWithEnemy)

    newState=pState.checkTransition()
    if newState then
        pTransitionState(newState)
    end

    pState.update()

    updateAnim(player.anim)
end

function pTransitionState(newState)
    pState.stop()
    pLastState=pState
    pState=newState
    pState.start()
end

function drawWhip()
    if player.whipEnd then
        whipStartPixel=8*(player.pos+player.whipStart)
        whipEndPixel=8*player.whipEnd
        line(whipStartPixel.x,whipStartPixel.y,whipEndPixel.x,whipEndPixel.y,11)
    end
end

function drawPlayer()
    drawGameObject(player)
    pState.draw()
end

function pAirUpdate(gravity)
    player.vel.y=min(player.vel.y+gravity,0.25)
    pControl(0.005,0,0.00625,true)
    
    collideType(player,grapMods,grapModCollide)

    if player.vel.y<-0.05 then
        moveAnim=pAnimUp
    elseif player.vel.y>0.05 then
        moveAnim=pAnimDown
    else
        moveAnim=pAnimPeak
    end

    if moveAnim!=player.anim.sourceAnim or player.anim.frameTime<0 then
        player.anim=startAnim(moveAnim,12)
    end
end

function pControl(accel,decel,turnAccel,canGoExtraFast)
    if dx==0 then
        player.vel.x-=sgn(player.vel.x)*min(abs(player.vel.x),decel)
    elseif sgn(player.vel.x)!=sgn(dx) then
        player.vel.x+=dx*turnAccel
    else
        maxSpeed=0.125
        if canGoExtraFast then
            maxSpeed=max(maxSpeed,abs(player.vel.x))
        end
        player.vel.x+=dx*min(maxSpeed-abs(player.vel.x),accel)
    end

    posDelta,clearAxes=collideMove(getCollisionRect(player),player.vel,3)
    player.pos+=posDelta

    if (clearAxes.x!=0) player.vel.x=0
    if (clearAxes.y!=0) player.vel.y=0

    if not player.lockFacing then
        if dx!=0 then
            player.facing=sgn(dx)
        end
    end
end

function pCollideWithEnemy(enemy,p)
    if (player.immuneToEnemies or _update60!=updateDefault) return
    player.immuneToEnemies=true
    player.vel=vec2(0.2*sgn(player.pos.x-enemy.pos.x),-0.3)
    pTransitionState(psAir)
    sfx(37)
end
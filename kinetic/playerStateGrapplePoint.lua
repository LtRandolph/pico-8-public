function drawWhipToGrap()
    offset=player.pos-grapplePos
    whipStart=8*player.pos-(2/#offset)*offset
    line(whipStart.x,whipStart.y,8*grapplePos.x,8*grapplePos.y,11)

    pixelCenter=(8*player.pos):floored()

    fromWhip=vec2FromAngle(grappleAngle)
    
    sleevePixelSpot=pixelCenter-1*fromWhip
    pset(sleevePixelSpot.x,sleevePixelSpot.y,6)
    handPixelSpot=pixelCenter-1.6*fromWhip
    pset(handPixelSpot.x,handPixelSpot.y,4)

    fracPosX=frac(handPixelSpot.x)
    fracPosY=frac(handPixelSpot.y)
    if abs(fracPosX-0.5)>abs(fracPosY-0.5) then
        handPixelSpot.x+=(fracPosX>0.5) and 1 or -1
    else
        handPixelSpot.y+=(fracPosY>0.5) and 1 or -1
    end
    pset(handPixelSpot.x,handPixelSpot.y,4)
end

psGrap={
    start=function()
        if (pLastState==psGrapMod) return

        grapplePos=playerGrap.pos
        offset=player.pos-grapplePos
        grappleAngle=offset:atan()
        whipLength=max(#offset,1.5)
        circumference=2*pi*whipLength
        
        player.facing=-sgn(offset.x)
    end,
    update=function()
        oldPos=player.pos
        player.vel.y=min(player.vel.y+0.00625,0.25)
        player.pos+=player.vel

        offset=player.pos-grapplePos

        length=#offset
        angle=offset:atan()
        if length>whipLength then
            oldAngle=grappleAngle
            if (abs(oldAngle-angle)>0.5) oldAngle+=(angle>oldAngle and 1 or -1)

            distanceTravelled=#player.vel
            angleTravelled=distanceTravelled/circumference

            grappleAngle=oldAngle+angleTravelled*sgn(angle-oldAngle)

            player.pos=grapplePos+whipLength*vec2FromAngle(grappleAngle)
            player.vel=player.pos-oldPos
        else
            grappleAngle=angle
        end

        forwardSpeed=player.vel.x*player.facing
        if forwardSpeed>0.0125 then
            player.anim=startAnim(pAnimGrapBack,-1)
        elseif forwardSpeed<-0.0125 then
            player.anim=startAnim(pAnimGrapForward,-1)
        else
            player.anim=startAnim(pAnimGrapUp,-1)
        end
    end,
    checkTransition=function()
        if (btnp(btnJump)) return psJump
        if (btnp(btnWhip) and #grapTypes>1) return psGrapMod
    end,
    draw=drawWhipToGrap
}
setmetatable(psGrap,ps)
psGround={
    update=function()
        pControl(0.00625,0.005,0.00625)
    
        moveAnim=nil
    
        if dx!=0 then
            if sgn(dx)==sgn(player.vel.x) then
                moveAnim=pAnimWalk
            else
                moveAnim=pAnimSpin
            end
        elseif abs(player.vel.x)>0 then
            moveAnim=pAnimStop
        else
            moveAnim=pAnimWalk
        end
    
        if moveAnim and (moveAnim!=player.anim.sourceAnim or player.anim.frameTime<0) then
            player.anim=startAnim(moveAnim,12)
        elseif dx==0 and player.vel.x==0 then
            player.anim=startAnim(moveAnim,-1)
        end
    end,
    checkTransition=function()
        if (btnp(btnWhip)) return psWhip
        if (btnp(btnJump)) return psJump
        if (pAirFrames>0) return psAir
    end
}
setmetatable(psGround,ps)
psWhip={
    start=function()
        player.lockFacing=true
    
        player.whippingTicks=30
        player.anim=startAnim(pAnimWhip,8,true)

        sfx(34)
    end,
    stop=function()
        player.lockFacing=false
        player.whippingTicks=nil
        player.whipEnd=nil
    end,
    update=function()
        player.whippingTicks-=1

        dx=0

        if pAirFrames>0 then
            player.vel.y=min(player.vel.y+psAir.getGravity(),0.25)
            pControl(0.005,0,0.00625,true)
        else
            pControl(0.00625,0.01,0.00625)
        end

        if player.whippingTicks<23 then
            player.whipStart=vec2(player.facing*0.5,0)
            player.whipEnd=player.pos+player.facing*vec2(2.5,0)
        end
    end,
    checkTransition=function()
        if (player.whippingTicks==0) return pAirFrames>0 and psAir or psGround

        if player.whipEnd then
            whipRect=player.facing>0 and rectangle(player.pos,player.whipEnd) or rectangle(player.whipEnd,player.pos)
            collideType(player,enemies,whipEnemy,whipRect)
            if whipRect:overlaps(getCollisionRect(waveButton)) then
                whipWaveButton()
                return
            end
            for machine in all(machines) do
                if whipRect:overlaps(getCollisionRect(machine)) then
                    whipMachine=machine
                    sfx(35)
                    return psAdjustMachine
                end
            end
            for grap in all(graps) do
                if whipRect:overlaps(getCollisionRect(grap)) then
                    playerGrap=grap
                    sfx(35)
                    return psGrap
                end
            end
        end
    end,
    draw=drawWhip
}
setmetatable(psWhip,ps)

function whipEnemy(enemy,p)
    if enemy.whipStunTicks<=-90 then
        sfx(36)
        enemy.whipStunTicks=45
    end
end
psJump={
    update=function()
        pAirUpdate(0.00625)
    end,
    start=function()
        sfx(32)
        player.vel.y=min(player.vel.y,-0.25)
    end,
    checkTransition=function()
        if (btnp(btnWhip)) return psWhip
        if not btn(btnJump) or player.vel.y>0 then
            pAirFrames=10
            return psAir
        end
    end
}
setmetatable(psJump,ps)
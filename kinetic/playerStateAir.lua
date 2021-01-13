psAir={
    getGravity=function()
        if player.vel.y<0 then
            return 0.015
        else
            return 0.01
        end
    end,
    update=function()
        pAirUpdate(psAir.getGravity())
    end,
    checkTransition=function()
        if (btnp(btnWhip)) return psWhip
        if (pAirFrames<6 and btnp(btnJump)) return psJump
        if (pAirFrames==0) sfx(33) return psGround
    end
}
setmetatable(psAir,ps)
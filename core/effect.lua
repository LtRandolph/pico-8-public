function initEffects()
    effects={}
end

function EDPixelSpray(pos,color,dir,coneAngle,speedMin,speedMax,emissionRate,particleLife)
    return {
        pos=pos,
        color=color,
        angle=dir:atan(),
        halfAngle=coneAngle/2,
        speedMin=speedMin,
        speedMax=speedMax,
        emissionRate=emissionRate,
        emissionCounter=rnd(1),
        particleLife=particleLife,
        update=updatePixSpray
    }
end

function EDParticle(pos,color,vel)
    return {
        color=color,
        pos=pos+rnd(1)*vel,
        vel=vel,
        update=updateParticle,
        draw=drawParticle
    }
end

function createEffect(lifetime,data,attachObject)
    newEffect={
        lifetime=lifetime,
        update=updateEffect,
        data=data,
        attachObject=attachObject
    }
    add(effects,newEffect)
    return newEffect
end

function updateEffect(effect)
    effect.lifetime-=1
    if effect.lifetime==0 or (effect.attachObject and effect.attachObject.dead) then
        del(effects,effect)
    elseif effect.data.update then
        effect.data.update(effect)
    end
end

function updatePixSpray(effect)
    data=effect.data

    if (effect.attachObject) data.pos=effect.attachObject.pos

    data.emissionCounter+=data.emissionRate
    while (data.emissionCounter>1) do
        data.emissionCounter-=1
        angle=data.angle+randFloat(-data.halfAngle,data.halfAngle)
        vel=randFloat(data.speedMin,data.speedMax)*vec2FromAngle(angle)

        col=data.color
        if (type(col)!="number") col=rnd(col)

        particle=createEffect(data.particleLife,EDParticle(data.pos,col,vel))
        particle.drawLayer=effect.drawLayer
    end
end

function updateParticle(effect)
    effect.data.pos+=effect.data.vel
end

function drawParticle(ED)
    pset(ED.pos.x*8,ED.pos.y*8,ED.color)
end

function drawEffect(effect)
    if (currentEffectDrawLayer==effect.drawLayer and effect.data.draw) effect.data:draw()
end

function drawEffects()
    palt()
    foreach(effects,drawEffect)
end
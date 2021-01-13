function tileWorldToScreen(v)
    return vec2(flr(v.x*8-4),flr(v.y*8-4))
end

function drawSprite(n,v)
    palt(0)
    flipX=n<0
    n=abs(n)
    flipY=n>=256
    n%=256
    palt(fget(n),true)
    screenPos=tileWorldToScreen(v)
    spr(n,screenPos.x,screenPos.y,1,1,flipX,flipY)
end

function startAnim(anim,frameTime,dontLoop)
    sourceAnim=anim
    anim=type(anim)=="number" and {anim} or (type(anim)=="string" and split(anim) or anim)
    animData={
        t=0,
        frameTime=frameTime,
        sourceAnim=sourceAnim,
        anim=anim,
        dontLoop=dontLoop,
        numFrames=#anim
    }

    if (animData.anim.right!=nil) animData.numFrames=#anim.right
    return animData
end

function updateAnim(animData)
    if (animData.frameTime<0) return
    animData.t+=1
    if animData.t/animData.frameTime>=animData.numFrames then
        if animData.dontLoop then
            animData.t=-(animData.numFrames-1)
            animData.frameTime=-1
        else
            animData.t=0
        end
    end
end

angleLookups=split("right,diag,up,diag:1,right:1,diag:1:1,up:0:1,diag:0:1")
function drawAnim(animData,pos,facing,dir)
    frame=1+flr(animData.t/animData.frameTime)
    frames=animData.anim
    if animData.anim.right!=nil then
        angle=dir:atan()
        if animData.anim.diag!=nil then
            index=1+flr(frac(angle+0.0626)*8)
        else
            index=1+2*flr(frac(angle+0.126)*4)
        end
        lookupResult=split(angleLookups[index],':')
        sprite=animData.anim[lookupResult[1]][frame]
        
        if (#lookupResult>2) sprite+=256*sgn(sprite)
        if ((#lookupResult>1 and lookupResult[2]==1) or facing==-1) sprite*=-1
    else
        facing=facing or 1
        sprite=facing*animData.anim[frame]
    end
    drawSprite(sprite,pos)
end
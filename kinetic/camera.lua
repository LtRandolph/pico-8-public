cameraEasingDef={
    numbers=
[[
strength=0.2
maxAccel=0.3
minSpeed=0.1
maxSpeed=2
]]
}
parseNumbers(cameraEasingDef)

function initCamera()
    targetPos=player.pos-vec2(8,8)
    cameraEasingX=easing(cameraEasingDef,targetPos.x)
    cameraEasingY=easing(cameraEasingDef,targetPos.y)
end

function updateCamera()
    targetPos=player.pos-vec2(8,8)
    strength=1
    if trajEnd then
        targetPos=0.3*player.pos+0.7*trajEnd-vec2(8,8)
        strength=0.25
    end
    cameraEasingX.strength*=strength
    cameraEasingY.strength*=strength
    cameraEasingX:update(targetPos.x,mapMinX,mapMaxX-16)
    cameraEasingY:update(targetPos.y,mapMinY,mapMaxY-16)
    cameraEasingX.strength/=strength
    cameraEasingY.strength/=strength
end

function applyCamera()
    camera(8*cameraEasingX.value,8*cameraEasingY.value)
end
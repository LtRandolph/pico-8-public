function moveTowardsTarget(gameObject)
    offsetToTarget=gameObject.target-gameObject.pos
    distToTarget=#offsetToTarget
    speed=gameObject.speed
    if (gameObject.speedMult!=nil) speed*=gameObject.speedMult
    if distToTarget<speed then
        gameObject.pos=gameObject.target
        gameObject.vel=offsetToTarget
        return true
    else
        gameObject.vel=(speed/distToTarget)*offsetToTarget
        gameObject.pos+=gameObject.vel
        return false
    end
end
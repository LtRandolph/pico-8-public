easingmt={
    update=function(e,targetValue,minValue,maxValue)
        vel=e.vel
        value=e.value
        offset=targetValue-value
        targetVel=offset*e.strength
        deltaVel=targetVel-vel

        if targetVel*vel<0 or abs(targetVel)>abs(vel) then
            deltaVel=clamp(deltaVel,-e.maxAccel,e.maxAccel)
        end

        vel=clamp(vel+deltaVel,-e.maxSpeed,e.maxSpeed)

        minSpeed=e.minSpeed
        if (0<vel and vel<minSpeed) vel=minSpeed
        if (0>vel and vel>-minSpeed) vel=-minSpeed

        wasLess=value<targetValue
        value+=vel
        if wasLess!=(value<targetValue) then
            value=targetValue
            vel=0
        end
        if value<minValue then
            value=minValue
            vel=max(vel,0)
        elseif value>maxValue then
            value=maxValue
            vel=min(vel,0)
        end
        e.vel=vel
        e.value=value
    end,
}
easingmt.__index=easingmt

function easing(def,value)
    result={
        value=value,
        vel=0
    }
    absorbTable(result,def)
    return setmetatable(result,easingmt)
end
function checkCollision(rectangleA,rectangleB,aOffset)
    rectAMinX=rectangleA.min.x
    rectAMinY=rectangleA.min.y
    rectAMaxX=rectangleA.max.x
    rectAMaxY=rectangleA.max.y

    aOffsetX=aOffset.x
    aOffsetY=aOffset.y

    aBounds=rectangle(vec2(
        rectAMinX+min(0,aOffsetX),
        rectAMinY+min(0,aOffsetY)),vec2(
        rectAMaxX+max(0,aOffsetX),
        rectAMaxY+max(0,aOffsetY))
    )

    if (not rectangleB:overlaps(aBounds)) return {false}

    if aOffsetX>0 then
        xEntryDist=rectangleB.min.x-rectAMaxX
        xExitDist=rectangleB.max.x-rectAMinX
    else
        xEntryDist=rectangleB.max.x-rectAMinX
        xExitDist=rectangleB.min.x-rectAMaxX
    end

    if aOffsetY>0 then
        yEntryDist=rectangleB.min.y-rectAMaxY
        yExitDist=rectangleB.max.y-rectAMinY
    else
        yEntryDist=rectangleB.max.y-rectAMinY
        yExitDist=rectangleB.min.y-rectAMaxY
    end

    if aOffsetX==0 then
        xEntryTime=-10000
        xExitTime=10000
    else
        xEntryTime=xEntryDist/aOffsetX
        xExitTime=xExitDist/aOffsetX
    end

    if aOffsetY==0 then
        yEntryTime=-10000
        yExitTime=10000
    else
        yEntryTime=yEntryDist/aOffsetY
        yExitTime=yExitDist/aOffsetY
    end

    entryTime=max(xEntryTime,yEntryTime)
    exitTime=min(xExitTime,yExitTime)

    if entryTime>exitTime or entryTime<0 or entryTime>1 or exitTime<0 then
        return {false}
    else
        normal=vec2(0,0)
        if xEntryTime>yEntryTime then
            normal.x=xEntryDist<0 and 1 or -1
        else
            normal.y=yEntryDist<0 and 1 or -1
        end
        return {true,entryTime,normal}
    end
end

function chainCollision(rectangleA,rectangleB,aOffset,collisionResult)
    thisResult=checkCollision(rectangleA,rectangleB,aOffset)

    if thisResult[1] and (not collisionResult[1] or thisResult[2]<collisionResult[2]) then
        return thisResult
    end
    return collisionResult
end

function collideWithMap(rectangleA,aOffset,collisionFlags)
    collisionFlags=collisionFlags or 1
    local mapMinX=flr(rectangleA.min.x+min(0,aOffset.x))
    local mapMaxX=ceil(rectangleA.max.x+max(0,aOffset.x))
    local mapMinY=flr(rectangleA.min.y+min(0,aOffset.y))
    local mapMaxY=ceil(rectangleA.max.y+max(0,aOffset.y))

    collisionResult={false}

    for mapX=mapMinX,mapMaxX do
        for mapY=mapMinY,mapMaxY do

            mapTile=mget(mapX,mapY)
            if fget(mapTile)&collisionFlags!=0 then
                tileMin=vec2(mapX,mapY)
                tileMax=tileMin+vec2(1,1)
                collisionResult=
                    chainCollision(rectangleA,rectangle(tileMin,tileMax),aOffset,collisionResult)
            end
        end
    end

    if terrainObjects then
        for terrainObject in all(terrainObjects) do
            if #(terrainObject.pos-rectangleA.min)<3 then
                collisionResult=
                    chainCollision(rectangleA,getCollisionRect(terrainObject),aOffset,collisionResult)
            end
        end
    end

    return unpack(collisionResult)
end

function collideMove(currentRect,remainingDelta,collisionFlags)
    outDelta=vec2(0,0)
    clearAxes=vec2(0,0)
    collided,collideT=collideWithMap(currentRect,remainingDelta,collisionFlags)
    while collided do
        thisDelta=max(0,collideT-0.01)*remainingDelta
        outDelta+=thisDelta
        currentRect+=thisDelta
        remainingDelta=(1-collideT)*remainingDelta
        if (collisionResult[3].x!=0) remainingDelta.x=0 clearAxes.x=1
        if (collisionResult[3].y!=0) remainingDelta.y=0 clearAxes.y=1
        if #remainingDelta>0 then
            collided,collideT=collideWithMap(currentRect,remainingDelta,collisionFlags)
        else
            collided=false
        end
    end
    outDelta+=remainingDelta
    return outDelta,clearAxes
end

function getCollisionRect(gameObject)
    return gameObject.collisionRect+gameObject.pos
end

function collideType(collider,typeList,callback,collisionRect)
    collisionRect=collisionRect or getCollisionRect(collider)
    for typeObj in all(typeList) do
        if collisionRect:overlaps(getCollisionRect(typeObj)) then
            callback(typeObj,collider)
        end
    end
end
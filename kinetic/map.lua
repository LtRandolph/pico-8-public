function initMap(mapRect)
    mapMinX,mapMinY,mapMaxX,mapMaxY=unpack(split(mapRect))
    mapWidth=mapMaxX-mapMinX
    mapHeight=mapMaxY-mapMinY
    tileInfos={}

    jumpUp,
    jumpDown,
    jumpMinWidth,
    jumpMaxWidth,
    fallHeight,
    barrierScore=unpack(split("3,3,2,4,4,0"))

    doToAllTiles(mapFirstPass)
    doToAllTiles(placeMapObjects)
    enemyDir=sgn((exitDoor.pos-entryDoor.pos).x)
    doToAllTiles(findGround)
    doToAllTiles(findNext)
    recurseValidPath(exitDoor.pos:floored())
    doToAllTiles(prunePath)
    initPlayer()
end

function drawMapBackground()
    map(mapMinX,mapMinY,
        8*mapMinX,8*mapMinY,
        mapWidth,mapHeight,
        129)
end

function drawOnMinimap(pos,col)
    pset(96+8*mapShiftX+pos.x-mapMinX,pos.y-mapMinY,col)
end

function drawMinimapObj(gameObject)
    if gameObject.minimapColor>=0 then
        drawOnMinimap(gameObject.pos,gameObject.minimapColor)
    end
end

function drawMinimap()
    mapTilesX=mapWidth\8
    mapTilesY=mapHeight\8
    mapShiftX=4-mapTilesX
    mapShiftY=4-mapTilesY
    palt(0)
    spr(204,96+8*mapShiftX,0,mapTilesX,mapTilesY)

    if trajLines then
        for trajLine in all(trajLines) do
            drawOnMinimap(trajLine[1],1)
        end
    end

    foreach(blocks,drawMinimapObj)
    foreach(machines,drawMinimapObj)
    foreach(graps,drawMinimapObj)
    foreach(enemies,drawMinimapObj)
    foreach(projs,drawMinimapObj)
    foreach(doors,drawMinimapObj)
    drawMinimapObj(waveButton)
    drawMinimapObj(player)
end

function getTileInfo(v)
    if (v.x<mapMinX or v.x>=mapMaxX or v.y<mapMinY or v.y>=mapMaxY) return nil
    return tileInfos[v.x][v.y]
end

function doToAllTiles(callback)
    for x=mapMinX,mapMaxX-1 do
        for y=mapMinY,mapMaxY-1 do
            callback(vec2(x,y))
        end
    end
end

function createDoor(pos,entry,sprite)
    door={
        pos=pos,
        anim=startAnim(sprite,-1),
        entry=entry,
        minimapColor=6
    }
    add(doors,door)
    if entry then
        entryDoor=door
    else
        exitDoor=door
    end
end

function mapFirstPass(v)
    local x=v.x
    local y=v.y
    minimapX=96+x-mapMinX
    minimapY=96+y-mapMinY

    tile=mget(x,y)

    if (tileInfos[x]==nil) tileInfos[x]={}
    tileInfo={
        pos=v,
        nextTiles={},
        prevTiles={},
        couldJumpFromTiles={},
        barrierAllowed=tile==0,
    }
    tileInfos[x][y]=tileInfo

    tileInfo.enemyPathable=fget(tile)&1==0
    sset(minimapX,minimapY,tileInfo.enemyPathable and 0 or 13)
end

function findGround(v)
    tileInfo=getTileInfo(v)
    tileInfo.isGround=
        (v.y<mapMaxY and
        tileInfo.enemyPathable and
        not tileInfos[v.x][v.y+1].enemyPathable)
end

testRect=rectString("-0.45,-0.45,0.45,0.45")
function canMakeJump(startTile,endTile)
    startPos=startTile+halfVec
    endPos=endTile+halfVec
    vel=enemyJumpVel(squidA,startPos,endPos)
    currentPos=startPos

    while true do
        vel.y+=squidA.gravity

        if (#vel>=#(currentPos-endPos)) break
        currentRect=testRect+currentPos
        posDelta,clearAxes=collideMove(currentRect,vel)
        if (#clearAxes!=0) return false

        currentPos+=posDelta
    end

    return true
end

function markPathSegment(startNode,endNode)
    add(startNode.nextTiles,endNode.pos)
    add(endNode.prevTiles,startNode.pos)
end

function findNext(v)
    tileInfo=getTileInfo(v)
    if (not tileInfo.isGround) return

    nextTilePos=v+vec2(enemyDir,0)
    nextTileInfo=getTileInfo(nextTilePos)
    if (not nextTileInfo) return

    considerWalk=nextTileInfo.isGround
    considerFall=not nextTileInfo.isGround and nextTileInfo.enemyPathable
    considerJumpNotUp=not nextTileInfo.isGround

    if considerWalk then
        markPathSegment(tileInfo,nextTileInfo)
    end

    if considerFall then
        for dy=1,fallHeight do
            downTilePos=nextTilePos+vec2(0,dy)
            downTileInfo=getTileInfo(downTilePos)
            if (downTileInfo and downTileInfo.isGround) markPathSegment(tileInfo,downTileInfo)
        end
    end

    lowestJumpDelta=considerJumpNotUp and jumpDown or -1
    for dx=jumpMinWidth,jumpMaxWidth do
        for dy=-jumpUp,lowestJumpDelta do
            jumpTilePos=v+vec2(dx*enemyDir,dy)
            jumpTileInfo=getTileInfo(jumpTilePos)
            if jumpTileInfo and jumpTileInfo.isGround then
                add(jumpTileInfo.couldJumpFromTiles,v)
            end
        end
    end
end

function recurseValidPath(tilePos)
    local tileInfo=getTileInfo(tilePos)
    if (tileInfo.validPathStep) return

    tileInfo.validPathStep=true
    tileInfo.barrierAllowed=false

    for prevTile in all(tileInfo.prevTiles) do
        if prevTile.y!=tilePos.y then
            for y=prevTile.y,tilePos.y do
                tileInfos[tilePos.x][y].barrierAllowed=false
            end
        end
        recurseValidPath(prevTile)
    end
    
    for jumpTilePos in all(tileInfo.couldJumpFromTiles) do
        if canMakeJump(jumpTilePos,tilePos) then
            markPathSegment(getTileInfo(jumpTilePos),tileInfo)
            recurseValidPath(jumpTilePos)
        end
    end
end

function prunePath(v)
    tileInfo=getTileInfo(v)
    for nextTilePos in all(tileInfo.nextTiles) do
        nextTileInfo=getTileInfo(nextTilePos)
        if (not nextTileInfo.validPathStep) del(tileInfo.nextTiles,nextTilePos)
    end
    tileInfo.couldJumpFromTiles=nil
end

tileCreation={
    [1]={setPlayerSpawnPos,{}},
    [16]={createGrap,{grapBasic}},
    [23]={createWaveButton,{}},
    [37]={createMachine,{}},
    [66]={createDoor,{true,65}},
    [67]={createDoor,{false,65}},
    [68]={createDoor,{true,64}},
    [69]={createDoor,{false,64}}
}
function placeMapObjects(v)
    local x=v.x
    local y=v.y
    tile=mget(x,y)

    if tileCreation[tile] then
        conversion=tileCreation[tile]
        conversion[1](vec2(x+0.5,y+0.5),unpack(conversion[2]))
    end
end
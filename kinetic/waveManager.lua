function createWaveButton(pos)
    waveButton={
        pos=pos,
        collisionRect=unitRect,
        facing=pos.x-mapMinX<5 and -1 or 1
    }
    prepareWaveButton()
end

function prepareWaveButton()
    waveButton.anim=startAnim(23)
    waveButton.minimapColor=8
end

function whipWaveButton()
    if timerToSpawn<0 and spawnCount==0 then
        timerToSpawn=60
        waveButton.anim=startAnim(24)
        waveButton.minimapColor=-1
        sfx(40)
    end
end

function updateWaves()
    if timerToSpawn==0 then
        createEnemy(_ENV[currentEnemyType])
        spawnCount+=1
        timerToSpawn=spawnCount==totalSpawnCount and -1 or spawnTimeBetween
    elseif timerToSpawn>0 then
        timerToSpawn-=1
    elseif #enemies==0 and spawnCount>0 and lives>0 then
        waveEnded()
    end
end

function prepareWave(index)
    currentWaveIndex=index
    spawnCount=0
    currentEnemyType,spawnTimeBetween,totalSpawnCount=unpack(split(currentLevelWaves[index]))
    prepareWaveButton()
end

function waveEnded()
    if currentWaveIndex<#currentLevelWaves then
        prepareWave(currentWaveIndex+1)
        blockMachines()
    else
        victory()
    end
end
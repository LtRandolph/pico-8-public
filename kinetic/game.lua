function _init()
    showTitleScreen()
    cartdata("ltrandolph_kinetic")
    highestBeatenLevel=dget(0)
    perfectLevelMask=dget(1)
    --menuitem(3,"fill blocks",blockMachines)
    menuitem(4,"swap buttons",swapButtons)
    menuitem(5,"reset progress",resetProgress)
end

function beginGame(level)
    blocks={}
    doors={}
    enemies={}
    graps={}
    grapMods={}
    machines={}
    projs={}
    timerToSpawn=-1

    wonLevel=false
    levelOver=false

    initLevel(level)

    initMap(level.mapRect)
    initCamera()
    initEffects()

    prepareWave(1)

    menuitem(1,"restart level",restartLevel)
    menuitem(2,"main menu",showTitleScreen)

    _update60=updateDefault
    _draw=drawDefault

    terrainObjects=blocks
    -- no button repeat
    poke(0x5f5c,255)
    
    music(0,0,3)
end

btnJump=4
btnWhip=5

function swapButtons()
    swapVal=btnJump
    btnJump=btnWhip
    btnWhip=swapVal
end

function resetProgress()
    highestBeatenLevel=0
    dset(0,highestBeatenLevel)
    perfectLevelMask=0
    dset(1,perfectLevelMask)
end

function restartLevel()
    beginGame(currentLevel)
end

function victory()
    music(-1,100)
    wonLevel=true
    levelOver=true
    currentLevelIndex=indexOf(levels,currentLevel)
    if lives==currentLevel.lives then
        perfectLevelMask|=1<<currentLevelIndex
        dset(1,perfectLevelMask)
    end
    justWon=highestBeatenLevel<currentLevelIndex and currentLevelIndex==#levels
    highestBeatenLevel=max(highestBeatenLevel,currentLevelIndex)
    dset(0,highestBeatenLevel)
end

function defeat()
    music(-1,100)
    levelOver=true
    showDialog(
[[26|eSS? vAN? tALK TO ME...
...~26|dAMN. nOW WE'LL NEVER GET
BACK TO EARTH.]]
    )
end

function doPostGame()
    if justWon then
        showCredits()
        justWon=false
    else
        showLevelSelect()
    end
end

function updateDefault()
    if (levelOver) doPostGame()
    updateWaves()
    updateGameObjects(machines)
    updateGameObjects(projs)
    updateGameObjects(enemies)
    updatePlayer()
    updateGameObjects(effects)
    updateGameObjects(blocks)
    updateCamera()
end

function updateOnlyPlayer()
    updatePlayer()
    updateCamera()
end

function drawDefault()
    cls(12)
    palt()
    applyCamera()
    drawMapBackground()
    drawGameObjects(machines)
    drawGameObjects(blocks)
    drawGameObjects(graps)
    foreach(enemies,drawEnemy)
    pal()
    drawGameObject(waveButton)
    drawPlayer()
    drawGameObjects(projs)
    drawGameObjects(doors)
    drawEffects()
    camera()
    drawMinimap()
    drawHealth()
end
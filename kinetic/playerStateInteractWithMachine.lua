psAdjustMachine={
    start=function()
        _update60=updateOnlyPlayer
        player.pos=getInteractPos()
        player.vel=vec2(0,0)
        player.facing=sgn(whipMachine.pos.x-player.pos.x)
        player.anim=startAnim(pAnimAdjust,-1)
        adjustSpeed=0
        makeProjVis()
    end,
    stop=function()
        _update60=updateDefault
        trajLines=nil
        trajectoryEndPoint=nil
    end,
    update=function()
        if (btnp(0)) flipMachine(-1)
        if (btnp(1)) flipMachine(1)

        if btnp(btnJump) then
            changeMachineType()
        elseif btn(2) then
            adjustTraj(1)
        elseif btn(3) then
            adjustTraj(-1)
        else
            adjustSpeed=0
        end
    end,
    checkTransition=function()
        if (btnp(btnWhip)) return psGround
    end,
    draw=function()
        for trajLine in all(trajLines) do
            line(8*trajLine[1].x,8*trajLine[1].y,8*trajLine[2].x,8*trajLine[2].y,1)
        end
    end
}
setmetatable(psAdjustMachine,ps)

function changeMachineType()
    sfx(28)
    typeIndex=indexOf(machineTypes,whipMachine.type)
    typeIndex+=1
    if typeIndex>#machineTypes then
        typeIndex=1
    end
    setMachineType(whipMachine,machineTypes[typeIndex])
    makeProjVis()
end

function flipMachine(facing)
    setMachineFacing(whipMachine,facing)
    player.pos=getInteractPos()
    player.facing=facing
    makeProjVis()
end

function adjustTraj(direction)
    adjustSpeed=clamp(adjustSpeed+direction*0.00025,-0.0125,0.0125)
    changeTraj(whipMachine,adjustSpeed)
    makeProjVis()
end

function projVisCallback(proj)
    if counter==2 then
        nextLine={proj.pos}
    elseif counter==4 then
        add(nextLine,proj.pos)
        if (#(nextLine[1]-nextLine[2])<2) add(lines,nextLine)
        nextLine=nil
    elseif counter==6 then
        counter=0
    end
    counter+=1
    trajectoryEndPoint=proj.pos
end

function makeProjVis()
    lines={}
    trajectoryEndPoint=nil
    counter=0

    traceDummyProj(whipMachine,projVisCallback)

    trajLines=lines
end
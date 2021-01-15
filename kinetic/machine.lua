machineBasic={
    numbers=
[[animIdle=37
defaultAngle=0
minAngle=0
maxAngle=0]]
}

allMachs={
machineBasic,
{
    projDef=pinkGoo,
    numbers=
[[attackCooldown=80
launchSpeed=0.25
defaultAngle=0.125
minAngle=0.05
maxAngle=0.2125
animIdle=49
animLaunch=50,51,52]]
},
{
    projDef=blueDart,
    animIdle={right={56},up={60},diag={60}},
    animLaunch={right=split("57,58,59"),up=split("61,62,63"),diag=split("61,62,63")},
    numbers=
[[attackCooldown=80
launchSpeed=0.35
defaultAngle=0.125
minAngle=-0.04
maxAngle=0.2125]]
},
{
    projDef=yellowSpark,
    numbers=
[[attackCooldown=80
launchSpeed=0.15
defaultAngle=0.125
minAngle=-0.05
maxAngle=0.25
animIdle=34
animLaunch=34,35,36]]
}
}

foreach(allMachs,parseNumbers)

function createMachine(pos)
    machine={
        pos=pos,
        facing=sgn(mapCenterX-pos.x),
        update=updateMachine,
        collisionRect=rectString("-0.375,-0.5,0.375,0.5"),
        minimapColor=2,
        attackTicks=-1,
        angles={},
        type=machineBasic
    }
    setMachineType(machine,machineBasic) 
    
    add(machines,machine)
end

function setMachineType(machine,type)
    machine.angles[machine.type]=machine.angle
    machine.type=type
    machine.anim=startAnim(type.animIdle)
    machine.attackTicks=type.attackCooldown and flr(rnd(type.attackCooldown)) or -1
    setMachineAngle(machine,machine.angles[type] or type.defaultAngle)
end

function setMachineAngle(machine,angle)
    machine.angle=angle
    machine.vel=vec2FromAngle(angle)
    machine.vel.x*=machine.facing
end

function updateMachine(machine)
    if (machine.attackTicks>0) machine.attackTicks-=1
    
    if machine.attackTicks==12 then
        machine.anim=startAnim(machine.type.animLaunch,4)
    elseif machine.attackTicks==0 then
        machineAttack(machine)
    end

    updateAnim(machine.anim)
end

function machineAttack(machine)
    machineMakeProj(machine)
    machine.attackTicks=machine.type.attackCooldown
    machine.anim=startAnim(machine.type.animIdle)
end

function machineMakeProj(machine,isDummy)
    if machine.type.projDef then
        return createProj(
            machine.pos+vec2(0,-0.25),
            machine.type.launchSpeed*machine.vel,
            machine,
            machine.type.projDef,
            isDummy)
    end
end

function setMachineFacing(machine,facing)
    if machine.facing!=facing then
        machine.facing=facing
        machine.vel.x*=-1
    end
end

function changeTraj(machine,delta)
    setMachineAngle(machine,clamp(machine.angle+delta,machine.type.minAngle,machine.type.maxAngle))
end

function getInteractPos()
    return whipMachine.pos-whipMachine.facing*vec2(0.75,0)
end
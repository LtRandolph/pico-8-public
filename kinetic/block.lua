function blockSearch(proj)
    tilePos=proj.pos:floored()
    if mget(tilePos.x,tilePos.y)==38 and
        indexOf(candidates,tilePos)==-1 then
        add(candidates,tilePos)
    end
end

function updateBlock(block)
    updateAnim(block.anim)
end

function blockMachines()
    candidateMachines={}
    for machine in all(machines) do
        add(candidateMachines,machine)
    end
    for i=1,currentLevel.blockCount do
        machine=rnd(candidateMachines)
        blockMachine(machine)
        del(candidateMachines,machine)
    end
end

function blockMachine(machine)
    candidates={}
    traceDummyProj(machine,blockSearch)

    if (#candidates==0) return

    createBlock(rnd(candidates)+halfVec)
end

function createBlock(pos)
    block={
        pos=pos,
        collisionRect=unitRect,
        anim=startAnim("39,40,41",10,true),
        minimapColor=13,
        update=updateBlock
    }
    add(blocks,block)
end
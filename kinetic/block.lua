blockCollision=rectString("-0.5,-0.5,0.5,0.5")

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
    foreach(machines,blockMachine)
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
        collisionRect=blockCollision,
        anim=startAnim("39,40,41",10,true),
        minimapColor=13,
        update=updateBlock
    }
    add(blocks,block)
end
function updateGameObjects(table)
    for gameObject in all(table) do
        gameObject:update()
    end
end

function drawGameObject(gameObject)
    drawAnim(gameObject.anim,gameObject.pos,gameObject.facing,gameObject.vel)
end

function drawGameObjects(table)
    foreach(table,drawGameObject)
end
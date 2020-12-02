function _init()
    init_pages()
end

function _update()
    update_pages()
    update_particles()
end

function _draw()
    cls()
    draw_particles()
    -- draw page last so title
    -- will overwrite particles
    draw_pages()
end
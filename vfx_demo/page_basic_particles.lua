function pbp_init(self)
    center = vec2(64,64)
    colors = {8,9,10}
    for i=1,512 do
        angle=rnd(1)
        speed=rnd_float(0, 1.5)
        vel=speed*vec2(
            cos(angle),
            sin(angle)
        )
        col=rnd(colors)
        life=rnd_int(30,120)
        create_particle(center,
            vel,
            life,
            col
        )
    end
end
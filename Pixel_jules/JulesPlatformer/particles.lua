Particles = {}
function particle(pos, color, timenum, c, vel, acc, rand, size, drawn, toScale)
    i = 0
    while (i < c)
    do
        i += 1
        add(Particles, {pos={x=pos.x + rnd(rand) - rnd(rand),y=pos.y + rnd(rand) - rnd(rand)}, size=size,col=color,t=time(), life=timenum, dead = false, v = {x=vel.x+rnd(rand) - rnd(rand),y=vel.y+rnd(rand)}, a = {x=acc.x,y=acc.y}, rand=rand, drawn=drawn,toScale=toScale})
    end
end

Particles.clear = function(self)
    for p in all (Particles)
    do
        if (p.dead == false)
        then
            p.dead = true
        end

    end
end

Particles.draw = function(self)
    for p in all (Particles)
    do
        if (not p.dead)
        then
            if (p.drawn)
            then
                if (not p.toScale)
                then  
                    spr(p.size, p.pos.x, p.pos.y)
                else
                    sspr(p.size[1], p.size[2], p.size[3], p.size[4], p.pos.x, p.pos.y, p.size[5], p.size[6])
                end
            else
                circfill(p.pos.x,p.pos.y,p.size,p.col)
            end
        else
            del(Particles, p)
        end

    end

end

Particles.update = function(self)
    
    for p in all (Particles)
    do
        if ((not p.toScale == false and p.drawn) and p.pos.x >= 64)
        then
            p.pos.x -= 129
        end

        p.pos.x+=p.v.x
        p.pos.y+=p.v.y

        p.v.y+=p.a.y
        p.v.x+=p.a.x
        if (time() - p.t > p.life)
        then
            p.dead = true
        end
    end
end
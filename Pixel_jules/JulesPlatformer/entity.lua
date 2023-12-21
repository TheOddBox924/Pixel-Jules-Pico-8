--Entity Class--
entities = {}
entities.loaded   = {}
entities.unloaded = {}

function newent(pos,sprset,hbox,v, type,localScale)
  local ent = {}
  ent.flipped = false
  ent.type = type
  ent.pos = pos
  ent.sprset = sprset
  ent.hbox = hbox
  ent.v = v
  ent.localScale = localScale
  ent.currframe = 1
  ent.anim = {false, 0}--true,framerate
  if (localScale)
  then
    ent.scaled = true

  end
  ent.physics = false
  ent.dead = false
  ent.lt = 0
  
  ent.die = function(self)
      ent.dead = true
      ent.pos = {x=1000,y=1000}
    end

  ent.draw = function(self)
    if (not ent.dead)
    then
    if ent.scaled
    then
      sspr(ent.sprset[ent.currframe][1],ent.sprset[ent.currframe][2],ent.sprset[ent.currframe][3],ent.sprset[ent.currframe][4], ent.pos.x, ent.pos.y, ent.localScale.x, ent.localScale.y, ent.flipped)
    else
      sspr(ent.sprset[ent.currframe][1],ent.sprset[ent.currframe][2],ent.sprset[ent.currframe][3],ent.sprset[ent.currframe][4], ent.pos.x, ent.pos.y, ent.hbox.x, ent.hbox.y, ent.flipped)
    end
  end
  end

  ent.update = function(self)
    if (😐.canMove)

    then
    if (abs(ent.pos.y) > 250 and ent.dead == false)
    then
      ent.die()
    end

    if (not ent.dead)
    then
    if (ent.physics)
    then
      ent.grounded = false
      for platform in all (map.tiles)
      do
        if (collision(platform, ent) and platform.doCol and ent.pos.y + 5 < platform.pos.y)
        then
          if (ent.type != "fireball")
          then
            ent.grounded = true
          end
          if (ent.type == "fireball")
          then
            ent.v.y *= -1
          end
        end
        
      end
      if (not ent.grounded)
      then
        ent.v.y = 1
      else
        ent.v.y = 0
      end
    end
    ent.pos.x += ent.v.x
    ent.pos.y += ent.v.y
    --The entity is animated
    --anim[2] is framerate
    if (ent.anim[1])
    then
      ent.currframe = animator(ent.sprset,ent.anim[2],ent.currframe, ent.type)--sprite set,framerate, curr, last time for frame
    end
  end
end
end

  return ent
end

function cgoomba(pos, v)
  local goomba = {}
  goomba = newent({x=50,y=-10},{{0,26,6,8},{8,26,6,8},{16,26,6,8},{24,26,6,8}},{x=6,y=8},{x=-.2,y=0}, "enemy")
  goomba.physics = true
  goomba.anim = {true, .1}
  goomba.scaled = false
  return goomba
end

function cturtle(pos, v, color)
  local turtle = {}
  if (color == "red")
  then
    turtle = newent({x=pos.x, y=pos.y},{{8,13,5,10}},{x=6,y=11},{x=v.x,y=v.y}, "enemy")
    turtle.physics = true
    turtle.anim = {false, 0}
    turtle.scaled = false

  elseif (color == "green")
  then
    turtle = newent({x=pos.x, y=pos.y},{{0,13,5,10}},{x=6,y=11},{x=v.x,y=v.y}, "enemy")
    turtle.physics = true
    turtle.anim = {false, 0}
    turtle.scaled = false
  end
  return turtle
  end

function cteddy(pos, v)
  teddy = newent({x=pos.x, y=pos.y}, {{49, 2, 6, 6}, {65, 2, 6, 6}}, {x=6,y=6}, {x=v.x, y=v.y}, "dog")
  teddy.physics = true
  teddy.anim = {true, .1}
  teddy.scaled = false
end

function ccoin(pos)
  coin = newent({x=pos.x, y=pos.y}, {{32, 8, 8, 8}}, {x=8,y=8},{x=0,y=0}, "coin")
  coin.physics = false
  coin.anim = {false, 0}
  coin.scaled = false
  return coin

end

function cjumper(pos, v)
    
end


function cfireball(pos)
  local fireball = newent({x=pos.x, y=pos.y}, {{64, 8, 8, 8}}, {x=4,y=4},{x=1, y=-1}, "fireball")
  fireball.physics = true
  fireball.anim = {false, 0}
  fireball.scaled = false
  return fireball
end
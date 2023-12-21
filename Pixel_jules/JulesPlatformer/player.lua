--jules is the emoji lol
😐  ={}
jumptimer = 0
😐.canMove = false
😐.drawn = true
😐.jumpv = 2.5
😐.flying = false
😐.flyset = {{48,24},{56,24},{64,24},{72,24},{80,24},{88,24},{96,24},{104,24},{112,24},{120,24}}
😐.flyc = 1
😐.speed = 1
😐.pos={x=0,y=0}
😐.v={x=0,y=0}
😐.a={x=0,y=0}
😐.health=100
😐.hbox = {x=8,y=18}
😐.dead = false
😐.grounded=false
😐.facing = true --true: right, false: left
😐.currframe1 = 1
😐.currframe2 = 2
😐.dj = false
😐.armsprites = {10, 2, 2, 4}
😐.armpos={x=😐.pos.x + 1 + (4 * (1) + (2 * 1)),y=😐.pos.y+2}
😐.lt = 0
😐.legs={{10,7,2,3},{17,8,2,3}}


😐.groundType = "grass"
--legs: x1:10, y1:7, 2,3
😐.draw = function(self)
  if (😐.drawn)
  then
    poke(0x5f2d, 1)
    if (not 😐.flying)
    then
      spr(38, 😐.pos.x+stat(32)-20, 😐.pos.y+stat(33)-75)
      sspr(1, 0, 8, 11, 😐.pos.x+1,😐.pos.y-3, 8, 11, 😐.facing)
      sspr(😐.armsprites[1],😐.armsprites[2],😐.armsprites[3],😐.armsprites[4], 😐.armpos.x,😐.armpos.y, 2, 4)--arms
      sspr(😐.legs[😐.currframe1][1],😐.legs[😐.currframe1][2],2,3,😐.pos.x + (5 * (bti(😐.facing)) + (3 * bti(not 😐.facing))),😐.pos.y+7, 2, 3)
      sspr(😐.legs[😐.currframe2][1],😐.legs[😐.currframe2][2],2,3,😐.pos.x + (6 * (bti(😐.facing)) + (2 * bti(not 😐.facing))),😐.pos.y+7, 2, 3)
    else
      sspr(😐.flyset[😐.flyc][1], 😐.flyset[😐.flyc][2], 8, 11, 😐.pos.x+1,😐.pos.y-3, 8, 11)
      
  end
  end
end

😐.jump = function(self)
  😐.jumpv = 3
  
  😐.dj=true
  😐.v.y -= 😐.jumpv
  jumptimer = time()
  sfx(0)
 end

😐.update = function(self)
  --learned: hitbox of 2 is min for good col :)
  if (😐.canMove)
  then
    inputs = {}
    inputs[1]=bti(input()[1])
    inputs[2]=bti(input()[2])
    inputs[3]=bti(input()[3])
    inputs[4]=bti(input()[4])
  end

  if (😐.flying)
  then
    😐.flyc += 1
    if (😐.flyc > 9)
    then
      😐.flyc = 1
    end
  end

  --todo: flip player horizontally when btn(l/r)
  if input()[1]
  then
    if (😐.grounded)
    then
      😐.flying = false
      if (😐.groundType == "grass"or 😐.groundType == "cheese")
      then
        if (not (inputs[2] > 0))
        then
          particle({x=😐.pos.x + 8,y=😐.pos.y+10},3,.1,1,{x=-😐.v.x,y=-1}, {x=0,y=.2}, 1, .2)
        end
      elseif (😐.groundType == "brick")
      then
        if (not (inputs[2] > 0))
        then
          particle({x=😐.pos.x + 8,y=😐.pos.y+10},8,.1,1,{x=-😐.v.x,y=-1}, {x=0,y=.2}, 1, .2)
        end
        

      end
    end
    😐.currframe2 = animator({17,18},.2,😐.currframe2, "player")
    if (😐.currframe2 == 1)
    then 😐.currframe1 = 2
    else
      😐.currframe1 = 1
    end
    😐.facing = true
  end

  if input()[2]
    then
      if (😐.grounded)
      then
        if (😐.groundType == "grass" or 😐.groundType == "cheese")
        then
          if (not (inputs[1] > 0))
          then
          particle({x=😐.pos.x,y=😐.pos.y+10},3,.1,1,{x=-😐.v.x,y=-1}, {x=0,y=.2}, 1, .2)
          end
        elseif (😐.groundType == "brick")
        then
          if (not (inputs[1] > 0))
          then
          particle({x=😐.pos.x,y=😐.pos.y+10},8,.1,1,{x=-😐.v.x,y=-1}, {x=0,y=.2}, 1, .2)
          end
        end
      end
      😐.currframe2 = animator({17,18},.2,😐.currframe2, "player")
      if (😐.currframe2 == 1)
      then 😐.currframe1 = 2
      else
        😐.currframe1 = 1
      end
      😐.facing = false
  end
  if (inputs[1] + inputs[2] == 0 or ((inputs[1])>0 and (inputs[2])>0))
  then
    😐.currframe1 = 1
    😐.currframe2 = 1
  end

  if (not 😐.dead)
  then
    😐.a.x = 😐.speed*(inputs[2]-inputs[1])
    😐.a.x -= 😐.v.x*friction
  else
    😐.a.x = 0
    😐.a.y = 0
    😐.v.x = 0
    😐.v.y = 0
  end
  
  😐.v.y+=😐.a.y
  😐.v.x+=😐.a.x
  
  😐.v.x = mid(-2, 😐.v.x, 2)
  😐.v.y = mid(-20, 😐.v.y, 4)
  
  😐.pos.x+=😐.v.x
  😐.pos.y+=😐.v.y


  
  if (not 😐.grounded)
  then
    😐.armsprites = {13, 0, 2, 5}
    😐.armpos={x=😐.pos.x + 1 + (4 * (bti(😐.facing)) + (2 * bti(not 😐.facing))),y=😐.pos.y-4}
    if (😐.v.y > 0)
    then
      😐.a.y = 0.28
    else
      😐.a.y = 0.196
    end
    😐.speed = 1

  else if (😐.grounded)
    then
      😐.armsprites = {10, 2, 2, 4}
      😐.dj = false
      😐.armpos={x=😐.pos.x + 1 + (4 * (bti(😐.facing)) + (2 * bti(not 😐.facing))),y=😐.pos.y+2}
    if (😐.v.y>0)
    then
      😐.a.y = 0
      😐.v.y = 0
      😐.speed = .75
    end 
  end

  if(btnp(4) and 😐.dj and time()-jumptimer > 0.001)
  then
    😐.jump()
    😐.dj=false
  end
  if (😐.grounded and btnp(5) and time()-jumptimer > 0)
  then
    😐.jump()
    😐.dj = true
    😐.grounded = false
  end
  
  end
end
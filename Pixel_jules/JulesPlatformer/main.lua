jumptimer = .5
cameraPos = {x=-64, y=-50}
timer = 0



function _init()
    poke(0x5f2d, 1)
    cartdata("jules_platformer_1")
    GAME.loadProg()
    cameraPos = {x=-64, y=-50}
    camera(cameraPos.x, -64)
    friction = 0.2
    jumptimer = time()

end
    newball = nil
function _update()    
    if (input()[6] and GAME.currlevel == 0)
        then 
            cameraPos = {x=-64, y=50}
            GAME.start()
    end

    if (not GAME.paused)
        then
            if (😐.dead and btnp(5))
            then
                
                GAME.levelClear()
            end

            if (stat(34) == 1 and newball != nil)
            then
                newball = cfireball({x=😐.pos.x, y=😐.pos.y})
                add(entities, newball)
            end
            teddy.update()
        if (teddy.pos.x < 😐.pos.x)
        then
            teddy.flipped = false
        else
            teddy.flipped = true
        end

        if (😐.pos.x - 10 >= teddy.pos.x and not teddy.flipped)
        then
            teddy.pos.x += 0.5
        elseif
            (😐.pos.x + 10 <= teddy.pos.x and teddy.flipped)
        then
            teddy.pos.x -= 0.5
        end

        if (😐.pos.x - 10 >= teddy.pos.x and teddy.flipped and teddy.pos.y < 😐.pos.y)
        then
            teddy.jump()
        end

        Particles.update()
        😐.update()
        coin.pos.y -= sin(time() * 1.5)/5
        for ex in all (entities)
            do
                ex.update()
                
                if (collision(😐,ex) and ex.type=="pad")
                then
                    if (time()-jumptimer > .5) and not btn(5)
                    then
                        ex.sprset={{65,8,16,8}}
                    end

                    if (btn(5))
                    then
                        😐.v.y = -5
                        😐.flying = true
                        ex.sprset={{80,8,16,8}}
                        jumptimer = time()
                    end
                end
                if (collision(teddy, ex))
                then
                    if (ex.type == "enemy" and ex.dead == false)
                    then
                        teddy.v.y = - (1 + abs(teddy.v.y) * 1.25)
                        particle({x=ex.pos.x,y=ex.pos.y},8,3,20,{x=ex.v.x,y=ex.v.y}, {x=0,y=.1}, 3, 1, false)
                        sfx(10)
                        ex.die()
                    end
                end
                if (collision(😐,ex))
                then 

                    if(ex.type =="enemy" and ex.dead == false and not 😐.dead)
                    then
                        
                        sfx(4)
                        particle({x=😐.pos.x,y=😐.pos.y},8,3,20,{x=😐.v.x,y=😐.v.y}, {x=0,y=.1}, 3, 1, false)
                        particle({x=😐.pos.x,y=😐.pos.y},8,3,1,{x=sin(time()),y=-1}, {x=0,y=0}, 0, 21, true, false)
                        😐.dead = true
                        😐.drawn = false
                    end
                    
                    if (ex.type == "coin")
                    then
                        GAME.coinCount+=1
                        sfx(1)
                        particle({x=ex.pos.x,y=ex.pos.y},10,3,20,{x=ex.v.x,y=ex.v.y}, {x=0,y=.1}, 3, 1, false)
                        ex.die()
                        
                    end
            end 
        end 
        checker = false 
    for platform in all (map.tiles)
      do
        
        if (collision(platform, 😐) and platform.doCol)
        then
            


            if (😐.pos.y + 5 < platform.pos.y and 😐.v.y >= 0)
            then
                checker = true
                😐.flying = false
                😐.groundType = platform.groundType
                if (distance2D(😐.pos, platform.pos) < 9)
                then
                    😐.pos.y -= 1
                end
            end


            if (platform.groundType == "flag" and GAME.coinCount > 0 and not GAME.levelWon)
            then
                😐.pos.x = -20
                GAME.levelWin()
            end
            --elseif (😐.pos.y - 3 < platform.pos.y and 😐.v.y >= 0)
            --then
            --    😐.v.y = 2
            --end
        end
      end
        😐.grounded = checker
    end
end
    
function _draw()
    cls(12)
    --stat(34) = minput

    sspr(123,8, 5, 5, 45, -65, 20, 20)
    Particles.draw()
    GAME.draw()
    if (GAME.paused)
    then
        

        cameraPos = {x=-64, y=50}
    end
    --GAME.draw()
    if (not GAME.paused)
    then
        target = {😐.pos.x-64,😐.pos.y-75}
        camera(target[1], target[2])
        cls(12)
        sspr(123,8, 5, 5, 😐.pos.x-65, 😐.pos.y-75, 20, 20, true)


        for ex in all (entities)
        do

            if (ex.groundType == "bk" or ex.groundType == "lv")
            then
                --background tile
                ex.draw()
            end
            if (abs(ex.pos.x - 😐.pos.x) < 100)
            then
                ex.draw()
            end

        end
        Particles.draw()
        😐.draw()

        print("MEM: " .. (stat(0)/2048) * 100 .. "%", 😐.pos.x, -50)
        print("currlevel" .. GAME.currlevel)
        --print("double jump " .. bti(not 😐.grounded and btnp(5) and 😐.dj and time()-jumptimer > 0.1))
        --print(bti(😐.dj))
        --print(bti((😐.grounded and btnp(5) and time()-jumptimer > 0)))
        --print((""..😐.pos.x) .. "  " .. (""..😐.pos.y), 😐.pos.x, 😐.pos.y+5)
        if (😐.dead)
        then
            print("You died, press x to restart.")
            
        end
       end
       if (timer > 0 and timer < 30)
       then
        print("Level ".. GAME.currlevel .. " loading...")
            😐.canMove= false
            timer+=time()
       end
       if (timer >30)
       then
        😐.canMove=true
       end
end




--todo:
--1. add particles to pos at lava
--2. add timer to start of level to stop lag (~30 sec)
--3. save player progress
--4. add collision to walls & sides of ground
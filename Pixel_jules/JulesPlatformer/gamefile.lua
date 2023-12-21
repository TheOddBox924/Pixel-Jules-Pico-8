--BLOCK SPRITESETS
gSet= {{48,112},{55,119}}
dSet= {{48,120},{55,127}}
sSet= {{64,112},{71,119}}





--MENU--
GAME = {}
GAME.coinCount = 0
GAME.maxParticles = 100
GAME.cloudCount = 9
GAME.drawnClouds = 0
GAME.buttonSelected = false
GAME.levelLoaded = false
--level 0 indicates starting menu :)
GAME.currlevel = 0
GAME.levels = {}
GAME.winTimer = 0
GAME.levelWon = false
GAME.lvlsWon = {0, 0}--array of bools
teddy = newent({x=0, y=0}, {{49, 2, 6, 6}, {65, 2, 6, 6}}, {x=8,y=8}, {x=0, y=0}, "dog")
teddy.jump = function(self)
    
end

GAME.levelClear = function(self)
    😐.dead = false
    😐.pos = {x=0,y=0}
    entities = {}
    map.tiles = {}
    GAME.levelLoaded = false
    GAME.loadLevel()
end


GAME.levelWin = function(self)
    GAME.winTimer = time()
    GAME.levelLoaded = false
    --local transitionDone = false
    --while (not transitionDone)
    --do
    --    if (time() - GAME.winTimer <= 10) -- 10 second transition
    --    then
    --        😐.canMove = false
    --        😐.a.x = .25
    --    end
    --    transitionDone = true
    --end
    GAME.currlevel += 1
    --GAME.levelWon = true
    --GAME.saveProg()
    if (not GAME.levelLoaded)
    then
        GAME.loadLevel()
        GAME.levelWon=false
    end
    
end

GAME.onFlag = function(self)
    --flag collision
    if (😐.GAME.coinCount == GAME.currlevel)
    then
        --proceed to next level
    else
        --tell player to go back :) - maybe do a different flag if you dont have the coin.

    end
end

GAME.timerStart = function(self)
    GAME.timer = 0
end

GAME.saveProg = function(self)
    dset(0, GAME.lvlsWon)
end

GAME.loadProg = function(self)
    if (dget(0)) -- check for save file
    then
        GAME.lvlsWon = dget(0)
    end
end

GAME.resetProg = function(self)
    for l in all (GAME.lvlsWon)
    do
        l = 0
    end
end

GAME.addLevel = function(level)
    add(GAME.levels, {level[1], level[2], level[3]})
end

GAME.loadLevel = function(self)
    if (not GAME.levelLoaded)
    then
        entities = {}
        map.tiles = {}
    end
    GAME.levelWon = false
    
    timer=time()
    for blok in all (GAME.levels[GAME.currlevel][2])
    do
        --tiles => p1, sprset, doCol, count, xy, groundType, scaled, localScale, block
        map.tile(blok[1],--p1
                 blok[2],--spset
                 blok[3],--docol
                 blok[4],--count
                 blok[5],--xy
                 blok[6],
                 blok[7],
                 blok[8])
    end
    
        for entityadd in all (GAME.levels[GAME.currlevel][1])
        do
            add(entities, entityadd)
        end
        add(entities, teddy)
    


        😐.canMove = true
        GAME.levelLoaded = true
end


       --TRUE LEVEL 1 INITS
       --p1, sprset, doCol, count, xy, groundType, scaled, localScale, block
level1blocks={{{x=-100,y=56},{{0 ,101},{15,15}},true ,10,false, "grass",true,{x=16,y=16}},--at y= 40
              {{x=  80,y=56},{{0 ,101},{15,15}},true ,10,false, "grass",true,{x=16,y=16}},
              {{x=-370,y=72},{{80,48},{8,8}},false, 1, false, "bk", true,{x=300,y=100}},--example scalable (shadow) tile
              {{x=330,y=140},{{72,120},{8,8}},false, 1, false, "lv", true,{x=100,y=50}}, --lava1
              {{x=500,y=137},{{72,120},{8,8}},false, 1, false, "lv", true,{x=150,y=20}}, --lava2
              {{x=-100,y=72},{{23 ,84},{15,15}},false,10,false, "dirt",true,{x=16,y=16}},
              {{x=  80,y=72},{{23 ,84},{15,15}},false,10,false, "dirt",true,{x=16,y=16}},
              {{x=-100,y=87},{{23 ,84},{15,15}},false,10,false, "dirt",true,{x=16,y=16}},
              {{x=  80,y=87},{{23 ,84},{15,15}},false,10,false, "dirt",true,{x=16,y=16}},
              {{x=  70,y=26},{{40,112},{8,8}},true,2,false, "brick",false,{}},
              {{x=  -100,y=135},{{64,112},{8,8}},true,20,false, "stone",true,{x=16,y=16}},
              {{x=  -100,y=151},{{64,112},{8,8}},false,20,false, "stone",true,{x=16,y=16}},
              {{x=  -100,y=167},{{64,112},{8,8}},false,20,false, "stone",true,{x=16,y=16}},
              {{x=  -84,y=87},{{64,112},{8,8}},false,5,true, "stone",true,{x=16,y=16}},
              {{x=  -68,y=87},{{64,112},{8,8}},true,5,true, "stone",true,{x=16,y=16}},
              {{x=240,y=71},{{0 ,101},{15,15}},true,2,false, "grass",true,{x=16,y=16}},
              {{x=  210,y=151},{{64,112},{8,8}},true,13,false, "stone",true,{x=16,y=16}},
              {{x=  210,y=167},{{64,112},{8,8}},false,14,false, "stone",true,{x=16,y=16}},
              {{x=  80,y=183},{{64,112},{8,8}},false,50,false, "stone",true,{x=16,y=16}},
              {{x=258,y=135},{{0 ,101},{15,15}},true,10,false, "grass",true,{x=16,y=16}},
              {{x=  500,y=151},{{64,112},{8,8}},true,23,false, "stone",true,{x=16,y=16}},
              {{x=  484,y=167},{{64,112},{8,8}},false,24,false, "stone",true,{x=16,y=16}},
              {{x=500,y=135},{{0 ,101},{15,15}},true,9,false, "grass",true,{x=16,y=16}},
              {{x=475,y=110},{{40,112},{8,8}},true,2,false, "brick",false,{}},
              {{x=630,y=119},{{123,112},{2,8}},false, 1, true, "", false,{}},
              {{x=635,y=110},{{123,112},{2,8}},false, 1, true, "", false,{}},
              {{x=632,y=102},{{120,96},{8,8}},false, 1, true, "", false,{}},
              {{x=780,y=110},{{123,112},{2,8}},false, 1, true, "", false,{}},
              {{x=777,y=102},{{120,96},{8,8}},false, 1, true, "", false,{}},
              {{x=621,y=124},{{112,115},{8,3}},true, 10, false, "", false,{}},
              {{x=707,y=119},{{123,112},{2,5}},false, 1, true, "", false,{}},
              {{x=800,y=119},{{123,112},{2,8}},false, 1, true, "", false,{}},
              {{x=740,y=124},{{112,115},{8,3}},true, 7, false, "", false,{}},
              {{x=748,y=119},{{123,112},{2,5}},false, 1, true, "", false,{}},
              {{x=780,y=135},{{0 ,101},{15,15}},true,5,false, "grass",true,{x=16,y=16}},

             {{x=150+700, y=48+75}, {{120,120},{8,8}},true,1,false,"grass"},--fp1a
              {{x=158+700, y=48+75}, {{103,120},{8,8}},true,1,false,"grass"},--fp2a
              {{x=142+700, y=48+75}, {{112,120},{8,8}},true,1,false,"grass"},--fp3a
              {{x=159+700, y=48+75}, {{95,120},{8,8}},true,1,false,"grass"},--fp4a
              {{x=158+700, y=27+75}, {{120,112},{8,8}},false,1,true,"flag"},--fp5a
              {{x=158+700, y=11+75}, {{120,112},{8,8}},false,1,true,"flag"},--fp6a  
              {{x=158+700, y=3+75}, {{120,112},{8,8}},false,1,true,"flag"},
              {{x=158+700, y=19+75}, {{120,112},{8,8}},false,1,true,"flag"},--i got lazy and just added 700 instead of changing the values.
              {{x=158+700, y=32+75}, {{120,112},{8,8}},false,1,true,"flag"},
              {{x=150+700, y=3+75}, {{120,104},{8,8}},false,1,false,"flag"},
              {{x=150+700, y=-3+75}, {{120,96},{8,8}},false,1,false,"flag"}
            }

        --LEVEL 1 INITS--
        cteddy({x=10,y=-30},{x=0,y=0}, true)
        coina = ccoin({x=-20, y=115}, {x=0,y=0})
        coinb = ccoin({x=450, y=115}, {x=0,y=0})
        goomba1a = cgoomba({x=0,y=30}, {x=.2,y=0})
        turtleb = cturtle({x=360, 0,y=0}, {x=-.1,y = 0},"green")
        turtlea = cturtle({x=30,y=-20},{x=0,y=0},"red")
        turtlec = cturtle({x=810,y=110},{x=0,y=0},"red")
        goombac = cgoomba({x=820,y=0}, {x=.2,y=0})



        --grass1={{}}
        --map.tile(point init (bottom left),
                --spriteset
                --do col (whether to do col --> only on top))
                --count (number of them) --> square it for blocks
                --xy -->whether to do x or y (this doesn't matter when you do param9)
                --grountType-->string, how it behaves
                --scaled --> idk but don't worry about it for now (bool)
                --localscale --> idk but don't worry about it for now (vect2)
                --block-->if it is a square block or not
        --example usage, not a block

        jpad1=newent({x=410,y=127},{{65,8,16,8}},{x=16,y=8},{x=0,y=0},"pad")
        jpad1.drawn = false
        jpad1.physics = false
        jpad1.anim = {true,0}
        ba1 = {{x=80,y=20},{{0,101},{15,15}},true,3,false, "brick", true, {8, 8}, false}
        --example usage, not a block
        ga = {{x=-120,y=20},{{17,101},{15,15}},true,100,false, "grass",true,{x=8,y=8}}
        --example usage, a block
        --gblock = {{x=-120,y=20},{{17,101},{15,15}},true,100,false, "grass",true,{x=8,y=8}, true}
        --ba2 = {{x=-20,y=40},{{11,77},{8,8}},true,3,false, "", true, {8,8}, false}
        --ba3 = {{x=0,y=30},{{0,101},{15,15}},true,1,false, "brick", true, {8, 8}, false}
        --ba4 = {{x=30,y=40},{{40,112},{8,8}},true,2,false, "brick", false, {}, false, false}
    --ba2, ba3, ba4,


        
        ga = {{x=-120,y=20},{{17,101},{15,15}},true,100,false, "grass",true,{x=8,y=8}}


        fenda = newent({x=850,y=80},{{112,104,8,8},{104,104,8,8},{96,104,8,8},{88,104,8,8},{80,104,8,8},{72,104,8,8},{64,104,8,8},{56,104,8,8},{48,104,8,8},{40,104,8,8}},{x=8,y=8},{x=0,y=0}, "flag")
        fenda.anim = {true, 0.1}
        fenda.type = "flag"
        fenda.drawn = false
        fenda.physics = false

        map1 = {}
        add(map1, {fenda, teddy, coina, coinb, goomba1a,  turtlea, jpad1,turtleb, goombac, turtlec})
        --{fenda, fp1a,fp2a,fp3a,fb1a,fb2a,fb3a,fp4a,fb4a,fp5a,f1a,f2a,ba1, ga, gblock}
        add(map1, level1blocks)
        add(map1, 12)

        add(GAME.levels, map1)

GAME.logo = {0, 118, 26, 10}
GAME.MINIGUI = {
                {27, 123, 8, 5}
                }
GAME.paused = true
GAME.start = function(self)
    Particles.clear()
    GAME.paused = false
    GAME.currlevel = 1
    GAME.loadLevel()
end

GAME.draw = function(self)

    if (GAME.paused)
    then
        while (GAME.drawnClouds < GAME.cloudCount)
        do
            --cloud render space:
            particle({x=-64 + rnd(120),y=-60 + rnd(30) - rnd(15)},1, 100, 5, {x=.05 + rnd(.5),y=0}, {x=0,y=0}, 0, {106+(flr(rnd(2)) * 8),1+ ((flr(rnd(2)) * 6)), 8, 7, 15, 15}, true, true)
            particle({x=-120 + rnd(120),y=-60 + rnd(30) - rnd(15)},1, 100, 5, {x=.05 + rnd(.5),y=0}, {x=0,y=0}, 0, {106+(flr(rnd(2)) * 8), 0, 8, 7, 15, 15}, true, true)
            GAME.drawnClouds += 2
        end
        rands = {0, 1}
        j = rnd(rands)
        del(j, rands)
        particle({x= bti(GAME.buttonSelected) * 30 - bti(not GAME.buttonSelected) * 30 ,y=(rnd(60))},9 + rnd(1),1,1,{x=rnd(1) - rnd(1),y=-5}, {x=0,y=.5}, 1, 4 + rnd(2), true, false)
        
        Particles.update()
        if (GAME.currlevel == 0)
        then
            if (btnp(0))
            then
                GAME.buttonSelected=false

            end
            if(btnp(1))
            then
                GAME.buttonSelected=true
            end
            print("THE ADVENTURES OF: PIXEL", -60, -40, 9)

            line(-56, -33, 35, -33, 9)
            line(-55, -32, 36, -32, 1)
            

            --logo
            sspr(GAME.logo[1],GAME.logo[2],GAME.logo[3],GAME.logo[4], -55, -28, 104, 40)

            line(-50, 15, 49, 15, 9)
            line(-49, 16, 50, 16, 1)
            button1 = {-40, 35}
            sspr(GAME.MINIGUI[1][1],GAME.MINIGUI[1][2],GAME.MINIGUI[1][3],GAME.MINIGUI[1][4], button1[1], button1[2]+ (2 * sin(2*time()) * bti(not GAME.buttonSelected)), 24, 15)
            print("pLAY", button1[1]+4, button1[2]+5+ (2 * sin(2*time()) * bti(not GAME.buttonSelected)), 5)
            print("x", button1[1]+2, button1[2]+12+ (2 * sin(2*time()) * bti(not GAME.buttonSelected)), 0)
            
            button2 = {20, 35}
            sspr(GAME.MINIGUI[1][1],GAME.MINIGUI[1][2],GAME.MINIGUI[1][3],GAME.MINIGUI[1][4], button2[1], button2[2]+ (2 * sin(2*time()) * bti(GAME.buttonSelected)), 24, 15)
            print("mENU", button2[1]+4, button2[2]+5+ (2 * sin(2*time()) * bti(GAME.buttonSelected)), 5)
            print("y", button2[1]+2, button2[2]+12+ (2 * sin(2*time()) * bti(GAME.buttonSelected)), 0)
                
            for i=-100, 450, 15
            do
                sspr(0, 101, 15, 15, i, 60)
            end

        else
            --menu
        end
    end
end
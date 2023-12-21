--tiling function--
map = {}
map.tiles = {}
--xy is t/f here for x and y increasing respectively
--scaled false for tile, true for scaled tile
map.tile = function(p1, sprset, doCol, count, xy, groundType, scaled, localScale, block)
    currPos=0
    j = 0
    
    --loop for creating tiles
    while (j < count)
    do
        --incriment the current position off of p1
        if (scaled)
        then
            currPos += (localScale.x * bti(not xy) + localScale.y * bti(xy))
        else
            currPos += (sprset[2][1] * bti(not xy) + sprset[2][2] * bti(xy))
        end

        
        --create an entity for the tile, easy cheat
        local n = newent({x=(bti(not xy)*currPos+p1.x),y=(bti(xy)*currPos)+p1.y},{{sprset[1][1],sprset[1][2],sprset[2][1],sprset[2][2]}},{x=sprset[2][1],y=sprset[2][2]},{x=0,y=0}, "ground")
        --whether the tile is extended up or right
        n.xy = xy
        --the standard animation disable status I use is {false, Fch0}
        n.anim = {false, 0}
        --whether the tile is scaled from its size on the spritesheet
        n.scaled = scaled
        --the size the object takes up if it is scaled, DNA otherwise
        n.localScale = localScale
        --the way the tile behavesh
        n.type = "ground"
        --whether the ground is collideable -- im not totally sure this works, well see, maybe non collibale are triggers who knows
        n.doCol = doCol
        --the type of the ground, also how it behavesh
        n.groundType = groundType
        --to make flipped textures so they match on each side :) neat
        n.flipped = ((j%2) and 1 or 0)
        --add to the tile list
        add(map.tiles, n)
        --add the entity to the list of entities
        add(entities, n)
        --increase the current count
        j+=1
        --I have no clue what the fuck this is LOL
        if (n.groundType == "grass")
        then
            n.grassSpawned = false --what
        end
    end
    --nonfunctional
    if (block)
    then
        l = 0
        while (l < count)
        do
            --determines if it should go down or right
            currPos += (sprset[2][1] * bti(xy) + sprset[2][2] * bti(not xy))
            local n = newent({x=(bti(not xy)*currPos+p1.x),y=(bti(xy)*currPos)+p1.y},{{sprset[1][1],sprset[1][2],sprset[2][1],sprset[2][2]}},{x=sprset[2][1],y=sprset[2][2]},{x=0,y=0}, "ground")
            n.xy = not xy
            n.anim = {false, 0}
            n.scaled = scaled
            n.localScale = localScale
            n.type = "ground"
            n.doCol = doCol
            n.groundType = groundType
            add(map.tiles, n)
            add(entities, n)
            l+=1
            if (n.groundType == "grass")
            then
                n.grassSpawned = false
            end
        end
    end
end


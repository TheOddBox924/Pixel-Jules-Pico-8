--Entity Animator--

function animator(sprset, framerate, curr, type)
    --if (curr == nil)
    --then
    --    curr = 1
    --end
    if (type == "player")
    then
        if (time() - 😐.lt >= framerate)
        then
            curr+=1
            sfx(2)
            if (curr > count(sprset))
            then
                curr = 1
            end
            😐.lt = time()
        end
    
    elseif (type == "enemy")
    then
        for enemy in all (entities)
        do
            if (enemy.type == type)
            then
                if (time() - enemy.lt >= framerate)
                then
                    curr+=1
                    if (curr > count(sprset))
                    then
                        curr = 1
                    end
                    enemy.lt = time()
                end
            end
        end
    elseif (type == "dog")
    then
        if (time() - teddy.lt >= framerate)
        then
            curr+=1
            if (curr > count(sprset))
            then
                curr = 1
            end
            teddy.lt = time()
        end
    elseif (type == "flag")
    then
        if (time() - fenda.lt >= framerate)
        then
            curr+=1
            if (curr > count(sprset))
            then
                curr = 1
            end
            fendb.lt = time()
            fenda.lt = time()
       end
    end
    return curr
end 
function bti(b)
    return b and 1 or 0
end

function itb(i)
    b=false
    if (i == 1)
    then
        b=true
    end
    return b
end


--returns a list of the inputs from btn
--used to simplify some stuff
--1-4:L,R,U,D, 5: 'z', 
--6  : 'x',    7: 'c'.
function input() 
    local l = {btn(0),btn(1),btn(2),btn(3), btn(4), btn(5), btn(6)} 
    return l
end

--useful function! sqrt is either lua or pico
function distance2D(v1, v2)
    return (sqrt((v1.x-v2.x)^2 + ((-v1.y)-(-v2.y))^2))
end

--why lmfao
function value(v)
    local x=v
    return x
end

--from stack overflow
--more efficient than the one I made
function sign(x)
    return x>0 and 1 or x<0 and -1 or 0
  end

--slerp doesn't work but I want to make it work soemtime...
function slerp(vec1x, vec2x, vec1y, vec2y, smoothing)
    dx = 0  dy = 0

    if (vec1x> vec2x)
    then
        dx = distance2D({x=vec1x,y=vec1y}, {x=vec2x,y=vec2y}) * -smoothing
    elseif (vec1x < vec2x)
    then
        dx = distance2D({x=vec1x,y=vec1y}, {x=vec2x,y=vec2y}) * smoothing
    end
    if (vec1y > vec2y)
    then
        dy = distance2D({x=vec1x,y=vec1y}, {x=vec2x,y=vec2y}) * -smoothing
    elseif (vec1y < vec2y)
    then
        dy = distance2D({x=vec1x,y=vec1y}, {x=vec2x,y=vec2y}) * smoothing
    end

    return {x=vec1x+dx, y=vec1y+dy}
end

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

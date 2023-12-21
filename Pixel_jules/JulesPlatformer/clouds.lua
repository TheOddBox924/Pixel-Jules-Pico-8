--Scenery
clouds = {}
clouds[1] = {pos={x=10,y=10}}


function cloudDraw()
    for cloud in all (clouds) do
        spr(39, cloud.pos.x, cloud.pos.y)
    end
end
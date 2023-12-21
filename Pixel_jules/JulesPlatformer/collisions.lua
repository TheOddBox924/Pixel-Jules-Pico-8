--Collisions--
function alt_collision(o1, o2)
  --add to objects: precalculated center
  --add to objects: hbox
  hit = false
   xd=abs((o1.pos.x+(o1.hbox.x/2))-(o2.pos.x+(o2.hbox.x/2)))
   xs=(o1.hbox.x*0.5+o2.hbox.x*0.5)
   yd=abs((o1.pos.y+(o1.hbox.y/2))-(o2.pos.y+(o2.hbox.y/2)))
   ys=(o1.hbox.y/2+o2.hbox.y/2)

  --for hit:
    --xd < xs
    --xs: w1/2+w2/2
        --the max dist b4 col
    --xd: dist between centers
    if (xd < xs and yd < ys)
    then
        hit = true
    end

  return hit
end

function collision(o1, o2)
  -- Calculate the bounding boxes for each object
  local x1 = o1.pos.x - o1.hbox.x / 2
  local y1 = o1.pos.y - o1.hbox.y / 2
  local x2 = o2.pos.x - o2.hbox.x / 2
  local y2 = o2.pos.y - o2.hbox.y / 2
  local w1 = o1.hbox.x
  local h1 = o1.hbox.y
  local w2 = o2.hbox.x
  local h2 = o2.hbox.y
  
  -- Check for collision between the two bounding boxes
  return x1 < x2 + w2 and x2 < x1 + w1 and y1 < y2 + h2 and y2 < y1 + h1
end
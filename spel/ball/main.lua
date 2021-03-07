world = {
    ["framerate"]= 0,
    ["framerateUpdate"]= 1,
    ["frameratePositionX"]= 10,
    ["frameratePositionY"]= 10,
    ["time"]= 1
}

farmer = {
    ["movmentX"]= 0,
    ["movmentY"]= 0,
    ["positionX"]= 400,
    ["positionY"]= 300,
    ["farmerSize"]= 20,
    ["sped"]= 100,
    ["handY"]= 200,
    ["handX"]= 300,
    ["handSize"]= 10,
    ["hand_distens"]= 30,
    ["isHand"]= false,
    ["HandAbelToHit"]= true,
    ["handangel"]= 0,
    ["handangelSpeed"]= 10,
    ["handSvingDistens"] = math.pi,
    ["handSvingMiddel"] = 0

}


objects = {
    ["trees"] = {
        {["x"] = 50,["y"] = 50,["size"]=20,["helth"]= 4},
        {["x"] = 100,["y"] = 100,["size"]=30 ,["helth"]= 4 }
    }
}

cirkleKolider = function (positionx,positiony,size,table)
    for index, value in ipairs(table) do
        if distansBetwen(positiony,positionx,table[index].x,table[index].y) < (size + table[index].size) then
            -- print(distansBetwen(positiony,positionx,table[index].x,table[index].y))
            -- print(size + table[index].size)
            return index
        end
    end
    return false
end
distansBetwen = function (firstX,firstY,sekonX,sekondY)
    return math.sqrt(((firstX-sekonX)*(firstX-sekonX))+((firstY-sekondY)*(firstY-sekondY)))
 
 end

    
    love.keypressed = function (key)
        --farmer key preses--
        if key == "w" then
                farmer.movmentY = 1 - farmer.sped
        end
        if key == "s" then
                farmer.movmentY = farmer.sped
        end
        if key == "a" then
                farmer.movmentX = 1 - farmer.sped
        end
        if key == "d" then
                farmer.movmentX = farmer.sped
        end
    end
    love.keyreleased =function (key)
        if key == "w" then
            farmer.movmentY = 0
        end
         if key == "s" then
            farmer.movmentY = 0
        end
        if key == "a" then
            farmer.movmentX = 0
        	end
        if key == "d" then
            farmer.movmentX = 0
        end
    end
    function love.mousepressed(x, y, button, istouch)
        if button == 1 and farmer.isHand == false then 
            if farmer.positionX < x then
                farmer.handSvingMiddel = math.atan((y - farmer.positionY)/(x - farmer.positionX ))
                farmer.isHand = true
                farmer.handangel = farmer.handSvingMiddel - farmer.handSvingDistens/2 
            end
            if farmer.positionX > x then
                farmer.handSvingMiddel = math.pi + math.atan((y - farmer.positionY)/(x - farmer.positionX ))
                farmer.isHand = true
                farmer.handangel = farmer.handSvingMiddel - farmer.handSvingDistens/2 
            end
            farmer.HandAbelToHit = true
    
        end
     end

love.update = function (deltaTime)
    world.time = world.time + deltaTime
    if world.time > world.framerateUpdate then
        world.framerate = math.floor(1/deltaTime)
        world.time=0
    end
    -- world.framerate = math.floor(1/deltaTime)
    --farmer kolition och movment--
    if cirkleKolider((farmer.positionX + (farmer.movmentX * deltaTime)),(farmer.positionY + (farmer.movmentY * deltaTime)),farmer.farmerSize,objects.trees) == false then
        farmer.positionX = farmer.positionX + (farmer.movmentX * deltaTime)
        farmer.positionY = farmer.positionY + (farmer.movmentY * deltaTime)
    end
    --hand--
    if farmer.isHand then
        farmer.handX = farmer.positionX + (math.cos(farmer.handangel) * farmer.hand_distens)
        farmer.handY = farmer.positionY + (math.sin(farmer.handangel) * farmer.hand_distens)
        farmer.handangel = farmer.handangel + (farmer.handangelSpeed * deltaTime)
        if farmer.handangel > farmer.handSvingMiddel + farmer.handSvingDistens/2 then
            farmer.isHand = false
        end
        --hand kolition--
        if cirkleKolider(farmer.handX,farmer.handY,farmer.handSize,objects.trees) ~= false and farmer.HandAbelToHit == true then
            farmer.HandAbelToHit = false
            print(objects.trees[cirkleKolider(farmer.handX,farmer.handY,farmer.handSize,objects.trees)].helth)
            objects.trees[cirkleKolider(farmer.handX,farmer.handY,farmer.handSize,objects.trees)].helth = objects.trees[cirkleKolider(farmer.handX,farmer.handY,farmer.handSize,objects.trees)].helth - 1 
            print(objects.trees[cirkleKolider(farmer.handX,farmer.handY,farmer.handSize,objects.trees)].helth)
            if objects.trees[cirkleKolider(farmer.handX,farmer.handY,farmer.handSize,objects.trees)].helth <= 0 then
                print(objects.trees[cirkleKolider(farmer.handX,farmer.handY,farmer.handSize,objects.trees)].helth)
                -- objects.trees[cirkleKolider(farmer.handX,farmer.handY,farmer.handSize,objects.trees)] = nil
                table.remove(objects.trees,cirkleKolider(farmer.handX,farmer.handY,farmer.handSize,objects.trees))
            end
        end
    end
end

love.draw=function ()
    love.graphics.setBackgroundColor( 0.3, 0.5, 0, 1 )
    
    --drawing farmer--
    love.graphics.setColor(1, 1, 0)
    love.graphics.circle("fill", farmer.positionX, farmer.positionY, farmer.farmerSize)
    love.graphics.setColor(0.5, 0.5, 0)
    love.graphics.circle("fill", farmer.positionX, farmer.positionY, farmer.farmerSize / 2)
    --hand--
    if farmer.isHand then
        love.graphics.setColor(0.5, 0, 0)
        love.graphics.circle("fill", farmer.handX, farmer.handY, farmer.handSize)
    end
    --ritar träd--
    love.graphics.setColor(0.5, 0.8, 0)
    for index, value in ipairs(objects.trees) do
        love.graphics.circle("fill", objects.trees[index].x , objects.trees[index].y , objects.trees[index].size )
    end
    --overlais--
    love.graphics.setColor(1, 1, 1)
    love.graphics.print( world.framerate, world.frameratePositionX, world.frameratePositionY)
end
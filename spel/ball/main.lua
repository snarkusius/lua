farmer = {
    ["movmentX"]=0,
    ["movmentY"]=0,
    ["positionX"]=400,
    ["positionY"]=300,
    ["farmerSize"]=20,
    ["sped"]=100

    }
trees = {
    {["x"] = 50,["y"] = 50,["size"]=20 },
    {["x"] = 100,["y"] = 100,["size"]=30 }
}
cirkleKolider = function (positionx,positiony,size,table)
    for index, value in ipairs(table) do
        if distansBetwen(positiony,positionx,table[index].x,table[index].y) < (size + table[index].size) then
            print(distansBetwen(positiony,positionx,table[index].x,table[index].y))
            print(size + table[index].size)
            return true
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

love.update = function (deltaTime)
    --farmer kolition och movment--
    if cirkleKolider((farmer.positionX + (farmer.movmentX * deltaTime)),(farmer.positionY + (farmer.movmentY * deltaTime)),farmer.farmerSize,trees) == false then
        farmer.positionX = farmer.positionX + (farmer.movmentX * deltaTime)
        farmer.positionY = farmer.positionY + (farmer.movmentY * deltaTime)
    end
end

love.draw=function ()
    --drawing farmer--
    love.graphics.setBackgroundColor( 0.3, 0.5, 0, 1 )
    love.graphics.setColor(1, 1, 0)
    love.graphics.circle("fill", farmer.positionX, farmer.positionY, farmer.farmerSize)
    love.graphics.setColor(0.5, 0.5, 0)
    love.graphics.circle("fill", farmer.positionX, farmer.positionY, farmer.farmerSize / 2)
    --ritar träd--
    for index, value in ipairs(trees) do
        love.graphics.circle("fill", trees[index].x , trees[index].y , trees[index].size )
    end

end
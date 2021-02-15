ball = {
    ["spedX"]=100,
    ["spedY"]=100,
    ["positionX"]=400,
    ["positionY"]=300,
    ["ballSize"]=50
    }
padel1 = {
    ["positionX"]=20,
    ["positionY"]=300,
    ["sizeX"]=10,
    ["sizeY"]=100,
    ["Sped"]= 100,
    ["isMoving"]=0
    }
padel2 = {
    ["positionX"]=20,
    ["positionY"]=300,
    ["sizeX"]=10,
    ["sizeY"]=100,
    ["Sped"]= 100,
    ["isMoving"]=0
    }
love.load=function ()

end
love.keypressed = function (key)
    --left padel--
    if key == "w" then
            padel1.isMoving = -1
    end
    if key == "s" then
            padel1.isMoving = 1
    end
end
love.keyreleased =function (key)
    --left padel--
    if key == "w" then
        padel1.isMoving = 0
    end
    if key == "s" then
            padel1.isMoving = 0
    end
    end

love.update = function (deltaTime)
    --padel movement--
    if (padel1.positionY < (600 - padel1.sizeY) and padel1.isMoving == 1) or (padel1.positionY > 0 and padel1.isMoving == -1) then
        padel1.positionY = padel1.positionY + (padel1.isMoving * padel1.Sped * deltaTime)
    end
    --ball to padel coliton--
    --left
if ball.positionX < (padel1.positionX+padel1.sizeX +ball.ballSize) and ball.positionY > padel1.positionY and ball.positionY < (padel1.positionY + padel1.sizeY) then
        if ball.spedX<0 then
            ball.spedX = ball.spedX * -1
        end
        
    end
    
    --ball to side collition--
    --rigt--
    if ball.positionX>800 then
        if ball.spedX>0 then
            ball.spedX = ball.spedX * -1
        end
        
    end
    --left
    if ball.positionX<0 then
        if ball.spedX<0 then
            ball.spedX = ball.spedX * -1
        end
    end
    
    --botom--
    if ball.positionY>600 then
        if ball.spedY>0 then
            ball.spedY = ball.spedY * -1
        end
    end
    --top--
    if ball.positionY<0 then
        if ball.spedY<0 then
            ball.spedY = ball.spedY * -1
        end
    end
    --aply--
    ball.positionX = ball.positionX + ball.spedX * deltaTime
    ball.positionY = ball.positionY + ball.spedY * deltaTime
    end 
love.draw=function ()
    --drawing ball--
    love.graphics.circle("fill", ball.positionX, ball.positionY, ball.ballSize)
    --drawing paddels--
    love.graphics.rectangle("line", padel1.positionX, padel1.positionY, padel1.sizeX, padel1.sizeY)
end
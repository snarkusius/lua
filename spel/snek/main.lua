ball = {
    ["spedX"]=200,
    ["spedY"]=200,
    ["positionX"]=400,
    ["positionY"]=300,
    ["ballSize"]=10
    }
ballreset = {
    ["spedX"]=200,
    ["spedY"]=200,
    ["positionX"]=400,
    ["positionY"]=300,
    ["ballSize"]=10
    }
padel1 = {
    ["positionX"]=20,
    ["positionY"]=300,
    ["sizeX"]=10,
    ["sizeY"]=100,
    ["Sped"]= 200,
    ["isMoving"]=0
    }
padel2 = {
    ["positionX"]=770,
    ["positionY"]=300,
    ["sizeX"]=10,
    ["sizeY"]=100,
    ["Sped"]= 200,
    ["isMoving"]=0
    }

randomVec = function (anglestart,angleend)
    --vinkel 0 är åt höger och ökar motsols--
    math.randomseed(love.timer.getTime( ))
    local angel = math.random(anglestart*100,angleend*100)/100
    local vektor = {["x"] = 0,["y"] = 0}
    vektor.x = math.cos(angel)
    vektor.y = math.sin(angel)
    return vektor
end

killed = function (vinner)
    ball.ballSize = ballreset.ballSize
    ball.positionX = ballreset.positionX
    ball.positionY = ballreset.positionY
    local vektor = randomVec(0,3.141592)
    ball.spedX = vektor.x * ballreset.spedX
    ball.spedY = vektor.y * ballreset.spedY
end
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
    --right padel--
    if key == "up" then
        padel2.isMoving = -1
    end
    if key == "down" then
        padel2.isMoving = 1
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
    if key == "up" then
        padel2.isMoving = 0
    end
    if key == "down" then
        padel2.isMoving = 0
    end
end

love.update = function (deltaTime)
    --padel movement--
    if (padel1.positionY < (600 - padel1.sizeY) and padel1.isMoving == 1) or (padel1.positionY > 0 and padel1.isMoving == -1) then
        padel1.positionY = padel1.positionY + (padel1.isMoving * padel1.Sped * deltaTime)
    end
    if (padel2.positionY < (600 - padel2.sizeY) and padel2.isMoving == 1) or (padel2.positionY > 0 and padel2.isMoving == -1) then
        padel2.positionY = padel2.positionY + (padel2.isMoving * padel2.Sped * deltaTime)
    end
    --ball to padel coliton--
    --left
if ball.positionX < (padel1.positionX+padel1.sizeX +ball.ballSize) and ball.positionY > padel1.positionY and ball.positionY < (padel1.positionY + padel1.sizeY) then
        if ball.spedX<0 then
            ball.spedX = ball.spedX * -1
        end
        
    end
    --right--
if ball.positionX > (padel2.positionX - ball.ballSize) and ball.positionY > padel2.positionY and ball.positionY < (padel2.positionY + padel2.sizeY) then
        if ball.spedX>0 then
            ball.spedX = ball.spedX * -1
        end
        
    end
    
    --ball to side collition--
    --rigt--
    if ball.positionX>800 then
        if ball.spedX>0 then
            -- ball.spedX = ball.spedX * -1--
            killed()
        end
        
    end
    --left
    if ball.positionX<0 then
        if ball.spedX<0 then
            -- ball.spedX = ball.spedX * -1--
            killed()
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
    love.graphics.rectangle("line", padel2.positionX, padel2.positionY, padel2.sizeX, padel2.sizeY)
end
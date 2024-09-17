_G.love = require("love")

function love.load()
    love.graphics.setBackgroundColor(150 / 255, 211 / 255, 1)
    width, height = love.graphics.getDimensions()

    _G.ping = {}
    ping.x = 30
    ping.y = 370
    ping.width = 30
    ping.height = 100
    ping.speed = 0.6

    _G.pong = {}
    pong.x = 940
    pong.y = 370
    pong.width = 30
    pong.height = 100
    pong.speed = 0.6

    _G.ball = {}
    ball.x = width/2
    ball.y = height/2
    ball.speed = 0.5
    ball.dx = 200
    ball.dy = 200
    ball.r = 15
end

function love.update(dt)

    if love.keyboard.isDown("up") and ping.y >= 0 then
        ping.y = ping.y - ping.speed
    end 
    if love.keyboard.isDown("down") and ping.y <= height-100 then
        ping.y = ping.y + ping.speed
    end 
    if love.keyboard.isDown("w") and pong.y >= 0 then
        pong.y = pong.y - pong.speed
    end 
    if love.keyboard.isDown("s") and pong.y <= height-100 then
        pong.y = pong.y + pong.speed
    end 
    
    ball.x = ball.x + ball.dx * dt
    ball.y = ball.y + ball.dy * dt

    if ball.y <= 0 or ball.y + ball.r >= height then
        ball.dy = -ball.dy
    end
    if ball.x + ball.r >= pong.x and ball.x <= pong.x + pong.width and ball.y <= pong.y + pong.height and ball.y + ball.r >= pong.y then
        ball.dx = -ball.dx
        
    elseif ball.x + ball.r >= ping.x and ball.x <= ping.x + ping.width and ball.y <= ping.y + ping.height and ball.y + ball.r >= ping.y then
        ball.dx = -ball.dx
    end

   if ball.x + ball.r <= 0 or ball.x + ball.r >= width then
    --love.graphics.print("GAME OVER", 400, 500)
    --love.event.quit()
   end

end

function love.draw()
    textCoord = "X: " .. tostring(ball.x) .. "\nY: " .. tostring(ball.y)
    textFont = love.graphics.newFont(100)
    love.graphics.setColor(0,0,0)
    love.graphics.print(textCoord, 100, 300)

    love.graphics.rectangle("fill", ping.x, ping.y, ping.width, ping.height)
    love.graphics.rectangle("fill", pong.x, pong.y, pong.width, pong.height)

    love.graphics.circle("fill", ball.x, ball.y, ball.r)
end

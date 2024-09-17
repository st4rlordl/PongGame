_G.love = require("love")

function love.load()
    love.graphics.setBackgroundColor(150 / 255, 211 / 255, 1)
    width, height = love.graphics.getDimensions()
    math.randomseed(os.time())
    _G.gameover = true
    score = 0
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
    ball.dx = 0
    ball.dy = 0
    ball.r = 15

end

function dir_ball(num)
    local dir = math.random(2)
    if dir == 1 then
        num = -num
    end
    return num
end
function loose()
    gameover = true
    ball.x = width/2
    ball.y = height/2
    ball.dx = 0
    ball.dy = 0
    ping.x = 30
    ping.y = 370
    pong.x = 940
    pong.y = 370
    
end
function start()
    gameover = false
    ball.dx = dir_ball(200)
    ball.dy = dir_ball(200)
    score = 0
end


function love.update(dt)

    -- input
    if love.keyboard.isDown("up") and ping.y >= 0 and not gameover then
        ping.y = ping.y - ping.speed
    end 
    if love.keyboard.isDown("down") and ping.y <= height-100 and not gameover then
        ping.y = ping.y + ping.speed
    end 
    if love.keyboard.isDown("w") and pong.y >= 0 and not gameover then
        pong.y = pong.y - pong.speed
    end 
    if love.keyboard.isDown("s") and pong.y <= height-100 and not gameover then
        pong.y = pong.y + pong.speed
    end 
    if love.keyboard.isDown("space") and gameover then
        start()
    end 
    -- speed of the ball
    ball.x = ball.x + ball.dx * dt
    ball.y = ball.y + ball.dy * dt

    if ball.y <= 0 or ball.y + ball.r >= height then
        ball.dy = -ball.dy
    end
    if ball.x + ball.r >= pong.x and ball.x <= pong.x + pong.width and ball.y <= pong.y + pong.height and ball.y + ball.r >= pong.y then
        ball.dx = -ball.dx
        score = score + 1
    elseif ball.x + ball.r >= ping.x and ball.x <= ping.x + ping.width and ball.y <= ping.y + ping.height and ball.y + ball.r >= ping.y then
        ball.dx = -ball.dx --probleme de hitbox
        score = score + 1
    end

   if ball.x + ball.r <= 0 or ball.x + ball.r >= width then
        loose()
   end

end

function love.draw()
    love.graphics.setFont(love.graphics.newFont(24))
    textCoord = "X: " .. tostring(ball.x) .. "\nY: " .. tostring(ball.y)
    textScore = "Score : " .. tostring(score)
    love.graphics.setColor(0,0,0)
    love.graphics.print(textCoord, width-24*7, 0)
    love.graphics.print(textScore, 10, 10)
    love.graphics.setColor(255,255,255)
    love.graphics.rectangle("fill", ping.x, ping.y, ping.width, ping.height)
    love.graphics.rectangle("fill", pong.x, pong.y, pong.width, pong.height)

    love.graphics.circle("fill", ball.x, ball.y, ball.r)
end

require "src.dependencies"


function love.load()
    State = StateManager {
        ["start"] = function() return StartState() end,
        ["newGame"] = function() return NewGameState() end,
        ["play"] = function() return PlayState() end,
        ["over"] = function() return GameOverState() end,
        ["pause"] = function() return PauseState() end,
    }

    State:change("start")

    Assets.audio["music3"]:play()
    Assets.audio["music3"]:setLooping(true)
end

function love.update(dt)
    Timer.update(dt)
    State:update(dt)
    App:update()
end

function love.draw()
    Push:start()
    Assets:drawBackground()
    State:draw()
    Push:finish()
end

function love.keypressed(key)
    App.keysPressed[key] = true
end

function love.mousepressed(x, y, button, istouch, presses)
    App.mousePressed[tostring(button)] = true
end

require "src.dependencies"

function love.load()
    State = StateManager {
        ["start"] = function() return StartState() end,
        ["newGame"] = function() return NewGameState() end,
        ["play"] = function() return PlayState() end,
        ["over"] = function() return GameOverState() end,
    }

    State:change("start")
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

require "src.dependencies"

function love.load()
    State = StateManager {
        ["start"] = function() return StartState() end,
    }

    State:change("start")
end

function love.update(dt)
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

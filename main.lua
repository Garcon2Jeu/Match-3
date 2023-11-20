require "src.dependencies"

function love.load()

end

function love.update(dt)
    App:update()
end

function love.draw()
    Push:start()
    Push:finish()
end

function love.keypressed(key)
    App.keysPressed[key] = true
end

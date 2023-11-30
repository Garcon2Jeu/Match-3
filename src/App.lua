App = Class {}


function App:init()
    math.randomseed(os.time())
    self.setupWindow()

    self.keysPressed = {}
    self.mousePressed = {}
    self.canInput = true
end

function App:update()
    self:quit()
    self:flushKeys()
    self:flushButtons()
end

function App.setupWindow()
    love.window.setTitle("Match 3 - Project")
    love.graphics.setDefaultFilter("nearest", "nearest")
    Push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resize = false,
        vsync = true
    })
end

function App:wasKeyPressed(key)
    if self.canInput then
        return self.keysPressed[key]
    end

    return self.canInput
end

function App:wasMousePressed(button)
    if self.canInput then
        return self.mousePressed[button]
    end

    return self.canInput
end

function App:quit()
    if self:wasKeyPressed("escape") then
        love.event.quit()
    end
end

function App:flushKeys()
    self.keysPressed = {}
end

function App:flushButtons()
    self.mousePressed = {}
end

function App:enableInput(bool)
    self.canInput = bool
end

function App:chainEnableInput(bool)
    return function(next)
        self:enableInput(bool)
        return next
    end
end

return App()

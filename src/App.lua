App = Class {}

function App:init()
    math.randomseed(os.time())
    self.setupWindow()
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

return App()

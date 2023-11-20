AssetsManager = Class {}

function AssetsManager:init()
    self.graphics = self.getGraphics()
    self.audio    = self.getAudio()
    self.fonts    = self.getFonts()
    self.colors   = self.getColors()
end

function AssetsManager.getGraphics()
    return {
        ["background"] = love.graphics.newImage("assets/graphics/background.png"),
        ["match3"]     = love.graphics.newImage("assets/graphics/match3.png"),
    }
end

function AssetsManager.getAudio()
    return {
        ["clock"]      = love.audio.newSource("assets/audio/clock.wav", "static"),
        ["error"]      = love.audio.newSource("assets/audio/error.wav", "static"),
        ["game-over"]  = love.audio.newSource("assets/audio/game-over.wav", "static"),
        ["math"]       = love.audio.newSource("assets/audio/match.wav", "static"),
        ["music"]      = love.audio.newSource("assets/audio/music.mp3", "static"),
        ["music2"]     = love.audio.newSource("assets/audio/music2.mp3", "static"),
        ["music3"]     = love.audio.newSource("assets/audio/music3.mp3", "static"),
        ["next-level"] = love.audio.newSource("assets/audio/next-level.wav", "static"),
        ["select"]     = love.audio.newSource("assets/audio/select.wav", "static"),
    }
end

function AssetsManager.getFonts()
    local small = love.graphics.newFont("assets/fonts/font.ttf", 8)
    local medium = love.graphics.newFont("assets/fonts/font.ttf", 16)
    local large = love.graphics.newFont("assets/fonts/font.ttf", 32)
    local huge = love.graphics.newFont("assets/fonts/font.ttf", 64)

    return {
        setSmall  = function() love.graphics.setFont(small) end,
        setMedium = function() love.graphics.setFont(medium) end,
        setLarge  = function() love.graphics.setFont(large) end,
        setHuge   = function() love.graphics.setFont(huge) end,
    }
end

function AssetsManager.getColors()
    return {
        reset = function() love.graphics.setColor(1, 1, 1, 1) end,
        setWhiteTransparent = function() love.graphics.setColor(1, 1, 1, .5) end,
        setBlack = function() love.graphics.setColor(0, 0, 0, 1) end,
    }
end

function AssetsManager:drawBackground()
    love.graphics.draw(self.graphics["background"], 0, 0, 0,
        VIRTUAL_WIDTH / (self.graphics["background"]:getWidth() - 1),
        VIRTUAL_HEIGHT / (self.graphics["background"]:getHeight() - 1)
    )
end

return AssetsManager()

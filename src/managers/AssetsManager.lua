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
    local palette = AssetsManager:getPallette()
    return {
        reset               = function() love.graphics.setColor(1, 1, 1, 1) end,
        setWhiteTransparent = function() love.graphics.setColor(1, 1, 1, .5) end,
        setBlack            = function() love.graphics.setColor(0, 0, 0, 1) end,
        setRed              = function() love.graphics.setColor(palette[1]) end,
        setBlue             = function() love.graphics.setColor(palette[2]) end,
        setYellow           = function() love.graphics.setColor(palette[3]) end,
        setPurple           = function() love.graphics.setColor(palette[4]) end,
        setGreen            = function() love.graphics.setColor(palette[5]) end,
        setOrange           = function() love.graphics.setColor(palette[6]) end,
        setDarkBlue         = function() love.graphics.setColor(48 / 255, 96 / 255, 130 / 255, 1) end,
    }
end

function AssetsManager.getPallette()
    return {
        [1] = { 217 / 255, 87 / 255, 99 / 255, 1 },
        [2] = { 95 / 255, 205 / 255, 228 / 255, 1 },
        [3] = { 251 / 255, 242 / 255, 54 / 255, 1 },
        [4] = { 118 / 255, 66 / 255, 138 / 255, 1 },
        [5] = { 153 / 255, 229 / 255, 80 / 255, 1 },
        [6] = { 223 / 255, 113 / 255, 38 / 255, 1 }
    }
end

function AssetsManager:drawBackground()
    love.graphics.draw(self.graphics["background"], 0, 0, 0,
        VIRTUAL_WIDTH / (self.graphics["background"]:getWidth() - 1),
        VIRTUAL_HEIGHT / (self.graphics["background"]:getHeight() - 1)
    )
end

return AssetsManager()

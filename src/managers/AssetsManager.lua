AssetsManager = Class {}

function AssetsManager:init()
    self.graphics = self.getGraphics()
    self.audio    = self.getAudio()
    self.fonts    = self.getFonts()
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
    local font = love.graphics.newFont("assets/fonts/font.ttf")

    return {
        ["setFont"] = function() love.graphics.setFont(font) end,
    }
end

return AssetsManager()

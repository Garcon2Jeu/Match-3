NewGameState = Class { __includes = BaseState }

local slideTime = .25
local slidePause = 1.5

function NewGameState:init()
    self.levelCardY = -100

    Chain(
        State:fade(0),
        self:slideLevelCard(CENTER_HEIGHT - 50),

        function(next)
            Timer.after(slidePause, next)
        end,

        self:slideLevelCard(VIRTUAL_HEIGHT),
        State:chainChange("play")
    )()
end

function NewGameState:slideLevelCard(targetY)
    return function(next)
        Timer.tween(slideTime, {
            [self] = { levelCardY = targetY }
        }):finish(next)
    end
end

function NewGameState:update(dt)
    Timer.update(dt)
end

function NewGameState:draw()
    Assets.colors.setPurple(.5)
    love.graphics.rectangle("fill", 0, self.levelCardY, VIRTUAL_WIDTH, 100)

    Assets.colors.setWhite()
    Assets.fonts.setLarge()
    love.graphics.printf("level 1", 0, self.levelCardY + 34, VIRTUAL_WIDTH, "center")
end

NewGameState = Class { __includes = BaseState }

function NewGameState:init()
    self.alphaTransition = 1
    self.levelCardY = -100

    Chain(
        function(next)
            Timer.tween(.25, {
                [self] = { alphaTransition = 0 }
            }):finish(next)
        end,

        self:slideLevelCard(CENTER_HEIGHT - 50),

        function(next)
            Timer.after(1.5, next)
        end,

        self:slideLevelCard(VIRTUAL_HEIGHT),

        function()
            State:change("start")
        end
    )()
end

function NewGameState:slideLevelCard(targetY)
    return function(next)
        Timer.tween(.5, {
            [self] = { levelCardY = targetY }
        }):finish(next)
    end
end

function NewGameState:update(dt)
    Timer.update(dt)
end

function NewGameState:draw()
    love.graphics.setColor(1, 1, 1, self.alphaTransition)
    love.graphics.rectangle("fill", 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    Assets.colors.reset()

    Assets.colors.setPurple(.5)
    love.graphics.rectangle("fill", 0, self.levelCardY, VIRTUAL_WIDTH, 100)

    Assets.colors.setWhite()
    Assets.fonts.setLarge()
    love.graphics.printf("level 1", 0, self.levelCardY + 34, VIRTUAL_WIDTH, "center")
end

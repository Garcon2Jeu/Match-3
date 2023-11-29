NewGameState = Class { __includes = BaseState }


local slideTime = .25
local slidePause = 1.5


function NewGameState:init()
    self.levelCardY = -100
end

function NewGameState:enter(params)
    self.player = params or PlayerManager()
    self.board = Board(self.player.level)

    Chain(
        State:fade(0),
        self:slideLevelCard(CENTER_HEIGHT - 50),

        function(next)
            Timer.after(slidePause, next)
        end,

        self:slideLevelCard(VIRTUAL_HEIGHT),
        State:chainChange("play", {
            board = self.board,
            player = self.player
        })
    )()
end

function NewGameState:slideLevelCard(targetY)
    return function(next)
        Timer.tween(slideTime, {
            [self] = { levelCardY = targetY }
        }):finish(next)
    end
end

function NewGameState:draw()
    self.board:draw()

    Assets.colors.setPurple(.5)
    love.graphics.rectangle("fill", 0, self.levelCardY, VIRTUAL_WIDTH, 100)

    Assets.colors.setWhite()
    Assets.fonts.setLarge()
    love.graphics.printf("level " .. tostring(self.player.level), 0, self.levelCardY + 34, VIRTUAL_WIDTH, "center")
end

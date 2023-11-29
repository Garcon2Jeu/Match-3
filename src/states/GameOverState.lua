GameOverState = Class { __includes = BaseState }

function GameOverState:init()
    Chain(State:fade(0))()
end

function GameOverState:enter(params)
    self.score = params
end

function GameOverState:update(dt)
    if App:wasKeyPressed("return") then
        Assets.audio["select"]:play()
        Chain(
            State:fade(1),
            State:chainChange("start")
        )()
    end
end

function GameOverState:draw()
    Assets.fonts.setHuge()

    Assets.colors.setBlack(.75)
    love.graphics.rectangle("fill", CENTER_WIDTH - 180, CENTER_HEIGHT - 80, 360, 60, 4)
    love.graphics.rectangle("fill", CENTER_WIDTH - 200, CENTER_HEIGHT - 12.5, 400, 60, 4)
    love.graphics.rectangle("fill", CENTER_WIDTH - 125, CENTER_HEIGHT + 92.5, 250, 30, 4)

    Assets.fonts.setHuge()

    Assets.colors.setWhite()
    love.graphics.printf("GAME OVER", 0, CENTER_HEIGHT - 78, VIRTUAL_WIDTH, "center")


    Assets.fonts.setLarge()
    love.graphics.printf("Final Score: " .. tostring(self.score), 0, CENTER_HEIGHT, VIRTUAL_WIDTH, "center")

    Assets.colors.setBlue()
    Assets.fonts.setMedium()
    love.graphics.printf("Press Enter to restart", 0, CENTER_HEIGHT + 100, VIRTUAL_WIDTH, "center")
end

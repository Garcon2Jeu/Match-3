PauseState = Class { __includes = BaseState }

local container = {
    x = 16,
    y = 132,
    width = 200,
    height = 100,
    cornerRadius = 4
}


function PauseState:enter(params)
    self.state = params
end

function PauseState:update(dt)
    if App:wasKeyPressed("p") then
        State:pause(self)
    end

    if App:wasKeyPressed("return") then
        State:change("start")
    end
end

function PauseState:draw()
    self.state:draw()

    Assets.colors.setBlack(.5)
    love.graphics.rectangle("fill", 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    Assets.colors.reset()


    Assets.colors.setBlack(.75)
    love.graphics.rectangle("fill", container.x, container.y, container.width, container.height, container.cornerRadius)
    Assets.colors.reset()


    love.graphics.printf("PAUSED", container.x, container.y + 30, container.x + container.width, "center")
    Assets.fonts.setSmall()
    love.graphics.printf("Press enter to start again", container.x, container.y + 55, container.x + container.width,
        "center")
    love.graphics.printf("Press P to unpause", container.x, container.y + 70, container.x + container.width,
        "center")
end

function PauseState:exit() end

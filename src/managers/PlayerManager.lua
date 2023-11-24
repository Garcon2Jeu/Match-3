PlayerManager = Class {}


local container = {
    x = -200,
    y = 16,
    width = 200,
    height = 100,
    cornerRadius = 4
}

function PlayerManager:init()
    self.score = 0
    self.level = 1
    self.goal  = 1250
    self.timer = 300


    Timer.every(1, function() self.timer = self.timer - 1 end)

    Timer.tween(.25, {
        [container] = { x = 16 }
    })
end

function PlayerManager:draw()
    Assets.colors.setBlack(.5)
    love.graphics.rectangle("fill",
        container.x,
        container.y,
        container.width,
        container.height,
        container.cornerRadius)
    Assets.colors.reset()

    Assets.fonts.setMedium()
    self:printDetails("Level: " .. tostring(self.level), container.y + 5)
    self:printDetails("Score: " .. tostring(self.score), container.y + 30)
    self:printDetails("Goal: " .. tostring(self.goal), container.y + 55)
    self:printDetails("Timer: " .. tostring(self.timer), container.y + 80)
end

function PlayerManager:printDetails(text, y)
    love.graphics.printf(text, container.x, y, container.x + container.width, "center")
end

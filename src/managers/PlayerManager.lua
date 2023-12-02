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
    self.level = 0
    self.goal  = 500
    self.timer = 60

    self:levelUp()
end

function PlayerManager:draw()
    self:drawUI()
end

function PlayerManager:drawUI()
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

function PlayerManager:slideContainer()
    Timer.tween(.25, {
        [container] = { x = 16 }
    })
end

function PlayerManager:startCountdown()
    self.countdown =
        Timer.every(1,
            function()
                self.timer = self.timer - 1

                if self.timer <= 15 then
                    Assets.audio["clock"]:play()
                end
            end)
end

function PlayerManager:removeCountDown()
    self.countdown:remove()
end

function PlayerManager:addToScore(matches)
    for key, match in pairs(matches) do
        for key, tile in pairs(match) do
            self.score = self.score + tile.pattern * 25

            if self:hasReachedGoal() then
                self.score = self.goal
                return
            end
        end
    end
end

function PlayerManager:hasReachedTimeLimit()
    return self.timer <= 0
end

function PlayerManager:hasReachedGoal()
    return self.score >= self.goal
end

function PlayerManager:levelUp()
    self.level = self.level + 1
    self.goal = self.goal + (self.level * 1000)
end

function PlayerManager:addBonusTime(matches)
    for key, match in pairs(matches) do
        self.timer = self.timer + 1
    end
end

function PlayerManager:resetTimer()
    self.timer = 60
end

ParticleManager = Class()


local yellow = Assets.getPallette()[3]


function ParticleManager:init()
    self.system = love.graphics.newParticleSystem(Assets.graphics["star"], 32)
    self.system:setParticleLifetime(.5, .7)
    self.system:setEmissionRate(4)
    self.system:setEmissionArea("normal", 80, 80)
    self.system:setSizeVariation(1)
    self.system:setColors(
        yellow[1], yellow[2], yellow[3], 1,
        yellow[1], yellow[2], yellow[3], 0
    )
end

function ParticleManager:update(dt)
    self.system:update(dt)
end

function ParticleManager:draw(x, y)
    love.graphics.draw(self.system, x, y, 0, .05, .05)
end

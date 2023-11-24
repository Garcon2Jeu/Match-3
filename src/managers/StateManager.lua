StateManager = Class {}

function StateManager:init(states)
    self.states = states or {}
    self.current = BaseState()
    self.alphaTransition = 0
end

function StateManager:change(stateName, enterParams)
    assert(self.states[stateName])
    self.current:exit()
    self.current = self.states[stateName]()
    self.current:enter(enterParams)
end

function StateManager:update(dt)
    self.current:update(dt)
end

function StateManager:draw()
    self.current:draw()
    self:drawTransition()
end

function StateManager:chainChange(stateName, enterParams)
    return function(next)
        self:change(stateName, enterParams)
    end
end

function StateManager:fade(alpha)
    return function(next)
        Timer.tween(.25, {
            [self] = { alphaTransition = alpha }
        }):finish(next)
    end
end

function StateManager:drawTransition()
    love.graphics.setColor(1, 1, 1, self.alphaTransition)
    love.graphics.rectangle("fill", 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    Assets.colors.reset()
end

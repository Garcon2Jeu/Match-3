StateManager = Class {}

function StateManager:init(states)
    self.states = states or {}
    self.current = BaseState()
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
end

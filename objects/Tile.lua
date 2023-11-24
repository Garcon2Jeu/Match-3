Tile = Class {}

function Tile:init(x, y, color, pattern)
    self.x       = x
    self.y       = y
    self.color   = color
    self.pattern = pattern
end

function Tile:update(dt) end

function Tile:draw()
    love.graphics.draw(Assets.graphics["match3"], Atlas.quads[self.color][self.pattern], self.x, self.y)
end

function Tile:enter(params) end

function Tile:exit() end

Tile = Class {}

function Tile:init(x, y, color, pattern, row, column)
    self.x           = x
    self.y           = y
    self.color       = color
    self.pattern     = pattern

    self.highlighted = false
    self.selected    = false

    self.row         = row
    self.column      = column
end

function Tile:update(dt) end

function Tile:draw()
    love.graphics.draw(Assets.graphics["match3"], Atlas.quads[self.color][self.pattern], self.x, self.y)

    love.graphics.setLineWidth(4)

    if self.highlighted then
        Assets.colors.setYellow()
        love.graphics.rectangle("line", self.x, self.y, Atlas.getTileSize(), Atlas.getTileSize(), 4)
    end

    if self.selected then
        Assets.colors.setWhite(.7)
        love.graphics.rectangle("fill", self.x, self.y, Atlas.getTileSize(), Atlas.getTileSize(), 4)
    end

    Assets.colors.reset()
end

function Tile:setHighlighted(highlight)
    self.highlighted = highlight
end

function Tile:setSelected(select)
    self.selected = select
end

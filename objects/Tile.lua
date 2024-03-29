Tile = Class {}

function Tile:init(x, y, color, pattern, row, column, shiny)
    self.x       = x
    self.y       = y
    self.color   = color
    self.pattern = pattern
    self.shiny   = shiny

    self:shine()

    self.highlighted = false
    self.selected    = false

    self.row         = row
    self.column      = column
    self.drawn       = true
end

function Tile:update(dt)
    if self.shiny then
        self.particles:update(dt)
    end
end

function Tile:draw()
    if not self.drawn then
        return
    end

    love.graphics.draw(Assets.graphics["match3"], Atlas.quads[self.color][self.pattern], self.x, self.y)

    love.graphics.setLineWidth(4)

    if self.highlighted then
        Assets.colors.setYellow()
        love.graphics.rectangle("line", self.x, self.y, TILESIZE, TILESIZE, 4)
    end

    if self.selected then
        Assets.colors.setWhite(.7)
        love.graphics.rectangle("fill", self.x, self.y, TILESIZE, TILESIZE, 4)
    end

    Assets.colors.reset()

    if self.shiny then
        self.particles:draw(
            self.x + TILESIZE / 2,
            self.y + TILESIZE / 2
        )
    end
end

function Tile:setHighlighted(highlight)
    self.highlighted = highlight
end

function Tile:setSelected(select)
    self.selected = select
end

function Tile:shine()
    if self.shiny then
        self.particles = ParticleManager()
    else
        self.particles = {}
    end
end

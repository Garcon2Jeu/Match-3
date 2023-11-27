PlayerManager = Class {}


local container = {
    x = -200,
    y = 16,
    width = 200,
    height = 100,
    cornerRadius = 4
}

function PlayerManager:init()
    self.score    = 0
    self.level    = 1
    self.goal     = 1250
    self.timer    = 1

    self.cursor   = {
        row = 1,
        column = 1
    }
    self.selected = nil


    Timer.every(1, function() self.timer = self.timer - 1 end)

    Timer.tween(.25, {
        [container] = { x = 16 }
    })
end

function PlayerManager:update(dt)
    self:moveCursor()
    self:selectTile()
end

function PlayerManager:draw(board)
    self:drawUI()
    self:drawCursor(board)
    self:drawSelected(board)
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

function PlayerManager:moveCursor()
    if App:wasKeyPressed("right") then
        self.cursor.column = self.cursor.column + 1 > 8 and 1 or self.cursor.column + 1
    elseif App:wasKeyPressed("left") then
        self.cursor.column = self.cursor.column - 1 < 1 and 8 or self.cursor.column - 1
    elseif App:wasKeyPressed("down") then
        self.cursor.row = self.cursor.row + 1 > 8 and 1 or self.cursor.row + 1
    elseif App:wasKeyPressed("up") then
        self.cursor.row = self.cursor.row - 1 < 1 and 8 or self.cursor.row - 1
    end
end

function PlayerManager:selectTile()
    if not App:wasKeyPressed("space") then
        return
    end

    if self:isSameTileSelected() then
        self:unselect()
        return
    end

    self.selected = {
        row = self.cursor.row,
        column = self.cursor.column
    }
end

function PlayerManager:isSameTileSelected()
    return self.selected
        and self.cursor.row == self.selected.row
        and self.cursor.column == self.selected.column
end

function PlayerManager:unselect()
    self.selected = nil
end

function PlayerManager:drawCursor(board)
    Assets.colors.setBlack()
    love.graphics.setLineWidth(3)
    love.graphics.rectangle("line",
        board.grid[self.cursor.row][self.cursor.column].x,
        board.grid[self.cursor.row][self.cursor.column].y,
        32, 32, 4)
    Assets.colors.reset()
end

function PlayerManager:drawSelected(board)
    if not self.selected then
        return
    end

    Assets.colors.setWhite(.5)
    love.graphics.rectangle("fill",
        board.grid[self.selected.row][self.selected.column].x,
        board.grid[self.selected.row][self.selected.column].y,
        32, 32, 4)
    Assets.colors.reset()
end

function PlayerManager:addToScore(matches)
    for key, match in pairs(matches) do
        self.score = self.score + #match * 50
    end
end

function PlayerManager:hasReachedTimeLimit()
    return self.timer <= 0
end

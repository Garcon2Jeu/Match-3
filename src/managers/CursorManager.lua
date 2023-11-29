CursorManager = Class()

function CursorManager:init()
    self.cursor = {
        row = 1,
        column = 1
    }

    self.selected = nil
end

function CursorManager:update(dt)
    self:moveCursor()
    self:selectTile()
end

function CursorManager:draw(board)
    self:drawCursor(board)
    self:drawSelected(board)
end

function CursorManager:moveCursor()
    if App:wasKeyPressed("right") then
        self.cursor.column = self.cursor.column + 1 > 8 and 1 or self.cursor.column + 1
        Assets.audio["select"]:play()
    elseif App:wasKeyPressed("left") then
        self.cursor.column = self.cursor.column - 1 < 1 and 8 or self.cursor.column - 1
        Assets.audio["select"]:play()
    elseif App:wasKeyPressed("down") then
        self.cursor.row = self.cursor.row + 1 > 8 and 1 or self.cursor.row + 1
        Assets.audio["select"]:play()
    elseif App:wasKeyPressed("up") then
        self.cursor.row = self.cursor.row - 1 < 1 and 8 or self.cursor.row - 1
        Assets.audio["select"]:play()
    end
end

function CursorManager:selectTile()
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

function CursorManager:isSameTileSelected()
    return self.selected
        and self.cursor.row == self.selected.row
        and self.cursor.column == self.selected.column
end

function CursorManager:unselect()
    self.selected = nil
end

function CursorManager:drawCursor(board)
    Assets.colors.setBlack()
    love.graphics.setLineWidth(3)
    love.graphics.rectangle("line",
        board.grid[self.cursor.row][self.cursor.column].x,
        board.grid[self.cursor.row][self.cursor.column].y,
        32, 32, 4)
    Assets.colors.reset()
end

function CursorManager:drawSelected(board)
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

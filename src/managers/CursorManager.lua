CursorManager = Class()


function CursorManager:init()
    self.selected = nil
    self.cursor   = { row = 1, column = 1 }
    self.mouse    = { x = 0, y = 0 }
end

function CursorManager:update(dt, grid)
    self:moveCursorWithMouse(grid)
    self:moveCursorWithKeys()
end

function CursorManager:draw(board)
    self:drawCursor(board)
    self:drawSelected(board)
end

function CursorManager:moveCursorWithMouse(grid)
    self.mouse.x, self.mouse.y = Push:toGame(love.mouse.getPosition())

    for key, row in pairs(grid) do
        for key, tile in pairs(row) do
            if self.mouse.x > tile.x and self.mouse.x < tile.x + TILESIZE
                and self.mouse.y > tile.y and self.mouse.y < tile.y + TILESIZE then
                self.cursor.row = tile.row
                self.cursor.column = tile.column
            end
        end
    end
end

function CursorManager:moveCursorWithKeys()
    if App:wasKeyPressed("right") then
        self.cursor.column = self.cursor.column + 1 > BOARDSIZE and 1 or self.cursor.column + 1
        Assets.audio["select"]:play()
    elseif App:wasKeyPressed("left") then
        self.cursor.column = self.cursor.column - 1 < 1 and BOARDSIZE or self.cursor.column - 1
        Assets.audio["select"]:play()
    elseif App:wasKeyPressed("down") then
        self.cursor.row = self.cursor.row + 1 > BOARDSIZE and 1 or self.cursor.row + 1
        Assets.audio["select"]:play()
    elseif App:wasKeyPressed("up") then
        self.cursor.row = self.cursor.row - 1 < 1 and BOARDSIZE or self.cursor.row - 1
        Assets.audio["select"]:play()
    end
end

function CursorManager:selectTile()
    self.selected = {
        row = self.cursor.row,
        column = self.cursor.column
    }
end

function CursorManager:isTileSelected()
    return self.selected
end

function CursorManager:isSameTileSelected()
    return self.selected
        and self.cursor.row == self.selected.row
        and self.cursor.column == self.selected.column
end

function CursorManager:unselectTile()
    self.selected = nil
end

function CursorManager:drawCursor(board)
    Assets.colors.setBlack()
    love.graphics.setLineWidth(3)
    love.graphics.rectangle("line",
        board.grid[self.cursor.row][self.cursor.column].x,
        board.grid[self.cursor.row][self.cursor.column].y,
        TILESIZE, TILESIZE, 4)
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
        TILESIZE, TILESIZE, 4)
    Assets.colors.reset()
end

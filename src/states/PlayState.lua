PlayState = Class { __includes = BaseState }

function PlayState:init()
    self.player = PlayerManager()

    self.highlighted = {
        row    = 1,
        column = 1
    }

    self.selected = {
        row    = 1,
        column = 1
    }
end

function PlayState:enter(params)
    self.board = params
end

function PlayState:update(dt)
    self:highlightTile()
    self:selectTile()
    self:swapTiles()
end

function PlayState:draw()
    BoardManager.draw(self.board)
    self.player:draw()
end

function PlayState:exit()
    self.player.timer:remove()
end

function PlayState:highlightTile()
    self.board[self.highlighted.row][self.highlighted.column]:setHighlighted(false)

    if App:wasKeyPressed("right") then
        self.highlighted.column = self.highlighted.column + 1 > 8 and 1 or self.highlighted.column + 1
    elseif App:wasKeyPressed("left") then
        self.highlighted.column = self.highlighted.column - 1 < 1 and 8 or self.highlighted.column - 1
    elseif App:wasKeyPressed("down") then
        self.highlighted.row = self.highlighted.row + 1 > 8 and 1 or self.highlighted.row + 1
    elseif App:wasKeyPressed("up") then
        self.highlighted.row = self.highlighted.row - 1 < 1 and 8 or self.highlighted.row - 1
    end

    self.board[self.highlighted.row][self.highlighted.column]:setHighlighted(true)
end

function PlayState:selectTile()
    if not App:wasKeyPressed("space") then
        return
    end

    if self.board[self.highlighted.row][self.highlighted.column].selected then
        self.board[self.highlighted.row][self.highlighted.column]:setSelected(false)
        self.selected = nil
        return
    end

    self.selected = { row = self.highlighted.row, column = self.highlighted.column }
    self.board[self.selected.row][self.selected.column]:setSelected(true)
end

function PlayState:swapTiles()
    if self.selected == nil
        or not App:wasKeyPressed("return")
        or not self:areTilesAdjacent(self.highlighted, self.selected) then
        return
    end

    local tile1 = self.highlighted
    local tile2 = self.selected


    -- update Highlight and reset Select
    self.selected = nil
    self.board[tile2.row][tile2.column]:setSelected(false)
    self.board[tile2.row][tile2.column]:setHighlighted(true)
    self.board[tile1.row][tile1.column]:setHighlighted(false)


    --Swap tile in board
    local tempTile = self.board[tile1.row][tile1.column]
    self.board[tile1.row][tile1.column] = self.board[tile2.row][tile2.column]
    self.board[tile2.row][tile2.column] = tempTile


    -- swap coordinates
    local tempCoord = {
        x = self.board[tile1.row][tile1.column].x,
        y = self.board[tile1.row][tile1.column].y
    }

    Timer.tween(.25, {
        [self.board[tile1.row][tile1.column]] = {
            x = self.board[tile2.row][tile2.column].x,
            y = self.board[tile2.row][tile2.column].y
        },
        [self.board[tile2.row][tile2.column]] = {
            x = tempCoord.x,
            y = tempCoord.y
        }
    })
end

function PlayState:areTilesAdjacent(tile1, tile2)
    return math.abs(tile2.row - tile1.row) + math.abs(tile2.column - tile1.column) == 1
end

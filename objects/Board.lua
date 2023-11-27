Board = Class {}

local boardSize = 8
local xOffset = CENTER_WIDTH - 16
local yOffset = 16

function Board:init()
    self.grid = self.factory(xOffset, yOffset)
end

function Board:draw(board)
    for key, row in pairs(board or self.grid) do
        for key, tile in pairs(row) do
            tile:draw()
        end
    end
end

function Board.factory(xOffset, yOffset)
    local board = {}

    for row = 1, boardSize do
        local gridRow = {}
        for column = 1, boardSize do
            table.insert(gridRow,
                Tile(
                    xOffset + 32 * (column - 1),
                    yOffset + 32 * (row - 1),
                    math.random(Atlas.getTotalColors()),
                    1,
                    row,
                    column
                ))
        end
        table.insert(board, gridRow)
    end

    if #Board:getAllMatches(board) > 0 then
        board = Board.factory(xOffset, yOffset)
    end

    return board
end

function Board:areTilesAdjacent(tile1, tile2)
    return math.abs(tile1.row - tile2.row) + math.abs(tile1.column - tile2.column) == 1
end

function Board:swapTiles(tile1, tile2)
    -- Swap Row/Column
    local tempRow, tempColumn =
        self.grid[tile1.row][tile1.column].row,
        self.grid[tile1.row][tile1.column].column
    self.grid[tile1.row][tile1.column].row,
    self.grid[tile1.row][tile1.column].column =
        self.grid[tile2.row][tile2.column].row,
        self.grid[tile2.row][tile2.column].column
    self.grid[tile2.row][tile2.column].row,
    self.grid[tile2.row][tile2.column].column =
        tempRow, tempColumn


    -- Swap Grid Position
    local tempTile = self.grid[tile1.row][tile1.column]
    self.grid[tile1.row][tile1.column] = self.grid[tile2.row][tile2.column]
    self.grid[tile2.row][tile2.column] = tempTile


    -- Swap XY
    local tempX, tempY =
        self.grid[tile1.row][tile1.column].x,
        self.grid[tile1.row][tile1.column].y

    local tweeningData = {
        [self.grid[tile1.row][tile1.column]] = {
            x = self.grid[tile2.row][tile2.column].x,
            y = self.grid[tile2.row][tile2.column].y,
        },
        [self.grid[tile2.row][tile2.column]] = {
            x = tempX,
            y = tempY,
        },
    }

    return tweeningData
end

function Board:getAllMatches(grid)
    local totalMatches = self:getMatchesBy("row", grid)

    for key, match in pairs(self:getMatchesBy("column", grid)) do
        table.insert(totalMatches, match)
    end

    return totalMatches
end

function Board:getMatchesBy(direction, grid)
    local totalMatches = {}

    grid = grid or self.grid

    for i = 1, 8 do
        local row = direction == "row" and i or 1
        local column = direction == "column" and i or 1

        local currentMatch = { grid[row][column] }

        for j = 2, 8 do
            row = direction == "row" and row or j
            column = direction == "column" and column or j

            if currentMatch[1].color == grid[row][column].color then
                table.insert(currentMatch, grid[row][column])
            else
                if #currentMatch >= 3 then
                    table.insert(totalMatches, currentMatch)
                end

                currentMatch = { grid[row][column] }
            end
        end

        if #currentMatch >= 3 then
            table.insert(totalMatches, currentMatch)
        end
    end

    return totalMatches
end

function Board:removeMatches(matches)
    for key, match in pairs(matches) do
        for key, tile in pairs(match) do
            self.grid[tile.row][tile.column] = nil
        end
    end
end

function Board:dropReplaceTiles(matches)
    local tweeningData = {}

    for key, match in pairs(matches) do
        for key, emptyTile in pairs(match) do
            local tilesToDrop = {}
            local row = emptyTile.row - 1

            while row >= 1 do
                if self.grid[row][emptyTile.column] then
                    table.insert(tilesToDrop, self.grid[row][emptyTile.column])
                end

                row = row - 1
            end

            row = emptyTile.row

            while row >= 1 do
                if #tilesToDrop > 0 then
                    self.grid[row][emptyTile.column] = tilesToDrop[1]
                    self.grid[row][emptyTile.column].row = row
                    table.remove(tilesToDrop, 1)
                else
                    self.grid[row][emptyTile.column] = emptyTile
                    self.grid[row][emptyTile.column].y = -AtlasManager.getTileSize()
                    self.grid[row][emptyTile.column].row = row
                    self.grid[row][emptyTile.column].color = math.random(Atlas.getTotalColors())
                end

                tweeningData[self.grid[row][emptyTile.column]] = {
                    y = AtlasManager.getTileSize() * (row - 1) + Board.getYoffset(),
                }

                row = row - 1
            end
        end
    end

    return tweeningData
end

function Board.getYoffset()
    return yOffset
end

-- function PlayState:getRowMatches()
--     local totalMatches = {}

--     for row = 1, 8 do
--         local currentMatch = { self.grid[row][1] }

--         for column = 2, 8 do
--             if currentMatch[1].color == self.grid[row][column].color then
--                 table.insert(currentMatch, self.grid[row][column])
--             else
--                 if #currentMatch >= 3 then
--                     table.insert(totalMatches, currentMatch)
--                 end

--                 currentMatch = { self.grid[row][column] }
--             end
--         end

--         if #currentMatch >= 3 then
--             table.insert(totalMatches, currentMatch)
--         end
--     end

--     return totalMatches
-- end

-- function PlayState:getColumnMatches()
--     local totalMatches = {}

--     for column = 1, 8 do
--         local currentMatch = { self.grid[1][column] }

--         for row = 2, 8 do
--             if currentMatch[1].color == self.grid[row][column].color then
--                 table.insert(currentMatch, self.grid[row][column])
--             else
--                 if #currentMatch >= 3 then
--                     table.insert(totalMatches, currentMatch)
--                 end

--                 currentMatch = { self.grid[row][column] }
--             end
--         end

--         if #currentMatch >= 3 then
--             table.insert(totalMatches, currentMatch)
--         end
--     end

--     return totalMatches
-- end

--INSTANTLY SWAP XY
-- self.grid[tile1.row][tile1.column].x,
-- self.grid[tile1.row][tile1.column].y =
--     self.grid[tile2.row][tile2.column].x,
--     self.grid[tile2.row][tile2.column].y
-- self.grid[tile2.row][tile2.column].x,
-- self.grid[tile2.row][tile2.column].y =
--     tempX, tempY

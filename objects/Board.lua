Board = Class {}

local boardSize = 8
local xOffset = CENTER_WIDTH - 16
local yOffset = 16

function Board:init(level)
    self.grid = self.factory(xOffset, yOffset, level)
end

function Board:update(dt)
    for key, row in pairs(self.grid) do
        for key, tile in pairs(row) do
            tile:update(dt)
        end
    end
end

function Board:draw(board)
    for key, row in pairs(board or self.grid) do
        for key, tile in pairs(row) do
            tile:draw()
        end
    end
end

function Board.factory(xOffset, yOffset, level)
    local board = {}

    local maxPattern = level or 1
    -- local color = math.random(Atlas.getTotalColors())
    -- color = color % 2 == 1 and color or color - 1

    for row = 1, boardSize do
        local gridRow = {}
        for column = 1, boardSize do
            table.insert(gridRow,
                Tile(
                    xOffset + 32 * (column - 1),
                    yOffset + 32 * (row - 1),
                    math.random(Atlas.getTotalColors()),
                    math.random(maxPattern),
                    row,
                    column,
                    math.random(32) == 1
                ))
        end
        table.insert(board, gridRow)
    end

    if #Match:getAllMatches(board) > 0 then
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
                    -- self.grid[row][emptyTile.column].shiny = math.random(32)
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

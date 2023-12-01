Board = Class {}


local xOffset = CENTER_WIDTH - 16
local yOffset = 16

local allowedColors = { 1, 3, 6, 8, 10, 12, 15 }


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
    local grid = {}

    local maxPattern = level
        and level <= 6 and level or 6
        or 1

    for row = 1, BOARDSIZE do
        local gridRow = {}
        for column = 1, BOARDSIZE do
            table.insert(gridRow,
                Tile(
                    xOffset + TILESIZE * (column - 1),
                    yOffset + TILESIZE * (row - 1),
                    Board.getRandomColor(),
                    math.random(maxPattern),
                    row,
                    column,
                    math.random(32) == 1 -- ???????????? Why 32?
                ))
        end
        table.insert(grid, gridRow)
    end

    if #Match:getAllMatches(grid) > 0
        or not Match.isMatchAvailable(grid) then
        grid = Board.factory(xOffset, yOffset, level)
    end

    return grid
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


    self.swapTilesGridPosition(tile1, tile2, self.grid)


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

function Board.swapTilesGridPosition(tile1, tile2, grid)
    local tempTile = grid[tile1.row][tile1.column]
    grid[tile1.row][tile1.column] = grid[tile2.row][tile2.column]
    grid[tile2.row][tile2.column] = tempTile
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
                    self.grid[row][emptyTile.column].y = -TILESIZE
                    self.grid[row][emptyTile.column].row = row
                    self.grid[row][emptyTile.column].color = Board.getRandomColor()
                    self.grid[row][emptyTile.column].shiny = math.random(32) == 1
                    self.grid[row][emptyTile.column]:shine()
                end

                tweeningData[self.grid[row][emptyTile.column]] = {
                    y = TILESIZE * (row - 1) + Board.getYoffset(),
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

function Board.getRandomColor()
    return allowedColors[math.random(#allowedColors)]
end

Board = Class {}

local boardSize = 8

function Board:init()
    self.grid = self.factory(CENTER_WIDTH - 16, 16)
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

    return board
end

function Board:update(dt)

end

BoardManager = Class {}

local boardSize = 8

function BoardManager:init()
    self.board = BoardManager.factory(CENTER_WIDTH - 16, 16)
end

function BoardManager:update(dt) end

function BoardManager.draw(board)
    for key, row in pairs(board) do
        for key, tile in pairs(row) do
            tile:draw()
        end
    end
end

function BoardManager.factory(x, y)
    local board = {}
    local tileSize = Atlas.getTileSize()

    for row = 0, boardSize - 1 do
        local tilesRow = {}

        for column = 0, boardSize - 1 do
            table.insert(tilesRow,
                Tile(
                    x + tileSize * column,
                    y + tileSize * row,
                    math.random(AtlasManager.getTotalColors() - 1),
                    1
                ))
        end

        table.insert(board, tilesRow)
    end

    return board
end

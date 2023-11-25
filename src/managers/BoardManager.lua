BoardManager = Class {}

local boardSize = 8
local tilesMatchMin = 3

function BoardManager:init()
    self.board = BoardManager.factory(CENTER_WIDTH - 16, 16)
end

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

function BoardManager.searchAllMatches(board)
    local totalMatches = BoardManager.searchBy(board, "row")

    for key, match in pairs(BoardManager.searchBy(board, "column")) do
        table.insert(totalMatches, match)
    end

    return totalMatches
end

function BoardManager.searchBy(board, direction)
    local totalMatches = {}

    for i = 1, boardSize do
        local currentMatch = { {
            row = direction == "row" and 1 or i,
            column = direction == "column" and 1 or i
        } }

        for j = 2, boardSize do
            local row = direction == "row" and i or j
            local column = direction == "column" and i or j

            if board[currentMatch[1].row][currentMatch[1].column].color == board[row][column].color then
                table.insert(currentMatch, { row = row, column = column })
                goto continue
            end

            if j > 6 then
                break
            end

            if #currentMatch >= 3 then
                table.insert(totalMatches, currentMatch)
            end


            currentMatch = { { row = row, column = column } }

            ::continue::
        end

        if #currentMatch >= 3 then
            table.insert(totalMatches, currentMatch)
        end
    end


    return totalMatches
end

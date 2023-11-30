AtlasManager = Class {}

local rows = 9
local columns = 12
local totalColors = rows * 2


function AtlasManager:init()
    self.quads = AtlasManager.getTilesQuads()
end

function AtlasManager.getTilesQuads()
    local board = {}

    for h = 0, 1 do
        local xOffset = TILESIZE * (columns / 2) * h

        for i = 0, rows - 1 do
            local color = {}
            local y = TILESIZE * i

            for j = 0, columns / 2 - 1 do
                local x = TILESIZE * j + xOffset

                table.insert(color,
                    love.graphics.newQuad(x, y, TILESIZE, TILESIZE,
                        Assets.graphics["match3"]:getDimensions()))
            end

            table.insert(board, color)
        end
    end


    return board
end

function AtlasManager.getTotalColors()
    return totalColors
end

return AtlasManager()

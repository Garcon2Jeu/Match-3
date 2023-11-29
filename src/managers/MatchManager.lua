MatchManager = Class {}

function MatchManager:getAllMatches(grid)
    local totalMatches = self.getMatchesBy(grid, "row")

    for key, match in pairs(self.getMatchesBy(grid, "column")) do
        table.insert(totalMatches, match)
    end

    totalMatches = self.getShinyMatches(grid, totalMatches)

    return totalMatches
end

function MatchManager.getMatchesBy(grid, direction)
    local totalMatches = {}

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

function MatchManager.getShinyMatches(grid, matches)
    for index, match in ipairs(matches) do
        for key, tile in pairs(match) do
            if tile.shiny then
                local shinyMatch = {}

                for column = 1, #grid do
                    table.insert(shinyMatch, grid[tile.row][column])
                end

                table.remove(matches, index)
                table.insert(matches, shinyMatch)
                goto continue
            end
        end
        ::continue::
    end

    return matches
end

function MatchManager.removeMatches(grid, matches)
    for key, match in pairs(matches) do
        for key, tile in pairs(match) do
            grid[tile.row][tile.column] = nil
        end
    end

    return grid
end

return MatchManager

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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

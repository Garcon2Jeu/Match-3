PlayState = Class { __includes = BaseState }

function PlayState:init()
    ------------------------------------------------------DEBUG-------------------------------------------------------------------
    self.board = Board()
    ------------------------------------------------------DEBUG-------------------------------------------------------------------
    self.player = PlayerManager()
end

function PlayState:enter(params)
    ------------------------------------------------------DEBUG-------------------------------------------------------------------
    -- self.board = params
    ------------------------------------------------------DEBUG-------------------------------------------------------------------
end

function PlayState:update(dt)
    self.player:update(dt)

    if App:wasKeyPressed("return") and self:isSwapPossible() then
        self.board:swapTiles(
            self.player.selected,
            self.player.cursor
        )
        self.player:unselect()
        local matches = self.board:getAllMatches()
        self.board:removeMatches(matches)
    end
end

function PlayState:draw()
    self.board:draw()
    self.player:draw(self.board)

    ------------------------------------------------------DEBUG-------------------------------------------------------------------
    -- love.graphics.print(tostring(#self.board:getMatchesBy("row")), 50, 50)
    -- love.graphics.print(tostring(#self.board:getMatchesBy("column")), 50, 70)
    -- love.graphics.print(tostring(#self.board:getAllMatches()), 50, 90)

    -- if #self.board:getAllMatches() > 0 then
    --     love.graphics.print(tostring(self.board:getAllMatches()[1][1].row), 50, 50)
    --     love.graphics.print(tostring(self.board:getAllMatches()[1][1].column), 50, 70)
    --     love.graphics.print(tostring(self.board:getAllMatches()[1][2].row), 50, 90)
    --     love.graphics.print(tostring(self.board:getAllMatches()[1][2].column), 50, 110)
    --     love.graphics.print(tostring(self.board:getAllMatches()[1][3].row), 50, 130)
    --     love.graphics.print(tostring(self.board:getAllMatches()[1][3].column), 50, 150)
    -- end
    ------------------------------------------------------DEBUG-------------------------------------------------------------------
end

function PlayState:exit()

end

function PlayState:isSwapPossible()
    return
        self.player.selected
        and not self.player:isSameTileSelected()
    -- and self.board:areTilesAdjacent(
    --     self.player.selected,
    --     self.player.cursor
    -- )
end

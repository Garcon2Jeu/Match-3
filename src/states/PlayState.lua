PlayState = Class { __includes = BaseState }

function PlayState:init()
    ------------------------------------------------------DEBUG-------------------------------------------------------------------
    -- self.board = Board()
    ------------------------------------------------------DEBUG-------------------------------------------------------------------
    self.player = PlayerManager()
end

function PlayState:enter(params)
    ------------------------------------------------------DEBUG-------------------------------------------------------------------
    self.board = params
    ------------------------------------------------------DEBUG-------------------------------------------------------------------
end

function PlayState:update(dt)
    self.player:update(dt)

    if App:wasKeyPressed("return") and self:isSwapPossible() then
        Chain(
            self:SwapTiles(),
            self:RemoveDropReplaceTiles()
        )()
    end

    if self.player:hasReachedTimeLimit() then
        State:change("over", self.player.score)
    end
end

function PlayState:draw()
    self.board:draw()
    self.player:draw(self.board)
end

function PlayState:exit()
    -- self.player.countDown:remove()
end

function PlayState:isSwapPossible()
    return
        self.player.selected
        and not self.player:isSameTileSelected()
        and self.board:areTilesAdjacent(
            self.player.selected,
            self.player.cursor
        )
end

function PlayState:SwapTiles()
    return function(next)
        local tweeningData = self.board:swapTiles(
            self.player.selected,
            self.player.cursor
        )
        self.player:unselect()

        Timer.tween(.25, tweeningData):finish(next)
    end
end

function PlayState:RemoveDropReplaceTiles()
    return function()
        local matches = self.board:getAllMatches()

        if #matches < 1 then
            return
        end

        self.player:addToScore(matches)
        self.board:removeMatches(matches)
        local tweeningData = self.board:dropReplaceTiles(matches)

        Timer.tween(.25, tweeningData):finish(self:RemoveDropReplaceTiles())
    end
end

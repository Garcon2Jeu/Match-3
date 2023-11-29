PlayState = Class { __includes = BaseState }


function PlayState:enter(params)
    self.board = params.board
    self.player = params.player
    self.player:slideContainer()
    self.player:startCountdown()
end

function PlayState:update(dt)
    self.player:update(dt)

    if self.player:hasReachedGoal() then
        Assets.audio["next-level"]:play()
        self.player:levelUp()
        Chain(
            State:fade(1),
            State:chainChange("newGame", self.player)
        )()
    end

    if self.player:hasReachedTimeLimit() then
        Assets.audio["game-over"]:play()

        Chain(
            State:fade(1),
            State:chainChange("over", self.player.score)
        )()
    end

    if not App:wasKeyPressed("return") then
        return
    end

    if self:isSwapPossible() then
        Chain(
            self:SwapTiles(),
            self:RemoveDropReplaceTiles()
        )()
    else
        Assets.audio["error"]:play()
    end
end

function PlayState:draw()
    self.board:draw()
    self.player:draw(self.board)
end

function PlayState:exit()
    self.player.countdown:remove()
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

        Assets.audio["match"]:play()
        self.player:addToScore(matches)
        self.player:addBonusTime(matches)
        self.board:removeMatches(matches)
        local tweeningData = self.board:dropReplaceTiles(matches)

        Timer.tween(.25, tweeningData):finish(self:RemoveDropReplaceTiles())
    end
end

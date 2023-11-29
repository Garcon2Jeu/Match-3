PlayState = Class { __includes = BaseState }


local swapTime = .25
local dropTime = .25


function PlayState:init(params)
    self.cursor = CursorManager()
end

function PlayState:enter(params)
    self.board = params.board
    self.player = params.player

    self.player:slideContainer()
    self.player:startCountdown()
end

function PlayState:update(dt)
    self.cursor:update(dt)
    self.board:update(dt)

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
    self.player:draw()
    self.cursor:draw(self.board)
end

function PlayState:exit()
    self.player:removeCountDown()
    self.player:resetTimer()
end

function PlayState:isSwapPossible()
    return
        self.cursor.selected
        and not self.cursor:isSameTileSelected()
        and self.board:areTilesAdjacent(
            self.cursor.selected,
            self.cursor.cursor
        )
end

function PlayState:SwapTiles()
    return function(next)
        App:enableInput(false)

        local tweeningData = self.board:swapTiles(
            self.cursor.selected,
            self.cursor.cursor
        )
        self.cursor:unselect()

        Timer.tween(swapTime, tweeningData):finish(next)
    end
end

function PlayState:RemoveDropReplaceTiles()
    return function()
        local matches = Match:getAllMatches(self.board.grid)

        if #matches < 1 then
            App:enableInput(true)
            return
        end

        Assets.audio["match"]:play()
        self.player:addToScore(matches)
        self.player:addBonusTime(matches)
        self.board.grid = Match.removeMatches(self.board.grid, matches)
        local tweeningData = self.board:dropReplaceTiles(matches)

        Timer.tween(dropTime, tweeningData):finish(self:RemoveDropReplaceTiles())
    end
end

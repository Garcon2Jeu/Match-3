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
        Chain(
            function(next)
                self.board:swapTiles(
                    self.player.selected,
                    self.player.cursor,
                    next
                )
                self.player:unselect()
            end,
            self.board:RemoveDropReplace()
        )()
    end
end

function PlayState:draw()
    self.board:draw()
    self.player:draw(self.board)
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

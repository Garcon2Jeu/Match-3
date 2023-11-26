PlayState = Class { __includes = BaseState }

function PlayState:init()
    ------------------------------------------------------DEBUG-------------------------------------------------------------------
    self.board = Board()
    ------------------------------------------------------DEBUG-------------------------------------------------------------------
    self.player = PlayerManager()
end

function PlayState:enter(params)
    -- self.board = params
end

function PlayState:update(dt)

end

function PlayState:draw()
    self.board:draw()
    self.player:draw()
end

function PlayState:exit()

end

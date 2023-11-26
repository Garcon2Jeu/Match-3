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
end

function PlayState:draw()
    self.board:draw()
    self.player:draw(self.board)
end

function PlayState:exit()

end

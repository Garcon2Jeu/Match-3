PlayState = Class { __includes = BaseState }

function PlayState:init()
    self.player = PlayerManager()
end

function PlayState:update(dt)
    -- self.player:update(dt)
end

function PlayState:draw()
    BoardManager.draw(self.board)
    self.player:draw()
end

function PlayState:enter(params)
    self.board = params
end

function PlayState:exit() end

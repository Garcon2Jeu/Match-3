PlayState = Class { __includes = BaseState }

function PlayState:init()
    self.board = BoardManager.factory(CENTER_WIDTH - 16, 16)
end

function PlayState:update(dt) end

function PlayState:draw()
    BoardManager.draw(self.board)
end

function PlayState:enter(params) end

function PlayState:exit() end

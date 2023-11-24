StartState = Class { __includes = BaseState }

local highlighted = true

local MIndex = 1
local AIndex = 2
local TIndex = 3
local CIndex = 4
local HIndex = 5
local ThreeIndex = 6

function StartState:init()
    self.pallette        = Assets:getPallette()
    self.colorTimer      = self:createColorTimer()
    self.alphaTransition = 0
    self.board           = BoardManager.factory(CENTER_WIDTH - 128, 16)
end

function StartState:update(dt)
    Timer.update(dt)

    if App:wasKeyPressed("up") or App:wasKeyPressed("down") then
        highlighted = not highlighted
    end

    if not App:wasKeyPressed("return") then
        return
    end

    if highlighted then
        Chain(
            function(next)
                Timer.tween(.25, {
                    [self] = { alphaTransition = 1 }
                }):finish(next)
            end,
            function()
                State:change("newGame")
            end
        )()

        self.colorTimer:remove()
    else
        love.event.quit()
    end
end

function StartState:draw()
    BoardManager.draw(self.board)

    self:drawTitleCard()
    self.drawMenuCard()

    love.graphics.setColor(1, 1, 1, self.alphaTransition)
    love.graphics.rectangle("fill", 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    Assets.colors.reset()
end

function StartState:createColorTimer()
    return Timer.every(.08,
        function()
            self.pallette[0] = self.pallette[6]

            for i = 6, 1, -1 do
                self.pallette[i] = self.pallette[i - 1]
            end
        end
    )
end

function StartState:drawTitleCard()
    -- Container
    Assets.colors.setWhite(.5)
    love.graphics.rectangle("fill", CENTER_WIDTH - 150, CENTER_HEIGHT - 80, 300, 60, 4)

    Assets.fonts.setHuge()

    -- Text Drop Shadow
    Assets.colors.setBlack()
    love.graphics.printf("MATCH 3", 0, CENTER_HEIGHT - 78, VIRTUAL_WIDTH + 2, "center")


    local pallette = AssetsManager.getPallette()

    -- Text
    self:drawTitleLetter("M", -215, MIndex)
    self:drawTitleLetter("A", -128, AIndex)
    self:drawTitleLetter("T", -55, TIndex)
    self:drawTitleLetter("C", 8, CIndex)
    self:drawTitleLetter("H", 80, HIndex)
    self:drawTitleLetter("3", 225, ThreeIndex)

    Assets.colors.reset()
end

function StartState:drawTitleLetter(letter, xOffset, colorIndex)
    love.graphics.setColor(
        self.pallette[colorIndex][1],
        self.pallette[colorIndex][2],
        self.pallette[colorIndex][3],
        self.pallette[colorIndex][4]
    )

    love.graphics.printf(letter, 0, CENTER_HEIGHT - 80, VIRTUAL_WIDTH + xOffset, "center")
end

function StartState.drawMenuCard()
    -- Container
    Assets.colors.setWhite(.5)
    love.graphics.rectangle("fill", CENTER_WIDTH - 75, CENTER_HEIGHT + 20, 150, 80, 4)


    Assets.fonts.setLarge()

    -- Text Drop Shadow
    Assets.colors.setBlack()
    love.graphics.printf("Start", 0, CENTER_HEIGHT + 27, VIRTUAL_WIDTH + 2, "center")
    love.graphics.printf("Exit", 0, CENTER_HEIGHT + 67, VIRTUAL_WIDTH + 2, "center")


    -- Text
    Assets.colors.setDarkBlue()

    if highlighted then
        Assets.colors.setBlue()
    else
        Assets.colors.setDarkBlue()
    end

    love.graphics.printf("Start", 0, CENTER_HEIGHT + 25, VIRTUAL_WIDTH, "center")

    if not highlighted then
        Assets.colors.setBlue()
    else
        Assets.colors.setDarkBlue()
    end

    love.graphics.printf("Exit", 0, CENTER_HEIGHT + 65, VIRTUAL_WIDTH, "center")
    Assets.colors.reset()
end

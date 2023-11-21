StartState = Class { __includes = BaseState }

local highlighted = true

function StartState:update(dt)
    if App:wasKeyPressed("up") or App:wasKeyPressed("down") then
        highlighted = not highlighted
    end

    if not App:wasKeyPressed("return") then
        return
    end

    if highlighted then
        State:change("start")
    else
        love.event.quit()
    end
end

function StartState:draw()
    self.drawTitleCard()
    self.drawMenuCard()
end

function StartState.drawTitleCard()
    -- Container
    Assets.colors.setWhiteTransparent()
    love.graphics.rectangle("fill", CENTER_WIDTH - 150, CENTER_HEIGHT - 80, 300, 60, 4)
    Assets.colors.reset()

    Assets.fonts.setHuge()

    -- Text Drop Shadow
    Assets.colors.setBlack()
    love.graphics.printf("Match 3", 0, CENTER_HEIGHT - 78, VIRTUAL_WIDTH + 2, "center")
    Assets.colors.reset()

    -- Text
    love.graphics.printf("Match 3", 0, CENTER_HEIGHT - 80, VIRTUAL_WIDTH, "center")
end

function StartState.drawMenuCard()
    -- Container
    Assets.colors.setWhiteTransparent()
    love.graphics.rectangle("fill", CENTER_WIDTH - 75, CENTER_HEIGHT + 20, 150, 80, 4)
    Assets.colors.reset()

    Assets.fonts.setLarge()

    -- Text Drop Shadow
    Assets.colors.setBlack()
    love.graphics.printf("Start", 0, CENTER_HEIGHT + 27, VIRTUAL_WIDTH + 2, "center")
    love.graphics.printf("Exit", 0, CENTER_HEIGHT + 67, VIRTUAL_WIDTH + 2, "center")
    Assets.colors.reset()

    -- Text
    Assets.colors.setDarkBlue()

    if highlighted then
        Assets.colors.setBlue()
    end

    love.graphics.printf("Start", 0, CENTER_HEIGHT + 25, VIRTUAL_WIDTH, "center")
    Assets.colors.setDarkBlue()

    if not highlighted then
        Assets.colors.setBlue()
    end

    love.graphics.printf("Exit", 0, CENTER_HEIGHT + 65, VIRTUAL_WIDTH, "center")
    Assets.colors.setDarkBlue()
end

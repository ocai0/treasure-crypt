local LEFT_BUTTON = 1
local FONT_SIZE = 8

local saveBtn = {
    x = 48,
    y = 155,
    width = nil,
    height = 16,
    text=  "criptografar e salvar",
    padding = 3,
    boxColor = {.35, .43, .88, 1}
}

function saveBtn:checkClick(x, y)
    return 
        x > saveBtn.x and x < saveBtn.x + saveBtn.width and
        y > saveBtn.y and y < saveBtn.y + saveBtn.height
end

function saveBtn:update(dt)
    if(saveBtn.hasScheduleToReset) then
        saveBtn.timeToReset = saveBtn.timeToReset - 1 * dt
        print(saveBtn.timeToReset)
        if(saveBtn.timeToReset <= 0) then
            saveBtn:reset()
            saveBtn.hasScheduleToReset = false
        end
    end
end

function saveBtn:load()
    saveBtn.width = (#saveBtn.text - 1) * FONT_SIZE
end
function saveBtn:mousepressed(x, y, button, istouch, press)
    if(button == LEFT_BUTTON) then
        if(saveBtn:checkClick(x, y)) then
            saveBtn.clicked = true
            saveBtn.text = "salvo"
            saveBtn.width = ((#saveBtn.text) * FONT_SIZE) + saveBtn.padding * 2
        end
    end
end

function saveBtn:wasClicked()
    return saveBtn.clicked
end
function saveBtn:scheduleReset(time)
    saveBtn.hasScheduleToReset = true
    saveBtn.timeToReset = time
end
function saveBtn:reset()
    saveBtn.clicked = false
    saveBtn.text = "criptografar e salvar"
    saveBtn.width = ((#saveBtn.text - 1) * FONT_SIZE)
end

function saveBtn:draw()
    love.graphics.setColor(saveBtn.boxColor[1], saveBtn.boxColor[2], saveBtn.boxColor[3], saveBtn.boxColor[4])
    love.graphics.rectangle('fill', saveBtn.x, saveBtn.y, saveBtn.width, saveBtn.height)
    love.graphics.setColor(1, 1, 1, 1) -- reset colors
    love.graphics.print(saveBtn.text, saveBtn.x + saveBtn.padding, saveBtn.y + saveBtn.padding)
end

return saveBtn
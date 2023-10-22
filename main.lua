require "env"

-- helpers
AES = require './lib/lua-aes/AES'
Anim8 = require './lib/anim8/anim8'
Maid64 = require './lib/maid64/maid64'

local PROMPT = 'escreva algo'
local FONT_SIZE = 8
local TEXT_PADDING = 2
local MAX_TEXT_SIZE = 178

-- entities
saveBtn = require './classes/save-button'
CriptoHandler = require 'classes/criptoHandler'

function love.load()
    -- configure window
    love.window.setMode( 640, 480, { borderless = false} )
    Maid64.setup(320, 240)

    -- set global variables
    superMarioFont = love.graphics.newFont("assets/smb3-font.ttf", FONT_SIZE)
    superMarioFontSmall = love.graphics.newFont("assets/smb3-font.ttf", FONT_SIZE - 3)
    background = love.graphics.newImage('assets/bg.png')
    textBox = love.graphics.newImage('assets/text-box.png')
    textWritten = ""

    -- init
    love.graphics.setFont(superMarioFont)
    love.graphics.setDefaultFilter('nearest', 'nearest', 0)
    saveBtn:load()
end

function love.update(dt)
    if(saveBtn:wasClicked()) then
        saveBtn.clicked = false
        CriptoHandler:encrypt(textWritten)
        saveBtn:scheduleReset(1)
    end
    saveBtn:update(dt)
end

function love.draw()
    Maid64.start()
        love.graphics.draw(background, 0, 0)
        love.graphics.draw(textBox, 48, 72)
        love.graphics.print(PROMPT, 54, 76)
        love.graphics.printf(textWritten, 54, 76 + TEXT_PADDING + FONT_SIZE, 208)
        love.graphics.setColor(0, 1, 1, 1)
        saveBtn:draw()     
        -- draw save button
    Maid64.finish()
    
end

------------------------------------------------------
function love.mousepressed(x, y, button, istouch, press)
    x = Maid64.mouse.getX()
    y = Maid64.mouse.getY()
    saveBtn:mousepressed(x, y, button, istouch, press)
end

function love.textinput(text)
    if (#textWritten < MAX_TEXT_SIZE) then textWritten = textWritten .. text end
end

function love.keypressed(key, scancode, isrepeat)
    if(scancode == "backspace") then
        textWritten = textWritten:sub(1, -2)
    end
end

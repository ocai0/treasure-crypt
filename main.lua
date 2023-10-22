require "env"

-- helpers
AES = require './lib/lua-aes/AES'
Gamestate = require './lib/hump/gamestate'
Anim8 = require './lib/anim8/anim8'
Maid64 = require './lib/maid64/maid64'

local PROMPT = 'escreva algo'
local FONT_SIZE = 8
local TEXT_PADDING = 2
local MAX_TEXT_SIZE = 178

function love.load()
    -- configure window
    love.window.setMode( 640, 480, { borderless = false} )
    Maid64.setup(320, 240)

    -- set global variables
    superMarioFont = love.graphics.newFont("assets/smb3-font.ttf", FONT_SIZE)
    superMarioFontSmall = love.graphics.newFont("assets/smb3-font.ttf", FONT_SIZE - 3)
    background = love.graphics.newImage('assets/bg.png')
    textBox = love.graphics.newImage('assets/text-box.png')
    scenes = {
        loading = require './scenes/loading_screen'
    }
    textWritten = ""

    -- init
    love.graphics.setFont(superMarioFont)
    love.graphics.setDefaultFilter('nearest', 'nearest', 0)
    Gamestate.registerEvents()
    Gamestate.switch(scenes.loading)
    
end
function love.update(dt)
end
function love.textinput(text)
    if (#textWritten < MAX_TEXT_SIZE) then textWritten = textWritten .. text end
end
function love.keypressed(key, scancode, isrepeat)
    if(scancode == "backspace") then
        textWritten = textWritten:sub(1, -2)
    end
end
function love.draw()
    Maid64.start()
        love.graphics.draw(background, 0, 0)
        love.graphics.draw(textBox, 48, 72)
        love.graphics.print(PROMPT, 54, 76)
        love.graphics.printf(textWritten, 54, 76 + TEXT_PADDING + FONT_SIZE, 208)
        love.graphics.setColor(0, 1, 1, 1)
        
        -- draw save button
        love.graphics.setColor(.35, .43, .88, 1)
        love.graphics.rectangle('fill', 10, 10, 200, 48)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf("clique para salvar", superMarioFontSmall, 12, 12, 200)
    Maid64.finish()
    
end
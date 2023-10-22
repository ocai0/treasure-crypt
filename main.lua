require "env"
AES = require './lib/lua-aes/AES'

local plaintext = 'my secret, with extra length so that it is waaaaaaaaay over 16 bytes.'
local cyphertext = AES.ECB_256(AES.encrypt, ENV.KEY, plaintext)
local newtext = AES.ECB_256(AES.decrypt, ENV.KEY, cyphertext)

function love.load()
    data = 'original: ' .. plaintext .. '\ncipher: ' .. cyphertext
    file = io.open("test.txt", "w")
    file:write(cyphertext)
    file:close()

end
function love.update(dt)
end
function love.draw()
    -- love.graphics.print(plaintext, 0, 20)
    -- love.graphics.print(cyphertext, 0, 40)
    -- love.graphics.print(newtext, 0, 60)
end
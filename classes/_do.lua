local _do = {}
function _do:encrypt(text)
    local cyphertext = AES.ECB_256(AES.encrypt, ENV.KEY, plaintext)
    local newtext = AES.ECB_256(AES.decrypt, ENV.KEY, cyphertext)
end
function _do:saveToFile(filename)
    data = 'original: ' .. plaintext .. '\ncipher: ' .. cyphertext
    file = io.open(filename .. ".txt", "w")
    file:write(cyphertext)
    file:close()
end
return _do
local criptoHandler = {}
function criptoHandler:encrypt(text)
    local cyphertext = AES.ECB_256(AES.encrypt, ENV.KEY, text)
    local newtext = AES.ECB_256(AES.decrypt, ENV.KEY, cyphertext)

    criptoHandler:saveToFile(cyphertext, "output")
end
function criptoHandler:saveToFile(text, filename)
    file = io.open(filename, "w")
    file:write(text)
    file:close()
end
return criptoHandler
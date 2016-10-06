-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
-- display.setDefault( "anchorX", 0.5 )
-- display.setDefault( "anchorY", 0.5 )
crypto = require("crypto")
require("noobhub")
local packet={}
local nickname="Player"
log = native.newTextBox( display.contentCenterX, 150, display.contentWidth-10, 350)
chat = native.newTextField( display.contentCenterX, 400, 300, 25 )
sendbutton = display.newImage ("send.png",chat.x+100, chat.y+32)
reconnectbutton = display.newImage ("reconnect.png",32+5, chat.y+32)
clearbutton = display.newImage ("clear.png",reconnectbutton.x+32+16+5, chat.y+32)
--log.anchorX = 0.5
--og.anchorY = 0.5
--log.x= display.contentCenterX
--log.y=display.ContentCenterY
function reader(message)
log.text = log.text.."\n"..message.action[1]..": "..message.action[2]
end
function sender()
packet[1]=nickname
packet[2]=chat.text
   hub:publish({
            message = {
                action  =  packet,
                timestamp = system.getTimer()
            }
        });
        chat.text = ""
end
sendbutton:addEventListener("tap", sender)
function clear()
log.text=""
end
clearbutton:addEventListener("tap", clear)
function connect ()
hub = nil
hub = noobhub.new({ server = "46.4.76.236"; port = 1337; });
    hub:subscribe({
          channel = "chat";
            callback = reader
        });
   log.text = log.text.."\n".."Connected"     
end
reconnectbutton:addEventListener("tap", connect)
        connect()
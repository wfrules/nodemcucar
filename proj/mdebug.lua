mDebug = {}
mDebug.led = 4
function mDebug.turnLight(sig)
    if sig == true then
        flag = 0   require("mdebug")
require("mwifi")
require("mbutton")
gpio.mode(mDebug.led, gpio.OUTPUT)
mWifi.hold()
--mButton.watch()
print('over')

    else
        flag = 1 
    end      
    gpio.write(mDebug.led,flag)
    tmr.delay(1000 * 1000)
end

function mDebug.transFlag(flag)
    if flag == 0 then
        return true
    else 
        return false  
    end      
end

function mDebug.blink()
    mDebug.turnLight(true)
    mDebug.turnLight(false)
end

return mDebug

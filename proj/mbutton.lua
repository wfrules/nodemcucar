require("mdebug")
require("mwifi")
mButton = {}
mButton.gpio = 3
function mButton.watch()
    gpio.mode(mButton.gpio, gpio.INPUT)
    bLoop = true
    while(bLoop)
    do
        tmr.wdclr()
        flag = gpio.read(mButton.gpio)
        if flag == 0 then
            tmr.delay(1000 * 1000)
            mDebug.blink()
            mWifi.conn()
            bLoop = false
        end    
    end    
end

return mButton

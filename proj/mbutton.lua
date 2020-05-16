require("mdebug")
mButton = {}
mButton.gpio = 3
function mButton.watch()
    gpio.mode(mButton.gpio, gpio.INPUT)
    while(true)
    do
        tmr.wdclr()
        flag = gpio.read(mButton.gpio)
        bOn = mDebug.transFlag(flag)
        mDebug.turnLight(bOn)
        
    end    
end

return mButton

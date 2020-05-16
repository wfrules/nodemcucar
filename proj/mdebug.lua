mDebug = {}
mDebug.led = 4

function mDebug.turnLight(sig)
    gpio.mode(mDebug.led, gpio.OUTPUT)
    if sig == true then
        flag = 0   
    else
        flag = 1 
    end      
    gpio.write(mDebug.led,flag)
    tmr.delay(1000 * 1000)
end

return mDebug
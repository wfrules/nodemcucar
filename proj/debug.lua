modDebug = {}
modDebug.led = 4

function modDebug.turnLight(sig)
    gpio.mode(led,gpio.OUTPUT)
    if sig == true then
        flag = 0   
    else
        flag = 1 
    end      
    gpio.write(led,flag)
    tmr.delay(1000 * 1000)
end

return modDebug
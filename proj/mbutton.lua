require("mdebug")
require("mwifi")
mButton = {}
mButton.gpio = 3
function mButton.watch()
    gpio.mode(mButton.gpio, gpio.INPUT)
    bLoop = true
    iFail = 0
    print('begin watch')
    while(bLoop)
    do
        tmr.wdclr()
        flag = gpio.read(mButton.gpio)
        if flag == 0 then
            tmr.delay(1000 * 1000)
            mDebug.blink()
            bSuccess = mWifi.conn()
            if bSuccess then
                bLoop = false
            else
                iFail = iFail + 1
                if iFail >= 3 then
                    bLoop = false
                end    
            end    
        end    
    end    
end

return mButton

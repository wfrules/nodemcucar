require("mdebug")
require("mtcp")
mWifi = {}
mWifi.ip = ''
function mWifi.reg()
    wifi.sta.eventMonReg(wifi.STA_WRONGPWD, function()
        status = 'STA_WRONGPWD'
        print(status)
    end)
    
    wifi.sta.eventMonReg(wifi.STA_APNOTFOUND, function()
        status = 'STA_APNOTFOUND'
        print(status)
    end)
    
    wifi.sta.eventMonReg(wifi.STA_CONNECTING, function(previous_State)
        status = 'STA_CONNECTING'
        print(status)
    end)
    
    wifi.sta.eventMonReg(wifi.STA_GOTIP, function()
        status = 'STA_GOTIP'
        print(status, wifi.sta.getip())
    end)
    wifi.sta.autoconnect(1)
end
    
function mWifi.conn()
    wifi.setmode(wifi.STATION)
    wifi.sta.config("Wfhome","15980936465")
    wifi.sta.connect()
    mWifi.ip=wifi.sta.getip()    
    if mWifi.ip  ~= nil then
        mDebug.turnLight(true)
        print("\nIP Info:\nIP Address: "..mWifi.ip .."")
        return true
    else
        print('wifi fail')
        return false   
    end     
end

function mWifi.hold()
    bLoop = true
    bRet = false
    iFail = 0
    while(bLoop)
    do
        tmr.wdclr()
        mDebug.blink()
        print('connecting...'..iFail)
        bSuccess = mWifi.conn()
        if bSuccess then
            bRet = true
            bLoop = false
        else            
            iFail = iFail + 1
            if iFail >= 10 then
                bRet = false
                bLoop = false
            end    
        end    
     end  
     return bRet             
end

return mWifi

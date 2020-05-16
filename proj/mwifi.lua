mWifi = {}
mWifi.ip = ''
function mWifi.conn()
    wifi.setmode(wifi.STATION)
    wifi.sta.config("Wfhome","15980936465") -- Replace these two args with your own network
    mWifi.ip=wifi.sta.getip()    
    if mWifi.ip  ~= nil then
        print("\nIP Info:\nIP Address: "..mWifi.ip .."")
    else
        print('wifi fail')   
    end     
end

return mWifi
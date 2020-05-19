mWifi = {}
function mWifi.conn()
    wifi.setmode(wifi.STATION)
    wifi.sta.config("Wfhome","15980936465")
    wifi.sta.autoconnect(1)
end
return mWifi

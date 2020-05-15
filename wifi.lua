function setTcpServer()
    srv=net.createServer(net.TCP)
    srv:listen(80,function(conn)
      conn:on("receive",function(conn,payload)
        print(payload)
--        conn:send("<h1> Hello, NodeMCU!!! </h1>")
--        turnLight()
      end)
      conn:on("sent",function(conn) conn:close() end)
    end)
end    

function setwifi()
    wifi.setmode(wifi.STATION)
    wifi.sta.config("Wfhome","15980936465") -- Replace these two args with your own network
    ip, nm, gw=wifi.sta.getip()
    print("\nIP Info:\nIP Address: "..ip.."")
end

function turnLight()
    ledswitch=0
    pin=1
    gpio.mode(pin,gpio.OUTPUT)
    tmr.alarm(0,500,1,function()
        if ledswitch==0 then 
            ledswitch=1 --led on
            gpio.write(pin,gpio.LOW)
        else 
            ledswitch=0 --led off
            gpio.write(pin,gpio.HIGH)
        end 
    end)
end    

setwifi()
setTcpServer()  


ledswitch=0
pin1=1
pin2=2
pin3=3
pin4=4
--转换为毫秒
US_TO_MS = 1000


gpio.mode(pin1,gpio.OUTPUT)
gpio.mode(pin2,gpio.OUTPUT)
gpio.mode(pin3,gpio.OUTPUT)
gpio.mode(pin4,gpio.OUTPUT)

function LDown()
    gpio.write(pin1, gpio.LOW)
    gpio.write(pin2, gpio.HIGH)
    print("LDOWN")
end

function LUp()
    gpio.write(pin1,gpio.HIGH)
    gpio.write(pin2,gpio.LOW)
    print("LUP")
end

function RDown()
    gpio.write(pin3,gpio.HIGH)
    gpio.write(pin4,gpio.LOW)
    print("RDOWN")
end

function RUp()
    gpio.write(pin3,gpio.LOW)
    gpio.write(pin4,gpio.HIGH)
    print("RUP")
end

function Stop()
    gpio.write(pin1,gpio.LOW)
    gpio.write(pin2,gpio.LOW)
    gpio.write(pin3,gpio.LOW)
    gpio.write(pin4,gpio.LOW)
    print("STOP")
end

function Up()
    LUp()
    RUp()
end

function Down()
    LDown()
    RDown()
end

function Left()
    LDown()
    RUp()
end

function Right()
    LUp()
    RDown()
end

--RUp()
--tmr.delay(500 * US_TO_MS)
--Stop()

function setwifi()
    wifi.setmode(wifi.STATION)
    wifi.sta.config("Wfhome","15980936465") -- Replace these two args with your own network
    ip, nm, gw=wifi.sta.getip()
    print("\nIP Info:\nIP Address: "..ip.."")
end

function setTcpServer()
    srv=net.createServer(net.TCP)
    srv:listen(80,function(conn)
      conn:on("receive",function(conn,payload)
        print(payload)
        if payload == 'L' then
            Left()
        end
        if payload == 'R' then
            Right()
        end
        if payload == 'U' then
            Up()
        end
        if payload == 'D' then
            Down()
        end  
        tmr.delay(500 * US_TO_MS)
        Stop()                              
      end)
      conn:on("sent",function(conn) conn:close() end)
    end)
end  
    

setwifi()
setTcpServer()  



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
end

function LUp()
    gpio.write(pin1,gpio.HIGH)
    gpio.write(pin2,gpio.LOW)
end

function RDown()
    gpio.write(pin3,gpio.HIGH)
    gpio.write(pin4,gpio.LOW)
end

function RUp()
    gpio.write(pin3,gpio.LOW)
    gpio.write(pin4,gpio.HIGH)
end

function Stop()
    gpio.write(pin1,gpio.LOW)
    gpio.write(pin2,gpio.LOW)
    gpio.write(pin3,gpio.LOW)
    gpio.write(pin4,gpio.LOW)
end

function Up()
    LUp()
    RUp()
    print("Up")
end

function Down()
    LDown()
    RDown()
    print("Down")    
end

function Left()
    LDown()
    RUp()
    print("Left")    
end

function Right()
    LUp()
    RDown()
    print("Right")    
end

--RUp()
--tmr.delay(500 * US_TO_MS)
--Stop()

function setwifi()
    wifi.setmode(wifi.STATION)
    wifi.sta.config("Wfhome","15980936465") -- Replace these two args with your own network
    ip, nm, gw=wifi.sta.getip()
    print()
    print("\nIP Info:\nIP Address: "..ip.."")
end

function setTcpServer()
    srv=net.createServer(net.TCP)
    srv:listen(80,function(conn)
      conn:on("receive",function(conn,payload)
        print(payload)
        if payload == 'C' then
            conn:close()
            print('close')
        end        
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



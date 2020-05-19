print('init begin')
ledswitch=0
button = 3
led = 4
pin1=5
pin2=6
pin3=7
pin4=8
button = 3
--转换为毫秒
US_TO_MS = 1000
ip = nil


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

function setwifi()
    wifi.setmode(wifi.STATION)
    wifi.sta.config("Wfhome","15980936465") -- Replace these two args with your own network
    ip=wifi.sta.getip()
    wifi.sta.autoconnect(1)
    print(ip)
    if ip ~= nil then
        print("\nIP Info:\nIP Address: "..ip.."")
        Down()
    end    
end

function sendCmd(payload)      
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
end      

function setTcpServer()
    srv=net.createServer(net.TCP)
    srv:listen(80,function(conn)
      conn:on("receive",function(client,request)
        local buf = "";
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end
        local _GET = {}
        if (vars ~= nil)then
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                _GET[k] = v
            end
        end
        sendCmd(_GET.pin);
        buf = buf.."<h1> ESP8266 Web Server</h1>";
        buf = buf.."<p>GPIO0 <a href=\"?pin=L\"><button>L</button></a><a href=\"?pin=R\"><button>R</button></a><a href=\"?pin=U\"><button>U</button></a><a href=\"?pin=D\"><button>D</button></a></p>";
        client:send(buf);
        client:close();
        collectgarbage();                            
      end)
      conn:on("sent",function(conn) conn:close() end)
    end)
end  
print('init end')


print(ip)
setTcpServer()

 

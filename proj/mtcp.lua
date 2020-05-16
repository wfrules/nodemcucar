require("mcar")
mTcp = {}

function sendCmd(payload)      
    if payload == 'L' then
        mCar.Left()
    end
    if payload == 'R' then
        mCar.Right()
    end
    if payload == 'U' then
        mCar.Up()
    end
    if payload == 'D' then
        mCar.Down()
    end  
    tmr.delay(500 * 1000)
    mCar.Stop()
end 

function mTcp.start()
    mCar.init()
    print('tcp start..')
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

return mTcp

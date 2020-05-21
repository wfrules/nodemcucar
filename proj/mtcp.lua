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
        buf = buf.."<style>.btn{text-align:center;border: 1px solid;color: red;background-color: blue;width: 300px; height: 300px,}</style><a href=\"?pin=L\" class=\"btn\"><div class=\"btn\" >L</div></a><a href=\"?pin=R\" class=\"btn\"><div class=\"btn\">R</div></a><a href=\"?pin=U\" class=\"btn\"><div class=\"btn\">U</div></a><a href=\"?pin=D\" class=\"btn\"><div class=\"btn\">D</div></a>";
        client:send(buf);
        client:close();
        collectgarbage();                            
      end)
      conn:on("sent",function(conn) conn:close() end)
    end)
end  

return mTcp

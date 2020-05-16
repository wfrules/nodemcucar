mTcp = {}

function mTcp.start()
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

require("mcar")
mTcp = {}

function checkDelay()
    if mCar.prop.keep == false then
        tmr.delay(500 * 1000)
        mCar.Stop()      
    end
end

function jsonHandle(payload)
    sJson = string.gsub(payload, 'j_', '');
    objJson = cjson.decode(sJson)
    mCar.prop.ena = objJson.pwma;
    mCar.prop.enb = objJson.pwmb;
    mCar.prop.keep = objJson.keep;
    mCar.synPwm();
end

function sendCmd(payload)   
    idx = string.find(payload, 'j_')
    if idx == 1 then
       jsonHandle(payload) 
    end
   
    if payload == 'L' then
        mCar.Left()  
        checkDelay()    
    end
    if payload == 'R' then
        mCar.Right()
        checkDelay()      
    end
    if payload == 'U' then
        mCar.Up()
        checkDelay()        
    end
    if payload == 'D' then
        mCar.Down()
        checkDelay()       
    end 
    if payload == 'S' then
        mCar.Stop()
        checkDelay()        
    end    
    if payload == 'KF' then
        mCar.prop.keep = false
    end 
    if payload == 'KT' then
        mCar.prop.keep = true
    end 
    return cjson.encode(mCar.prop)            
end 

function mTcp.start()
    mCar.init()
    srv=net.createServer(net.TCP)
    srv:listen(80,function(conn)
      conn:on("receive",function(client,request)
        vRet = sendCmd(request);
        conn:send(vRet)                        
      end)
      conn:on("sent",function(conn) conn:close() end)
    end)
end


return mTcp

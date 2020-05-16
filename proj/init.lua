require("mdebug")
require("mwifi")
require("mtcp")
gpio.mode(mDebug.led, gpio.OUTPUT)
bRet = mWifi.hold()
if bRet then
    mTcp.start()
end    
--mButton.watch()
print('over')

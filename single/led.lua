ledswitch=0
pin=4
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

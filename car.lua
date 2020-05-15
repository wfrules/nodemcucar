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

function lDown()
    gpio.write(pin1, gpio.LOW)
    gpio.write(pin2, gpio.HIGH)
end

function lUp()
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



RUp()
tmr.delay(500 * US_TO_MS)


mCar = {}
mCar.pin1=5
mCar.pin2=6
mCar.pin3=7
mCar.pin4=8
mCar.prop = {}
mCar.prop.keep = false

function mCar.init()
    gpio.mode(mCar.pin1,gpio.OUTPUT)
    gpio.mode(mCar.pin2,gpio.OUTPUT)
    gpio.mode(mCar.pin3,gpio.OUTPUT)
    gpio.mode(mCar.pin4,gpio.OUTPUT)
end  

function mCar.LDown()
    gpio.write(mCar.pin1, gpio.LOW)
    gpio.write(mCar.pin2, gpio.HIGH)
end

function mCar.LUp()
    gpio.write(mCar.pin1,gpio.HIGH)
    gpio.write(mCar.pin2,gpio.LOW)
end

function mCar.RDown()
    gpio.write(mCar.pin3,gpio.HIGH)
    gpio.write(mCar.pin4,gpio.LOW)
end

function mCar.RUp()
    gpio.write(mCar.pin3,gpio.LOW)
    gpio.write(mCar.pin4,gpio.HIGH)
end

function mCar.Stop()
    gpio.write(mCar.pin1,gpio.LOW)
    gpio.write(mCar.pin2,gpio.LOW)
    gpio.write(mCar.pin3,gpio.LOW)
    gpio.write(mCar.pin4,gpio.LOW)
end

function mCar.Up()
    mCar.LUp()
    mCar.RUp()
    print("Up")
end

function mCar.Down()
    mCar.LDown()
    mCar.RDown()
    print("Down")    
end

function mCar.Left()
    mCar.LDown()
    mCar.RUp()
    print("Left")    
end

function mCar.Right()
    mCar.LUp()
    mCar.RDown()
    print("Right")    
end

return mCar

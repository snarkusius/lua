math.randomseed(os.time())
random = math.random(100)
print(random)
print("gess")
gess = tonumber(io.read()) 

while gess ~= randomseed 
do 
    if gess > random then
        print("lower")
        end
    if gess < random then
        print("higher")
    end
    gess = tonumber(io.read()) 
end
print("korekt")
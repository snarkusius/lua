print("Hello vorld" .. "god")
name = "marcus"
eman = string.reverse(name)
print("hello".." "..name)
print(eman)
-- comment
add = function(a,b)
    return a+b
end
print(add(1,2))
print(5~=5 and 7==7)
animal = "dog"
if (animal == "dog") 
    then print("i am runnig") 
    else
        print("i am not runnig")
end
x=0
while x < 5
do  x = x+1
    print(x)
end
print("Enter your name:")
name = io.read()

print("What's your favorite food?")
food = io.read()

print("Your name is " .. name .. " and your favorite food is " .. food .. ".")
print(math.random(100))
print(os.time())
seed_number = os.time()
math.randomseed(seed_number)
print(math.random(100))
list = {[0]= "hej0","hej","hej2","hej3"}
print(#list)
coins = {
    ["half"] = "50 cents",
    ["quarter"] = "25 cents",
    ["dime"] = "10 cents",
    ["nickel"] = "5 cents",
    ["penny"] = "1 cent"
  }
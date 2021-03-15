width = 160
flipsPerLine = 5

x = 0
switches = {}

for k=1, width do
    switches[k] = false
end

ch = {}
str = "1234567890qwertyuiopasdfghjklzxcvbnm,./';[]!@#$%^&*()-=_+"
for i = 1, #str do
    ch[i] = str:sub(i, i)
end

l = 57

while true do 

    for i=0,width do

        if (switches[i] == true) then
            io.write(ch[math.random(1,l)])
            io.write(" ")
        else 
            io.write("  ")
        end 
        i= i+1
    end

    for i=0,flipsPerLine do
        x = math.random(1,width)
        switches[x] = not switches[x]
    end 

    io.write('\n')
    
end
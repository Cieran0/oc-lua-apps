--Components
local term = require("term")
local component = require("component")
local keyboard = require("keyboard")
local gpu = component.gpu

--Important Keys
local up = 0xC8
local down = 0xD0
local left = 0xCB
local right = 0xCD

--Colours
local snakecolour = 0x0000FF
local backcolour = 0x000000
local applecolour=0xFF0000

--Termsize
local w,h=gpu.getResolution()
w = w/2

--Snake Stats
local lastfacing = {}
local facing = {}
local snakepieceX = {}
local snakepieceY = {}
local size = #snakepieceX
local alive = false
local appleX = 0
local appleY = 0
local score = 0

--Draws the snake
function draw()

  term.clear()
  size = #snakepieceX
  
  gpu.setBackground(applecolour)
  gpu.set(appleX*2,appleY,'  ')  

  gpu.setBackground(snakecolour)   

  for i=1,size do
    gpu.set(snakepieceX[i]*2,snakepieceY[i],'  ')
  end

  gpu.setBackground(backcolour)

end

--Initialises the game
function init()

  snakepieceX[1]=10
  snakepieceY[1]=10
  snakepieceX[2]=9
  snakepieceY[2]=10
  lastfacing[1] = 0
  lastfacing[2] = 0
  facing[1] = 4
  facing[2] = 0  
  alive = true
  newapple()
end

--Changes the direction of the snake
function changeDir()

  if keyboard.isKeyDown(up) == true and facing[1] ~= 2 then
    facing[1] = 1
  elseif keyboard.isKeyDown(down) == true and facing[1] ~= 1 then
    facing[1] = 2
  elseif keyboard.isKeyDown(left) == true and facing[1] ~= 4 then
    facing[1] = 3
  elseif keyboard.isKeyDown(right) == true and facing[1] ~=3 then
    facing[1] = 4
  elseif keyboard.isKeyDown(0x10) then
    die()
  end

end

function die()
  alive = false
end


--Handles Movement
function move()

  size = #snakepieceX
  for i=1,size do
    
    lastfacing[i] = facing[i]

    if i > 1 then
      facing[i] = lastfacing[i-1]      
    end

  end

  changeDir()

  for i=1,size do
    if facing[i] == 1 then
      snakepieceY[i] = snakepieceY[i] - 1
    elseif facing[i] == 2 then
      snakepieceY[i] = snakepieceY[i] + 1
    elseif facing[i] == 3  then
      snakepieceX[i] = snakepieceX[i] - 1
    elseif facing[i] == 4 then
      snakepieceX[i] = snakepieceX[i] + 1
    end 
    
    if snakepieceX[i] > w then
       die()  
    elseif snakepieceX[i] < 0 then
       die()
    elseif snakepieceY[i] > h then
       die()
    elseif snakepieceY[i] < 0 then
       die()
    end

  end

  col()  

end

--Handles Collisions
function col()

  for i=2,size do

    if snakepieceX[1] == snakepieceX[i] and snakepieceY[1] == snakepieceY[i] then
      die()
    end

  end

  if snakepieceX[1] == appleX and snakepieceY[1] == appleY then  
    apple()
  elseif snakepieceX[1]+1 == appleX and snakepieceY[1] == appleY then
    apple()
  end
end

--Apple
function apple()
  score = score + 1
  newapple()
  size = #snakepieceX


  if facing[size] == 1 then
    snakepieceX[size+1] = snakepieceX[size]
    snakepieceY[size+1] = snakepieceY[size] + 1 
  elseif facing[size] == 2 then
    snakepieceX[size+1] = snakepieceX[size] 
    snakepieceY[size+1] = snakepieceY[size] - 1
  elseif facing[size] == 3 then
    snakepieceX[size+1] = snakepieceX[size] + 1
    snakepieceY[size+1] = snakepieceY[size]
  elseif facing[size] == 4 then
    snakepieceX[size+1] = snakepieceX[size] - 1
    snakepieceY[size+1] = snakepieceY[size]
  end

  facing[size+1] = lastfacing[size]

end

--NewApple
function newapple()

  math.randomseed(os.time())
  appleX = math.random(1,w-1)
  appleY = math.random(1,h-1)

end

term.clear()
init()
while alive do

  move()
  draw()
  os.sleep(0.16)

end
io.write("Your score was:")
print(score)
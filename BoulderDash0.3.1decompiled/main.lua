 running = false
 menu = true
 paused = false
ended = false
shop = false
settings = false

math.randomseed(os.time())

io.input("Highscore.txt")
local first = io.read("number")
io.close()

io.input("difficulty.txt") 
local difficulty = io.read("number") 
io.close()

function love.load()
Player = {}
Player.x = 200
Player.y = 500
Player.sprite = love.graphics.newImage("sprites/Player.png")
Player.jumpHeight = 310 
Player.jumpForce = -5
Player.jumptimer = 0

Obstacle = {}
Obstacle.x = 300
Obstacle.y = 50
Obstacle.sprite = love.graphics.newImage("sprites/Obstacle.png")
Obstacle.reset = true

Coin = {}
Coin.x = 400
Coin.y = 500
Coin.sprite = love.graphics.newImage("sprites/Coin.png")

Heart = {}
Heart.x = 600
Heart.y = 1020
Heart.radius = 15


Ground = {}
Ground.x = 0
Ground.y = Player.y + 50
Ground.width = 850
Ground.height = 100

deathMessage = {}
deathMessage.x = 1000
deathMessage.y = 1000 

Health1 = {}
Health1.x = 600
Health1.y = 50

score = 0
Score1 = {}
Score1.x = 40
Score1.y = 150

health = 5
if difficulty == 2 then health = 4 end
if difficulty == 3 then health = 3 end

speed = 7
timer = 0
gravity = 0

Highscore = {}
Highscore.x = 40
Highscore.y = 100
Highscore1 = first

Button = {}
Button.x = 130
Button.y = 100

Button1 = {}
Button1.x = 130
Button1.y = 300

Button2 = {}
Button2.x = 130
Button2.y = 200

Button3 = {}
Button3.x = 250
Button3.y = 250

Button4 = {}
Button4.x = 250
Button4.y = 150

timer = 1
test = false

mouse = {}
fpsenabled1 = "true"
fpsenabled = true

font = love.graphics.setNewFont(31)
font1 = love.graphics.setNewFont(60)

    end
    

function love.update(dt)
 
Highscore1 = first
  speed = speed + difficulty /999 + score/99999


if Coin.y < Player.jumpHeight then Coin.y = Player.jumpHeight + 20
end

    if running and not paused then
    timer = timer + dt
    end

mouse.x, mouse.y = love.mouse.getPosition()

function love.mousepressed(x, y, button, istouch, presses) 
    if menu or ended
    then
        if distanceBetween(mouse.x, mouse.y, Button.x + 40, Button.y) < 70 then
running = true
menu = false
love.load()
if ended then 

    love.event.quit("restart") end
        elseif distanceBetween(mouse.x, mouse.y, Button1.x + 40, Button1.y + 50) < 70 then
                    
    love.event.quit()
        elseif distanceBetween(mouse.x, mouse.y, Button2.x + 40, Button2.y) < 70 then
            settings = true
            menu = false
            ended = false

            if fpsenabled == true then
                fpsenabled = false 
            
            elseif fpsenabled == false then 
                 fpsenabled = true 
                     end
            
        end
        end
   
        if settings then

          if distanceBetween(mouse.x, mouse.y, Button1.x + 140, Button1.y + 50) < 70 then
            print("button1")
            difficulty = difficulty + 1
            if difficulty > 3 then
                difficulty = 1
            end
            io.output("difficulty.txt")
            io.write(difficulty)
            
          end
       
          if distanceBetween(mouse.x, mouse.y, Button3.x , Button3.y ) < 70 then
        
          if fpsenabled == true then
            fpsenabled = false 
             elseif fpsenabled == false then 
             fpsenabled = true 
                 end
                 
                 
                end
            end
        end
           

   

 fps = love.timer.getFPS()
if settings then
 if fpsenabled == true then fpsenabled1 = "true" elseif 
    fpsenabled == false then  fpsenabled1 = "false"
end
end

if not paused then
    gravity = 11 + speed - 7
end

if distanceBetween(Heart.x, Heart.y, Player.x, Player.y) < 50 and running then
    Heart.x = math.random(50, 700)   
    health = health + 1
    Heart.y = 1000    
end


    if running then 
if math.floor(timer) == 20 then 
    timer = 0
    Heart.y = Player.y
end
end



Player.y = Player.y + gravity 

if Player.y > 500 then
    Player.y = Ground.y - 50
end

    if distanceBetween(Obstacle.x, Obstacle.y, Player.x, Player.y) < 50 and running then
        health = health - 1
        if score > 1 then
        score = score - 2 
        end
        Player.x = math.random(50, 700)
    end
if not paused then
    Obstacle.y = Obstacle.y + speed
end
    if Obstacle.y > 520 and Obstacle.reset == true then 
        Obstacle.y = 50 
        Obstacle.x = math.random(50, 700)
    end

    if distanceBetween(Coin.x, Coin.y, Player.x, Player.y) < 50 and running then
        score = score + 1
        Coin.x = math.random(50, 700)
        Coin.y = math.random(Player.y - (speed - 7) * 5 , Player.y - (speed - 7) * 6)
        if distanceBetween(Coin.x, Coin.y, Player.x, Player.y) < 90 then
            Coin.x = math.random(50, 70)
        end
    end


if love.keyboard.isDown("left") and running and not paused then
    Player.x = Player.x - speed 
    if Player.x <= 0 then 
        Player.x = 0
    end
  end


if love.keyboard.isDown("right") and running and not paused 
then Player.x = Player.x + speed  
     if Player.x >= 740 then 
        Player.x = 740
    end
end

if love.keyboard.isDown("e") 
then
    running = true
    menu = false
    ended = false 
    paused = false

    love.load()
end

if menu or ended or paused  then
    love.mouse.setVisible(true)
elseif 
 running  then 
    love.mouse.setVisible(false)   
end

function love.keypressed(key) if running and 
    key == "up" and paused == false 
then 
    for i = 1, 300, 1 do
        Player.jumptimer = Player.jumptimer + 1
        if Player.jumptimer == 604 then
            Player.jumptimer = 0
        end
        if Player.y > Player.jumpHeight and Player.jumptimer < 301 
         then Player.y = Player.y + Player.jumpForce - Player.jumpSpeed
        end
end
end
end


 Player.jumpSpeed = (speed - 7) * 5 


 if ended then
    Health1.y = 1000
    Coin.y = 1000
    Heart.y = 1000
    Obstacle.reset = false
    health = 1
 end

 
if health < 1 then   
    deathMessage.x = 300
    deathMessage.y = 300 

    if score > Highscore1 then
    io.output("Highscore.txt")   
    io.write(score)  
    end
    running = false
    ended = true
     end

     if love.keyboard.isDown("d") then
         health = 0
     end

     if love.keyboard.isDown("r") then
        io.output("Highscore.txt")   
        io.write(0)
        io.close()
        io.output("difficulty.txt")   
        io.write(1)
        io.close()
        love.event.quit("restart")
    end

if love.keyboard.isDown("escape") 
then love.event.quit("restart")
end

if love.keyboard.isDown("p") and 
  paused == false then
        paused = true 
    end

    if love.keyboard.isDown("u") and 
  paused == true then
        paused = false 
    end


if paused == true then
print("paused")
end

if menu == true then
    print("menu")
    end

if ended == true then
        print("ended")
        end

if running == true then
            print("running")
            end

if settings == true then
            print("settings")
            end

end



function love.draw()
   
if fpsenabled1 == "true" then
        love.graphics.setFont(font1)
        love.graphics.print(fps, 50, 500)
end
    if settings then
        if fpsenabled1 == "true" then
            love.graphics.setFont(font1)
            love.graphics.print(fps, 50, 500)
    end
        love.graphics.setFont(font1)
        love.graphics.print("Settings", 100, 130)
        love.graphics.setFont(font)
        love.graphics.setColor(0.3, 0.3, 0.3)
        love.graphics.rectangle("fill", Button1.x + 100, Button1.y + 50, 180, 50)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("Difficulty", Button1.x + 120, Button1.y + 50)
        love.graphics.setColor(0.3, 0.3, 0.3)
        love.graphics.rectangle("fill", Button3.x , Button3.y , 95, 50)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("FPS", Button3.x + 20, Button3.y )
        love.graphics.print(difficulty, Button1.x + 350, Button1.y + 50)
        love.graphics.print(fpsenabled1, Button2.x + 220, Button2.y + 50)
    end
    if menu or ended then 
        if fpsenabled1 == "true" then
            love.graphics.setFont(font1)
            love.graphics.print(fps, 50, 500)
    end
        love.graphics.setFont(font1)
        love.graphics.print("Boulder Dash", 300, 100)
        love.graphics.setFont(font)
        love.graphics.setColor(0.3, 0.3, 0.3)
        love.graphics.rectangle("fill", Button.x, Button.y, 120, 50)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("Start", Button.x + 20, Button.y)
        love.graphics.setColor(0.3, 0.3, 0.3)
        love.graphics.rectangle("fill", Button1.x, Button1.y, 120, 50)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("Exit", Button1.x + 20, Button1.y)
        love.graphics.setColor(0.3, 0.3, 0.3)
        love.graphics.rectangle("fill", Button2.x, Button2.y, 160, 50)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("Settings", Button2.x + 20, Button2.y)
    end

    if running then
        if fpsenabled1 == "true" then
            love.graphics.setFont(font1)
            love.graphics.print(fps, 50, 500)
    end
        love.graphics.setFont(font)
        love.graphics.print(math.floor(timer), 40, 200)
        love.graphics.setColor(1, 0.2, 0.1)
        if paused and not menu then
            love.graphics.setColor(0.1, 0.1, 0.1) 
        end
        love.graphics.circle("fill", 100, 220, Heart.radius)
        love.graphics.setColor(1, 1, 1 )
        if paused and not menu then
            love.graphics.setColor(0.1, 0.1, 0.1) 
        end
    end
    if running or ended then 
love.graphics.setColor(0, 1, .1)
if paused and not menu and not ended then
    love.graphics.setColor(0.1, 0.1, 0.1) 
end
love.graphics.rectangle("fill", Ground.x, Ground.y, Ground.width, Ground.height)
love.graphics.setColor(1, 0.2, 0.1)
if paused and not menu and not ended then
    love.graphics.setColor(0.1, 0.1, 0.1) 
end
love.graphics.circle("fill", Heart.x, Heart.y, Heart.radius)
love.graphics.setColor(1, 1, 1 )
if paused and not menu and not ended then
    love.graphics.setColor(0.1, 0.1, 0.1) 
end
love.graphics.draw(Coin.sprite, Coin.x, Coin.y)
love.graphics.draw(Player.sprite, Player.x, Player.y)
love.graphics.draw(Obstacle.sprite, Obstacle.x, Obstacle.y)
love.graphics.draw(Coin.sprite, 70, Score1.y - 10)
love.graphics.setFont(font)
love.graphics.print(score, Score1.x, Score1.y)
love.graphics.print(health, Health1.x, Health1.y)
love.graphics.print("You Died!", deathMessage.x, deathMessage.y)
love.graphics.print(Highscore1, Highscore.x, Highscore.y)
love.graphics.print("HS", Highscore.x + 40, Highscore.y)
end
end
function distanceBetween(x1, y1, x2, y2)
    return math.sqrt( (x2 - x1)^2 + (y2 - y1)^2 )
    end

    function wait(seconds) 
        start = os.time() 
        repeat until os.time() > start + seconds
    end
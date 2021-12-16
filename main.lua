wf = require "libraries/windfield"
sti = require "libraries/sti"
anim8 = require "libraries/anim8"
camera = require "libraries/camera" -- hump
timer = require "libraries/timer" -- hump

require "models/Player"
require "models/Enemy"

gameIsPaused = false

function love.load()
  love.window.setTitle('mamustere')
  love.graphics.setDefaultFilter("nearest", "nearest")

  cam = camera(0, 0, 2)
  world = wf.newWorld(0, 500)
  gameMap = sti("maps/level-00.lua")
  
  world:addCollisionClass("Enemy")
  world:addCollisionClass("Player")

  if gameMap.layers["block-platforms"] then
    for i, obj in pairs(gameMap.layers["block-platforms"].objects) do
      local platform = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
      platform:setType("static")
    end
  end

  sunEnemies = {}
  if gameMap.layers["sun-enemies"] then
    for i, obj in pairs(gameMap.layers["sun-enemies"].objects) do
      local enemy = Enemy:new{ x = obj.x + 32, y = obj.y }
      table.insert(sunEnemies, enemy)
    end
  end

  player = Player:new{
    x = 16 * 2,
    y = 16 * 98
  }
end

function love.update(dt)
  timer.update(dt)

  local isMoving = false
  local px, py = player.collider:getLinearVelocity()
  
  if love.keyboard.isDown("right") then
    isMoving = true
    player:gotoRight()

  elseif love.keyboard.isDown("left") then
    isMoving = true
    player:gotoLeft()
  
  end

  if isMoving == false then
    if py == 0 then
      player:setWalking()
    end
    
    player.animation:gotoFrame(1)
  end

  player.x = player.collider:getX()
  player.y = player.collider:getY()
  cam:lookAt(player.x, player.y)

  local w = love.graphics.getWidth()
  local h = love.graphics.getHeight()
  local mapW = gameMap.width * gameMap.tilewidth
  local mapH = gameMap.height * gameMap.tileheight
  
  -- top
  if cam.y <= h/4 then
    cam.y = h/4
  end

  -- right
  if cam.x >= mapW - w/4 then
    cam.x = mapW - w/4
  end

  -- bottom
  if cam.y >= mapH - h/4 then
    cam.y = mapH - h/4
  end

  -- left
  if cam.x <= w/4 then
    cam.x = w/4
  end

  if player.x <= player.width / 2 then
    player.collider:setLinearVelocity(0, py)
    player.collider:setX(player.width / 2)

  elseif player.x >= mapW - player.width / 2 then
    player.collider:setLinearVelocity(0, py)
    player.collider:setX(mapW - player.width / 2)

  end

  world:update(dt)

  if gameIsPaused == false then
    player.animation:update(dt)
    
    for idx, enemy in pairs(sunEnemies) do
      enemy.animation:update(dt)
      if enemy.collider:enter("Player") then
        player:hurt()
      end
    end
  end
end

function love.keypressed(key)
  local px, py = player.collider:getLinearVelocity()

  if key == "up" and py == 0 then
    player:setJumping()
    player.collider:applyLinearImpulse(0, -175)
  end
end

function love.draw()
  cam:attach()    
    gameMap:drawLayer(gameMap.layers["platforms"])
    
    for idx, enemy in pairs(sunEnemies) do
      enemy.animation:draw(
        enemy.spriteSheet,
        enemy.x,
        enemy.y
      )
    end

    player.animation:draw(
      player.spriteSheet,
      player.x,
      player.y,
      nil, -- angle
      nil, -- scale x
      nil, -- scale y
      player.width / 2, -- offset x
      player.height / 2 -- offset y
    )

    -- world:draw()
  cam:detach()
end

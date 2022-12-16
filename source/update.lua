local function update(dt)
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
    goal.animation:update(dt)

    for idx, enemy in pairs(enemies) do
      enemy.animation:update(dt)
      if enemy.collider:enter("Player") then
        player:damage()
      end
    end
  end
end

local function camUpdate()

end

return update
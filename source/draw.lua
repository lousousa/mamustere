local function draw()
  if isShowingEndingScreen == true then
    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()
    local fontHeight = love.graphics.getFont():getHeight()
    local lineHeight = love.graphics.getFont():getLineHeight()
    local msg = "you beat the level,\nyou're awesome!\n\nthanks for playing!"
    local linesCount = 4

    love.graphics.printf(msg, 0, (h - fontHeight * lineHeight * linesCount)/2, w, "center")

    do return end
  end

  cam:attach()
    gameMap:drawLayer(gameMap.layers["platforms"])

    for idx, enemy in pairs(enemies) do
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

    goal.animation:draw(
      goal.spriteSheet,
      goal.x,
      goal.y
    )

    -- world:draw()
  cam:detach()
end

return draw
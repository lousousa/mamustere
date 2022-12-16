wf = require "libraries/windfield"
sti = require "libraries/sti"
anim8 = require "libraries/anim8"
camera = require "libraries/camera" -- hump
timer = require "libraries/timer" -- hump

require "models/Player"
require "models/Enemy"
require "models/Goal"

isPaused = false
isShowingEndingScreen = false

function love.load()
  local load = require("source/load")
  load()
end

function love.update(dt)
  local update = require("source/update")
  update(dt)
end

function love.keypressed(key)
  local px, py = player.collider:getLinearVelocity()

  if key == "up" and py == 0 then
    player:setJumping()
    player.collider:applyLinearImpulse(0, -175)
  end
end

function love.draw()
  if isShowingEndingScreen == true then
    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()
    local fontHeight = love.graphics.getFont():getHeight()
    local lineHeight = love.graphics.getFont():getLineHeight()

    love.graphics.printf("you beat the level,\nyou're awesome!\n\nthanks for playing!", 0, (h - fontHeight * lineHeight * 4)/2, w, "center")

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

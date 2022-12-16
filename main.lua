wf = require "libraries/windfield"
sti = require "libraries/sti"
anim8 = require "libraries/anim8"
camera = require "libraries/camera" -- hump
timer = require "libraries/timer" -- hump

require "models/Player"
require "models/Enemy"
require "models/Goal"

gameIsPaused = false

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

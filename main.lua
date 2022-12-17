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
  local draw = require("source/draw")
  draw()
end

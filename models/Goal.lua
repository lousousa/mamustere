Goal = {}

function Goal:new (o)
  -- o = o or {}
  setmetatable(o, self)
  self.__index = self

  o.width = 24
  o.height = 24

  o.spriteSheet = love.graphics.newImage("assets/images/moon.png")

  o.grid = anim8.newGrid(
    o.width,
    o.height,
    o.spriteSheet:getWidth(),
    o.spriteSheet:getHeight()
  )

  o.animations = {
    idle = anim8.newAnimation(o.grid("1-6", 1), 0.125)
  }

  o.animation = o.animations.idle

  o.collider = world:newCircleCollider(o.x + 12, o.y + 12, o.width / 2 - 6)
  o.collider:setCollisionClass("Goal")
  o.collider:setFixedRotation(true)
  o.collider:setType("static")

  return o
end
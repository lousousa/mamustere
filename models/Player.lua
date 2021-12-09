Player = {}

function Player:new (o)
  -- o = o or  {}
  setmetatable(o, self)
  self.__index = self

  o.width = 16
  o.height = 16

  o.direction = 'r'
  
  o.spriteSheet = love.graphics.newImage("assets/mamukitty.png")

  o.grid = anim8.newGrid(
    o.width,
    o.height,
    o.spriteSheet:getWidth(),
    o.spriteSheet:getHeight()
  )

  o.animations = {
    r = {
      walking = anim8.newAnimation(o.grid("1-2", 1), 0.125),
      jumping = anim8.newAnimation(o.grid("1-1", 2), 1)
    },
    l = {
      walking = anim8.newAnimation(o.grid("1-2", 1), 0.125):flipH(),
      jumping = anim8.newAnimation(o.grid("1-1", 2), 1):flipH()
    }
  }

  o.animation = o.animations[o.direction].walking

  o.collider = world:newRectangleCollider(o.x, o.y, o.width, o.height)
  o.collider:setFriction(0.5)
  o.collider:setFixedRotation(true)

  return o
end

function Player:gotoRight()
  local px, py = self.collider:getLinearVelocity()
  self.direction = 'r'

  if py == 0 then
    self.animation = self.animations[self.direction].walking
  else
    self.animation = self.animations[self.direction].jumping
  end

  if px < 150 then
    player.collider:applyForce(300, 0)
  end
end

function Player:gotoLeft()
  local px, py = self.collider:getLinearVelocity()
  self.direction = 'l'

  if py == 0 then
    self.animation = self.animations[self.direction].walking
  else
    self.animation = self.animations[self.direction].jumping
  end

  if px > -150 then
    player.collider:applyForce(-300, 0)
  end
end

function Player:setWalking()
  self.animation = self.animations[self.direction].walking
end

function Player:setJumping()
  self.animation = self.animations[self.direction].jumping
end

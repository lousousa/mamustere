local function load()
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

return load
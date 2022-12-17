local function load()
  love.window.setTitle('mamustere')
  love.graphics.setDefaultFilter("nearest", "nearest")

  cam = camera(0, 0, 2)
  world = wf.newWorld(0, 500)
  gameMap = sti("maps/level-00.lua")
  primaryFont = love.graphics.newFont("assets/fonts/press-start.ttf", 18)
  primaryFont:setLineHeight(2)
  love.graphics.setFont(primaryFont)

  world:addCollisionClass("Enemy")
  world:addCollisionClass("Player")
  world:addCollisionClass("Goal")

  if gameMap.layers["block-platforms"] then
    for i, obj in pairs(gameMap.layers["block-platforms"].objects) do
      local platform = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
      platform:setType("static")
    end
  end

  enemies = {}
  if gameMap.layers["sun-enemies"] then
    for i, obj in pairs(gameMap.layers["sun-enemies"].objects) do
      local enemy = Enemy:new{ x = obj.x + 32, y = obj.y }
      table.insert(enemies, enemy)
    end
  end

  if gameMap.layers["goal"] then
    local obj = gameMap.layers["goal"].objects[1]
    goal = Goal:new{ x = obj.x, y = obj.y }
  end

  player = Player:new{
    x = 16 * 2,
    y = 16 * 98
  }
end

return load
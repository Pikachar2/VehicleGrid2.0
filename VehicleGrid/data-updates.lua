
local base_vehicles = {
  ["car"] = true,
  ["tank"] = true,
  ["spidertron"] = true,
  ["locomotive"] = true,
  ["cargo-wagon"] = true,
  ["fluid-wagon"] = true,
  ["artillery-wagon"] = true,
}

local tank_names = {
  ["tank"] = true,
  -- BobWarfare
  ["bob-tank-2"] = true,
  ["bob-tank-3"] = true,
  -- AAI
  ["vehicle-laser-tank"] = true,
  ["vehicle-flame-tank"] = true,
  -- VTK, when AAI is detected
  ["player-tank"] = true,
  -- HeavyTank
  ["HeavyTank_experimental_tank"] = true,
  ["HeavyTank_heavy_tank"] = true,
  ["HeavyTank_medium_tank"] = true,
  ["HeavyTank_scrap_tank"] = true,
  -- Angel's Exploration
  ["angels-heavy-tank"] = true,
}

local grid_override = settings.startup["VehicleGrid-override-grids"].value

-- "disabled": add grids for vehicles without grid
-- "update size": update size for all, keep existing tags
-- "override base": add grids for vehicles without grid, override base vehicles
-- "override all": override all grids
local function update_grid(entity, new_grid)
  local grid_prototype = entity.equipment_grid and data.raw["equipment-grid"][entity.equipment_grid]
  if grid_prototype then
    if grid_override == "update-size" then
      local new_grid_prototype = data.raw["equipment-grid"][new_grid]
      log(entity.name..": updating grid size of "..entity.equipment_grid..": "..
        grid_prototype.width.."x"..grid_prototype.height.." > "..
        new_grid_prototype.width.."x"..new_grid_prototype.height
      )
      grid_prototype.width = new_grid_prototype.width
      grid_prototype.height = new_grid_prototype.height
    elseif grid_override == "override-base" and base_vehicles[entity.name] then
      log(entity.name..": replacing grid "..entity.equipment_grid.." with "..new_grid)
      entity.equipment_grid = new_grid
    elseif grid_override == "override-all" then
      log(entity.name..": replacing grid "..entity.equipment_grid.." with "..new_grid)
      entity.equipment_grid = new_grid
    end
  else
    log(entity.name..": setting grid to "..new_grid)
    entity.equipment_grid = new_grid
  end
end


for _,entity in pairs(data.raw["car"]) do
  if tank_names[entity.name] then
    update_grid(entity, "tank-equipment-grid")
  else
    update_grid(entity, "car-equipment-grid")
  end
end
for _,entity in pairs(data.raw["spider-vehicle"]) do
  update_grid(entity, "spider-equipment-grid")
end
for _,entity in pairs(data.raw["locomotive"]) do
  update_grid(entity, "loco-equipment-grid")
  entity.allow_robot_dispatch_in_automatic_mode = settings.startup["VehicleGrid-automatic_mode-bots"].value
end
for _,entity in pairs(data.raw["cargo-wagon"]) do
  update_grid(entity, "wagon-equipment-grid")
  entity.allow_robot_dispatch_in_automatic_mode = settings.startup["VehicleGrid-automatic_mode-bots"].value
end
for _,entity in pairs(data.raw["fluid-wagon"]) do
  update_grid(entity, "wagon-equipment-grid")
  entity.allow_robot_dispatch_in_automatic_mode = settings.startup["VehicleGrid-automatic_mode-bots"].value
end
for _,entity in pairs(data.raw["artillery-wagon"]) do
  update_grid(entity, "artillery-wagon-equipment-grid")
  entity.allow_robot_dispatch_in_automatic_mode = settings.startup["VehicleGrid-automatic_mode-bots"].value
end


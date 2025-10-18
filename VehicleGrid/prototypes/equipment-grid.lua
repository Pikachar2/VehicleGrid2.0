local car_gridw, car_gridh = string.match(settings.startup["VehicleGrid-car"].value, "(%d+)x(%d+)")
local tank_gridw, tank_gridh = string.match(settings.startup["VehicleGrid-tank"].value, "(%d+)x(%d+)")
local spider_gridw, spider_gridh = string.match(settings.startup["VehicleGrid-spider"].value, "(%d+)x(%d+)")
local loco_gridw, loco_gridh = string.match(settings.startup["VehicleGrid-loco"].value, "(%d+)x(%d+)")
local wagon_gridw, wagon_gridh = string.match(settings.startup["VehicleGrid-wagon"].value, "(%d+)x(%d+)")
local art_wagon_gridw, art_wagon_gridh = string.match(settings.startup["VehicleGrid-artillery-wagon"].value, "(%d+)x(%d+)")

data:extend(
{
  {
    type = "equipment-grid",
    name = "car-equipment-grid",
    width = tonumber(car_gridw) or 8,
    height = tonumber(car_gridh) or 8,
    equipment_categories = {"armor"}
  },
  {
    type = "equipment-grid",
    name = "tank-equipment-grid",
    width = tonumber(tank_gridw) or 12,
    height = tonumber(tank_gridh) or 10,
    equipment_categories = {"armor"}
  },
  {
    type = "equipment-grid",
    name = "spider-equipment-grid",
    width = tonumber(spider_gridw) or 10,
    height = tonumber(spider_gridh) or 6,
    equipment_categories = {"armor"}
  },
  {
    type = "equipment-grid",
    name = "loco-equipment-grid",
    width = tonumber(loco_gridw) or 10,
    height = tonumber(loco_gridh) or 8,
    equipment_categories = {"armor"}
  },
  {
    type = "equipment-grid",
    name = "wagon-equipment-grid",
    width = tonumber(wagon_gridw) or 10,
    height = tonumber(wagon_gridh) or 6,
    equipment_categories = {"armor"}
  },
  {
    type = "equipment-grid",
    name = "artillery-wagon-equipment-grid",
    width = tonumber(art_wagon_gridw) or 10,
    height = tonumber(art_wagon_gridh) or 8,
    equipment_categories = {"armor"}
  },
})

local function add_equipment_category(grid_name, equipment_categories)
  for _, category in pairs(equipment_categories) do
    table.insert(data.raw["equipment-grid"][grid_name].equipment_categories, category)
  end
end

if mods["bobvehicleequipment"] then
  data.raw["equipment-grid"]["car-equipment-grid"].equipment_categories = {"car", "vehicle"}
  data.raw["equipment-grid"]["tank-equipment-grid"].equipment_categories = {"tank", "vehicle", "armoured-vehicle"}
  data.raw["equipment-grid"]["spider-equipment-grid"].equipment_categories = {"tank", "vehicle", "armoured-vehicle"}
  data.raw["equipment-grid"]["loco-equipment-grid"].equipment_categories = {"train", "vehicle", "locomotive"}
  data.raw["equipment-grid"]["wagon-equipment-grid"].equipment_categories = {"train", "vehicle", "cargo-wagon"}
  data.raw["equipment-grid"]["artillery-wagon-equipment-grid"].equipment_categories = {"train", "vehicle", "cargo-wagon", "armoured-vehicle", "armoured-train", "armoured-cargo-wagon"}
end

if mods["vtk-armor-plating"] then
  local vtk_armor = {"vtk-armor-plating"}
  add_equipment_category("car-equipment-grid", vtk_armor)
  add_equipment_category("tank-equipment-grid", vtk_armor)
  add_equipment_category("spider-equipment-grid", vtk_armor)
  add_equipment_category("loco-equipment-grid", vtk_armor)
  add_equipment_category("wagon-equipment-grid", vtk_armor)
  add_equipment_category("artillery-wagon-equipment-grid", vtk_armor)
end


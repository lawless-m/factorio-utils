module FactorioJSON

export recipes

using JSON

const recipeLUA = """
 
  {
    typ : "recipe",
    name : "player-port",
    enabled : false,
    ingredients :
    {
      {"electronic-circuit", 10},
      {"iron-gear-wheel", 5},
      {"iron-plate", 1 }
    },
    result : "player-port"
  },
  {
    typ : "recipe",
    name : "fast-transport-belt",
    enabled : false,
    ingredients :
    {
      {"iron-gear-wheel", 5},
      {"transport-belt", 1}
    },
    result : "fast-transport-belt",
    requester_paste_multiplier : 4
  },
  {
    typ : "recipe",
    name : "express-transport-belt",
    category : "crafting-with-fluid",
    enabled : false,
    ingredients :
    {
      {"iron-gear-wheel", 5},
      {"fast-transport-belt", 1},
      {type:"fluid", name:"lubricant", amount:2},
    },
    result : "express-transport-belt",
    requester_paste_multiplier : 4
  },
  {
    typ : "recipe",
    name : "solar-panel",
    energy_required : 10,
    enabled : false,
    ingredients :
    {
      {"steel-plate", 5},
      {"electronic-circuit", 15},
      {"copper-plate", 5}
    },
    result : "solar-panel"
  },
  {
    typ : "recipe",
    name : "assembling-machine-2",
    enabled : false,
    ingredients :
    {
      {"iron-plate", 9},
      {"electronic-circuit", 3},
      {"iron-gear-wheel", 5},
      {"assembling-machine-1", 1}
    },
    result : "assembling-machine-2",
    requester_paste_multiplier : 4
  },
  {
    typ : "recipe",
    name : "assembling-machine-3",
    enabled : false,
    ingredients :
    {
      {"speed-module", 4},
      {"assembling-machine-2", 2}
    },
    result : "assembling-machine-3"
  },
  {
    typ : "recipe",
    name : "car",
    enabled : false,
    ingredients :
    {
      {"engine-unit", 8},
      {"iron-plate", 20},
      {"steel-plate", 5}
    },
    result : "car"
  },
  {
    typ : "recipe",
    name : "tank",
    enabled : false,
    ingredients :
    {
      {"engine-unit", 16},
      {"steel-plate", 50},
      {"iron-gear-wheel", 15},
      {"advanced-circuit", 5}
    },
    result : "tank"
  },
  {
    typ : "recipe",
    name : "rail",
    enabled : false,
    ingredients :
    {
      {"stone", 1},
      {"iron-stick", 1},
      {"steel-plate", 1}
    },
    result : "rail",
    result_count : 2,
    requester_paste_multiplier : 4
  },
  {
    typ : "recipe",
    name : "diesel-locomotive",
    enabled : false,
    ingredients :
    {
      {"engine-unit", 20},
      {"electronic-circuit", 10},
      {"steel-plate", 30}
    },
    result : "diesel-locomotive"
  },
  {
    typ : "recipe",
    name : "cargo-wagon",
    enabled : false,
    ingredients :
    {
      {"iron-gear-wheel", 10},
      {"iron-plate", 20},
      {"steel-plate", 20}
    },
    result : "cargo-wagon"
  },
  {
    typ : "recipe",
    name : "train-stop",
    enabled : false,
    ingredients :
    {
      {"electronic-circuit", 5},
      {"iron-plate", 10},
      {"steel-plate", 3}
    },
    result : "train-stop"
  },
  {
    typ : "recipe",
    name : "rail-signal",
    enabled : false,
    ingredients :
    {
      {"electronic-circuit", 1},
      {"iron-plate", 5}
    },
    result : "rail-signal",
    requester_paste_multiplier : 4
  },
  {
    typ : "recipe",
    name : "rail-chain-signal",
    enabled : false,
    ingredients :
    {
      {"electronic-circuit", 1},
      {"iron-plate", 5}
    },
    result : "rail-chain-signal",
    requester_paste_multiplier : 4
  },
  {
    typ : "recipe",
    name : "heavy-armor",
    enabled : false,
    energy_required : 8,
    ingredients : {{ "copper-plate", 100}, {"steel-plate", 50}},
    result : "heavy-armor"
  },
  {
    typ : "recipe",
    name : "modular-armor",
    enabled : false,
    energy_required : 15,
    ingredients : {{ "advanced-circuit", 30}, {"processing-unit", 5}, {"steel-plate", 50}},
    result : "modular-armor"
  },
  {
    typ : "recipe",
    name : "power-armor",
    enabled : false,
    energy_required : 20,
    ingredients : {{ "processing-unit", 40}, {"electric-engine-unit", 20}, {"steel-plate", 40}, {"alien-artifact", 10}},
    result : "power-armor",
    requester_paste_multiplier : 1
  },
  {
    typ : "recipe",
    name : "power-armor-mk2",
    enabled : false,
    energy_required : 25,
    ingredients : {{ "effectivity-module-3", 5}, {"speed-module-3", 5}, {"processing-unit", 40}, {"steel-plate", 40}, {"alien-artifact", 50}},
    result : "power-armor-mk2",
    requester_paste_multiplier : 1
  },
  {
    typ : "recipe",
    name : "iron-chest",
    enabled : true,
    ingredients : {{"iron-plate", 8}},
    result : "iron-chest",
    requester_paste_multiplier : 4
  },
  {
    typ : "recipe",
    name : "steel-chest",
    enabled : false,
    ingredients : {{"steel-plate", 8}},
    result : "steel-chest",
    requester_paste_multiplier : 4
  },
  {
    typ : "recipe",
    name : "stone-wall",
    enabled : false,
    ingredients : {{"stone-brick", 5}},
    result : "stone-wall",
    requester_paste_multiplier : 10
  },
  {
    typ : "recipe",
    name : "gate",
    enabled : false,
    ingredients : {{"stone-wall", 1}, {"steel-plate", 2}, {"electronic-circuit", 2}},
    result : "gate"
  },
  {
    typ : "recipe",
    name : "flame-thrower",
    enabled : false,
    energy_required : 10,
    ingredients :
    {
      {"steel-plate", 5},
      {"iron-gear-wheel", 10}
    },
    result : "flame-thrower"
  },
  {
    typ : "recipe",
    name : "land-mine",
    enabled : false,
    energy_required : 5,
    ingredients :
    {
      {"steel-plate", 1},
      {"explosives", 2}
    },
    result : "land-mine",
    result_count : 4
  },
  {
    typ : "recipe",
    name : "rocket-launcher",
    enabled : false,
    energy_required : 5,
    ingredients :
    {
      {"iron-plate", 5},
      {"iron-gear-wheel", 5},
      {"electronic-circuit", 5}
    },
    result : "rocket-launcher"
  },
  {
    typ : "recipe",
    name : "shotgun",
    enabled : false,
    energy_required : 4,
    ingredients :
    {
      {"iron-plate", 15},
      {"iron-gear-wheel", 5},
      {"copper-plate", 10},
      {"wood", 5}
    },
    result : "shotgun"
  },
  {
    typ : "recipe",
    name : "combat-shotgun",
    enabled : false,
    energy_required : 8,
    ingredients :
    {
      {"steel-plate", 15},
      {"iron-gear-wheel", 5},
      {"copper-plate", 10},
      {"wood", 10}
    },
    result : "combat-shotgun"
  },
  {
    typ : "recipe",
    name : "railgun",
    enabled : false,
    energy_required : 8,
    ingredients :
    {
      {"steel-plate", 15},
      {"copper-plate", 15},
      {"electronic-circuit", 10},
      {"advanced-circuit", 5},
    },
    result : "railgun"
  },
  {
    typ : "recipe",
    name : "science-pack-1",
    energy_required : 5,
    ingredients :
    {
      {"copper-plate", 1},
      {"iron-gear-wheel", 1}
    },
    result : "science-pack-1"
  },
  {
    typ : "recipe",
    name : "science-pack-2",
    energy_required : 6,
    ingredients :
    {
      {"inserter", 1},
      {"transport-belt", 1}
    },
    result : "science-pack-2"
  },
  {
    typ : "recipe",
    name : "science-pack-3",
    enabled : false,
    energy_required : 12,
    ingredients :
    {
      {"battery", 1},
      {"advanced-circuit", 1},
      {"filter-inserter", 1},
      {"steel-plate", 1},
    },
    result : "science-pack-3"
  },
  {
    typ : "recipe",
    name : "alien-science-pack",
    enabled : false,
    energy_required : 12,
    ingredients : {{"alien-artifact", 1}
    },
    result : "alien-science-pack",
    result_count : 10
  },
  {
    typ : "recipe",
    name : "lab",
    energy_required : 5,
    ingredients :
    {
      {"electronic-circuit", 10},
      {"iron-gear-wheel", 10},
      {"transport-belt", 4}
    },
    result : "lab"
  },
  {
    typ : "recipe",
    name : "red-wire",
    enabled : false,
    ingredients :
    {
      {"electronic-circuit", 1},
      {"copper-cable", 1}
    },
    result : "red-wire",
    requester_paste_multiplier : 10
  },
  {
    typ : "recipe",
    name : "green-wire",
    enabled : false,
    ingredients :
    {
      {"electronic-circuit", 1},
      {"copper-cable", 1}
    },
    result : "green-wire",
    requester_paste_multiplier : 10
  },
  {
    typ : "recipe",
    name : "underground-belt",
    enabled : false,
    energy_required : 1,
    ingredients :
    {
      {"iron-plate", 10},
      {"transport-belt", 5}
    },
    result_count : 2,
    result : "underground-belt",
    requester_paste_multiplier : 4
  },
  {
    typ : "recipe",
    name : "fast-underground-belt",
    enabled : false,
    ingredients :
    {
      {"iron-gear-wheel", 20},
      {"underground-belt", 2}
    },
    result_count : 2,
    result : "fast-underground-belt",
    requester_paste_multiplier : 4
  },
  {
    typ : "recipe",
    name : "express-underground-belt",
    category : "crafting-with-fluid",
    enabled : false,
    ingredients :
    {
      {"iron-gear-wheel", 40},
      {"fast-underground-belt", 2},
      {type:"fluid", name:"lubricant", amount:4},
    },
    result_count : 2,
    result : "express-underground-belt"
  },
  {
    typ : "recipe",
    name : "loader",
    enabled : false,
    energy_required : 1,
    ingredients :
    {
      {"inserter", 5},
      {"electronic-circuit", 5},
      {"iron-gear-wheel", 5},
      {"iron-plate", 5},
      {"transport-belt", 5}
    },
    result : "loader"
  },
  {
    typ : "recipe",
    name : "fast-loader",
    enabled : false,
    energy_required : 3,
    ingredients :
    {
      {"fast-transport-belt", 5},
      {"loader", 1}
    },
    result : "fast-loader"
  },
  {
    typ : "recipe",
    name : "express-loader",
    enabled : false,
    energy_required : 10,
    ingredients :
    {
      {"express-transport-belt", 5},
      {"fast-loader", 1}
    },
    result : "express-loader"
  },
  {
    typ : "recipe",
    name : "splitter",
    enabled : false,
    energy_required : 1,
    ingredients :
    {
      {"electronic-circuit", 5},
      {"iron-plate", 5},
      {"transport-belt", 4}
    },
    result : "splitter",
    requester_paste_multiplier : 4
  },
  {
    typ : "recipe",
    name : "fast-splitter",
    enabled : false,
    energy_required : 2,
    ingredients :
    {
      {"splitter", 1},
      {"iron-gear-wheel", 10},
      {"electronic-circuit", 10}
    },
    result : "fast-splitter",
    requester_paste_multiplier : 4
  },
  {
    typ : "recipe",
    name : "express-splitter",
    category : "crafting-with-fluid",
    enabled : false,
    energy_required : 2,
    ingredients :
    {
      {"fast-splitter", 1},
      {"iron-gear-wheel", 10},
      {"advanced-circuit", 10},
      {type:"fluid", name:"lubricant", amount:8}
    },
    result : "express-splitter"
  },
  {
    typ : "recipe",
    name : "advanced-circuit",
    enabled : false,
    energy_required : 8,
    ingredients :
    {
      {"electronic-circuit", 2},
      {"plastic-bar", 2},
      {"copper-cable", 4}
    },
    result : "advanced-circuit",
    requester_paste_multiplier : 5
  },
  {
    typ : "recipe",
    name : "processing-unit",
    category : "crafting-with-fluid",
    enabled : false,
    energy_required : 15,
    ingredients :
    {
      {"electronic-circuit", 20},
      {"advanced-circuit", 2},
      {type:"fluid", name : "sulfuric-acid", amount : 0.5}
    },
    result : "processing-unit"
  },
  {
    typ : "recipe",
    name : "logistic-robot",
    enabled : false,
    ingredients :
    {
      {"flying-robot-frame", 1},
      {"advanced-circuit", 2}
    },
    result : "logistic-robot"
  },
  {
    typ : "recipe",
    name : "construction-robot",
    enabled : false,
    ingredients :
    {
      {"flying-robot-frame", 1},
      {"electronic-circuit", 2}
    },
    result : "construction-robot"
  },
  {
    typ : "recipe",
    name : "logistic-chest-passive-provider",
    enabled : false,
    ingredients :
    {
      {"steel-chest", 1},
      {"electronic-circuit", 3},
      {"advanced-circuit", 1}
    },
    result : "logistic-chest-passive-provider",
    requester_paste_multiplier : 4
  },
  {
    typ : "recipe",
    name : "logistic-chest-active-provider",
    enabled : false,
    ingredients :
    {
      {"steel-chest", 1},
      {"electronic-circuit", 3},
      {"advanced-circuit", 1}
    },
    result : "logistic-chest-active-provider",
    requester_paste_multiplier : 4
  },
  {
    typ : "recipe",
    name : "logistic-chest-storage",
    enabled : false,
    ingredients :
    {
      {"steel-chest", 1},
      {"electronic-circuit", 3},
      {"advanced-circuit", 1}
    },
    result : "logistic-chest-storage",
    requester_paste_multiplier : 4
  },
  {
    typ : "recipe",
    name : "logistic-chest-requester",
    enabled : false,
    ingredients :
    {
      {"steel-chest", 1},
      {"electronic-circuit", 3},
      {"advanced-circuit", 1}
    },
    result : "logistic-chest-requester",
    requester_paste_multiplier : 4
  },
  {
    typ : "recipe",
    name : "rocket-silo",
    enabled : false,
    ingredients :
    {
      {"steel-plate", 1000},
      {"concrete", 1000},
      {"pipe", 100},
      {"processing-unit", 200},
      {"electric-engine-unit", 200}
    },
    energy_required : 30,
    result : "rocket-silo",
    requester_paste_multiplier : 1
  },
  {
    typ : "recipe",
    name : "roboport",
    enabled : false,
    ingredients :
    {
      {"steel-plate", 45},
      {"iron-gear-wheel", 45},
      {"advanced-circuit", 45}
    },
    result : "roboport",
    energy_required : 15
  },
  {
    typ : "recipe",
    name : "steel-axe",
    enabled : false,
    ingredients :
    {
      {"steel-plate", 5},
      {"iron-stick", 2}
    },
    result : "steel-axe",
    requester_paste_multiplier : 4
  },
  {
    typ : "recipe",
    name : "big-electric-pole",
    enabled : false,
    ingredients :
    {
      {"steel-plate", 5},
      {"copper-plate", 5}
    },
    result : "big-electric-pole",
    requester_paste_multiplier : 4
  },
  {
    typ : "recipe",
    name : "substation",
    enabled : false,
    ingredients :
    {
      {"steel-plate", 10},
      {"advanced-circuit", 5},
      {"copper-plate", 5}
    },
    result : "substation"
  },
  {
    typ : "recipe",
    name : "medium-electric-pole",
    enabled : false,
    ingredients :
    {
      {"steel-plate", 2},
      {"copper-plate", 2}
    },
    result : "medium-electric-pole",
    requester_paste_multiplier : 4
  },
  {
    typ : "recipe",
    name : "accumulator",
    energy_required : 10,
    enabled : false,
    ingredients :
    {
      {"iron-plate", 2},
      {"battery", 5}
    },
    result : "accumulator"
  },
  {
    typ : "recipe",
    name : "steel-furnace",
    ingredients : {{"steel-plate", 8}, {"stone-brick", 10}},
    result : "steel-furnace",
    energy_required : 3,
    enabled : false
  },
  {
    typ : "recipe",
    name : "electric-furnace",
    ingredients : {{"steel-plate", 15}, {"advanced-circuit", 5}, {"stone-brick", 10}},
    result : "electric-furnace",
    energy_required : 5,
    enabled : false
  },
  {
    typ : "recipe",
    name : "beacon",
    enabled : false,
    energy_required : 15,
    ingredients :
    {
      {"electronic-circuit", 20},
      {"advanced-circuit", 20},
      {"steel-plate", 10},
      {"copper-cable", 10}
    },
    result : "beacon"
  },
  {
    typ : "recipe",
    name : "blueprint",
    energy_required : 1,
    ingredients :
    {
      {"advanced-circuit", 1}
    },
    result : "blueprint",
    enabled : false
  },
  {
    typ : "recipe",
    name : "blueprint-book",
    energy_required : 5,
    ingredients :
    {
      {"advanced-circuit", 15}
    },
    result : "blueprint-book",
    enabled : false
  },
  {
    typ : "recipe",
    name : "deconstruction-planner",
    energy_required : 1,
    ingredients :
    {
      {"advanced-circuit", 1}
    },
    result : "deconstruction-planner",
    enabled : false
  },
  {
    typ : "recipe",
    name : "pumpjack",
    energy_required : 20,
    ingredients :
    {
      {"steel-plate", 15},
      {"iron-gear-wheel", 10},
      {"electronic-circuit", 10},
      {"pipe", 10},
    },
    result : "pumpjack",
    enabled : false
  },
  {
    typ : "recipe",
    name : "oil-refinery",
    energy_required : 20,
    ingredients :
    {
      {"steel-plate", 15},
      {"iron-gear-wheel", 10},
      {"stone-brick", 10},
      {"electronic-circuit", 10},
      {"pipe", 10}
    },
    result : "oil-refinery",
    enabled : false
  },
  {
    typ : "recipe",
    name : "engine-unit",
    energy_required : 20,
    category : "advanced-crafting",
    ingredients :
    {
      {"steel-plate", 1},
      {"iron-gear-wheel", 1},
      {"pipe", 2}
    },
    result : "engine-unit",
    enabled : false
  },
  {
    typ : "recipe",
    name : "electric-engine-unit",
    category : "crafting-with-fluid",
    energy_required : 20,
    ingredients :
    {
      {"engine-unit", 1},
      {type:"fluid", name: "lubricant", amount : 2},
      {"electronic-circuit", 2}
    },
    result : "electric-engine-unit",
    enabled : false
  },
  {
    typ : "recipe",
    name : "flying-robot-frame",
    energy_required : 20,
    ingredients :
    {
      {"electric-engine-unit", 1},
      {"battery", 2},
      {"steel-plate", 1},
      {"electronic-circuit", 3}
    },
    result : "flying-robot-frame",
    enabled : false
  },
  {
    typ : "recipe",
    name : "explosives",
    energy_required : 5,
    enabled : false,
    category : "chemistry",
    ingredients :
    {
      {type:"item", name:"sulfur", amount:1},
      {type:"item", name:"coal", amount:1},
      {type:"fluid", name:"water", amount:1},
    },
    result: "explosives"
  },
  {
    typ : "recipe",
    name : "battery",
    category : "chemistry",
    energy_required : 5,
    enabled : false,
    ingredients :
    {
      {type:"fluid", name:"sulfuric-acid", amount:2},
      {"iron-plate", 1},
      {"copper-plate", 1}
    },
    result: "battery"
  },
  {
    typ : "recipe",
    name : "storage-tank",
    energy_required : 3,
    enabled : false,
    ingredients :
    {
      {"iron-plate", 20},
      {"steel-plate", 5}
    },
    result: "storage-tank"
  },
  {
    typ : "recipe",
    name : "small-pump",
    energy_required : 2,
    enabled : false,
    ingredients :
    {
      {"electric-engine-unit", 1},
      {"steel-plate", 1},
      {"pipe", 1}
    },
    result: "small-pump"
  },
  {
    typ : "recipe",
    name : "chemical-plant",
    energy_required : 10,
    enabled : false,
    ingredients :
    {
      {"steel-plate", 5},
      {"iron-gear-wheel", 5},
      {"electronic-circuit", 5},
      {"pipe", 5}
    },
    result: "chemical-plant"
  },
  {
    typ : "recipe",
    name : "small-plane",
    energy_required : 30,
    enabled : false,
    category : "crafting",
    ingredients :
    {
      {"plastic-bar", 100},
      {"advanced-circuit", 200},
      {"electric-engine-unit", 20},
      {"battery", 100}
    },
    result: "small-plane"
  },
  {
    typ : "recipe",
    name : "arithmetic-combinator",
    enabled : "false",
    ingredients :
    {
      {"copper-cable", 5},
      {"electronic-circuit", 5},
    },
    result : "arithmetic-combinator"
  },
  {
    typ : "recipe",
    name : "decider-combinator",
    enabled : "false",
    ingredients :
    {
      {"copper-cable", 5},
      {"electronic-circuit", 5},
    },
    result : "decider-combinator"
  },
  {
    typ : "recipe",
    name : "constant-combinator",
    enabled : "false",
    ingredients :
    {
      {"copper-cable", 5},
      {"electronic-circuit", 2},
    },
    result : "constant-combinator"
  },
  {
    typ : "recipe",
    name : "power-switch",
    enabled : "false",
    energy_required : 2,
    ingredients :
    {
      {"iron-plate", 5},
      {"copper-cable", 5},
      {"electronic-circuit", 2},
    },
    result : "power-switch"
  },
  {
    typ : "recipe",
    name : "low-density-structure",
    energy_required : 30,
    enabled : false,
    category : "crafting",
    ingredients :
    {
      {"steel-plate", 10},
      {"copper-plate", 5},
      {"plastic-bar", 5}
    },
    result: "low-density-structure"
  },
  {
    typ : "recipe",
    name : "rocket-fuel",
    energy_required : 30,
    enabled : false,
    category : "crafting",
    ingredients :
    {
      {"solid-fuel", 10}
    },
    result: "rocket-fuel"
  },
  {
    typ : "recipe",
    name : "rocket-control-unit",
    energy_required : 30,
    enabled : false,
    category : "crafting",
    ingredients :
    {
      {"processing-unit", 1},
      {"speed-module", 1}
    },
    result: "rocket-control-unit"
  },
  {
    typ : "recipe",
    name : "rocket-part",
    energy_required : 3,
    enabled : false,
    hidden : true,
    category : "rocket-building",
    ingredients :
    {
      {"low-density-structure", 10},
      {"rocket-fuel", 10},
      {"rocket-control-unit", 10}
    },
    result: "rocket-part"
  },
  {
    typ : "recipe",
    name : "satellite",
    energy_required : 3,
    enabled : false,
    category : "crafting",
    ingredients :
    {
      {"low-density-structure", 100},
      {"solar-panel", 100},
      {"accumulator", 100},
      {"radar", 5},
      {"processing-unit", 100},
      {"rocket-fuel", 50}
    },
    result: "satellite"
  },
  {
    typ : "recipe",
    name : "concrete",
    energy_required : 10,
    enabled : false,
    category : "crafting-with-fluid",
    ingredients :
    {
      {"stone-brick", 5},
      {"iron-ore", 1},
      {type:"fluid", name:"water", amount:10}
    },
    result: "concrete",
    result_count : 10
  },
  {
    typ : "recipe",
    name : "hazard-concrete",
    energy_required : 0.25,
    enabled : false,
    category : "crafting",
    ingredients :
    {
      {"concrete", 10}
    },
    result: "hazard-concrete",
    result_count : 10
  },
  {
    typ : "recipe",
    name : "landfill",
    energy_required : 0.5,
    enabled : false,
    category : "crafting",
    ingredients :
    {
      {"stone", 20}
    },
    result: "landfill",
    result_count : 1
  },
  {
    typ : "recipe",
    name : "electric-energy-interface",
    energy_required : 0.5,
    enabled : false,
    ingredients :
    {
      {"iron-plate", 2},
      {"electronic-circuit", 5}
    },
    result : "electric-energy-interface"
  }

"""



function readLuaf(fn)
	#JSON.parsefile(filename::AbstractString; dicttype=Dict, use_mmap=true)
	
	print(JSON.parse(recipeLUA))
	close(fid)
	
end

function recipes()
	print(recipeLUA)
	readLuaf("recipe.txt")
end

# staaahhppp
end



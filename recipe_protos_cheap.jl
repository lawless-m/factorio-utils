recipe = Recipe{Assembler}("piercing-rounds-magazine", 3)
@RIN "firearm-magazine" 1
@RIN "steel-plate" 1
@RIN "copper-plate" 5
@ROUT "piercing-rounds-magazine" 1

recipe = Recipe{Assembler}("uranium-rounds-magazine", 10)
@RIN "piercing-rounds-magazine" 1
@RIN "uranium-238" 1
@ROUT "uranium-rounds-magazine" 1

recipe = Recipe{Assembler}("rocket", 8)
@RIN "electronic-circuit" 1
@RIN "explosives" 1
@RIN "iron-plate" 2
@ROUT "rocket" 1

recipe = Recipe{Assembler}("explosive-rocket", 8)
@RIN "rocket" 1
@RIN "explosives" 2
@ROUT "explosive-rocket" 1

recipe = Recipe{Assembler}("atomic-bomb", 50)
@RIN "processing-unit" 20
@RIN "explosives" 10
@RIN "uranium-235" 30
@ROUT "atomic-bomb" 1

recipe = Recipe{Assembler}("shotgun-shell", 3)
@RIN "copper-plate" 2
@RIN "iron-plate" 2
@ROUT "shotgun-shell" 1

recipe = Recipe{Assembler}("piercing-shotgun-shell", 8)
@RIN "shotgun-shell" 2
@RIN "copper-plate" 5
@RIN "steel-plate" 2
@ROUT "piercing-shotgun-shell" 1

recipe = Recipe{Assembler}("railgun-dart", 8)
@RIN "steel-plate" 5
@RIN "electronic-circuit" 5
@ROUT "railgun-dart" 1

recipe = Recipe{Assembler}("cannon-shell", 8)
@RIN "steel-plate" 2
@RIN "plastic-bar" 2
@RIN "explosives" 1
@ROUT "cannon-shell" 1

recipe = Recipe{Assembler}("explosive-cannon-shell", 8)
@RIN "steel-plate" 2
@RIN "plastic-bar" 2
@RIN "explosives" 2
@ROUT "explosive-cannon-shell" 1

recipe = Recipe{Assembler}("uranium-cannon-shell", 12)
@RIN "cannon-shell" 1
@RIN "uranium-238" 1
@ROUT "uranium-cannon-shell" 1

recipe = Recipe{Assembler}("explosive-uranium-cannon-shell", 12)
@RIN "explosive-cannon-shell" 1
@RIN "uranium-238" 1
@ROUT "explosive-uranium-cannon-shell" 1

recipe = Recipe{Assembler}("artillery-shell", 15)
@RIN "explosive-cannon-shell" 4
@RIN "radar" 1
@RIN "explosives" 8
@ROUT "artillery-shell" 1

recipe = Recipe{ChemPlant}("flamethrower-ammo", 6)
@RIN "steel-plate" 5
@RIN "light-oil" 50
@RIN "heavy-oil" 50
@ROUT "flamethrower-ammo" 1

recipe = Recipe{Assembler}("poison-capsule", 8)
@RIN "steel-plate" 3
@RIN "electronic-circuit" 3
@RIN "coal" 10
@ROUT "poison-capsule" 1

recipe = Recipe{Assembler}("slowdown-capsule", 8)
@RIN "steel-plate" 2
@RIN "electronic-circuit" 2
@RIN "coal" 5
@ROUT "slowdown-capsule" 1

recipe = Recipe{Assembler}("grenade", 8)
@RIN "iron-plate" 5
@RIN "coal" 10
@ROUT "grenade" 1

recipe = Recipe{Assembler}("cluster-grenade", 8)
@RIN "grenade" 7
@RIN "explosives" 5
@RIN "steel-plate" 5
@ROUT "cluster-grenade" 1

recipe = Recipe{Assembler}("defender-capsule", 8)
@RIN "piercing-rounds-magazine" 1
@RIN "electronic-circuit" 2
@RIN "iron-gear-wheel" 3
@ROUT "defender-capsule" 1

recipe = Recipe{Assembler}("distractor-capsule", 15)
@RIN "defender-capsule" 4
@RIN "advanced-circuit" 3
@ROUT "distractor-capsule" 1

recipe = Recipe{Assembler}("destroyer-capsule", 15)
@RIN "distractor-capsule" 4
@RIN "speed-module" 1
@ROUT "destroyer-capsule" 1

recipe = Recipe{Assembler}("discharge-defense-remote", 0.5)
@RIN "electronic-circuit" 1
@ROUT "discharge-defense-remote" 1

recipe = Recipe{Assembler}("cliff-explosives", 8)
@RIN "explosives" 10
@RIN "grenade" 1
@RIN "empty-barrel" 1
@ROUT "cliff-explosives" 1

recipe = Recipe{Assembler}("artillery-targeting-remote", 0.5)
@RIN "processing-unit" 1
@RIN "radar" 1
@ROUT "artillery-targeting-remote" 1

recipe = Recipe{Assembler}("night-vision-equipment", 10)
@RIN "advanced-circuit" 5
@RIN "steel-plate" 10
@ROUT "night-vision-equipment" 1

recipe = Recipe{Assembler}("energy-shield-equipment", 10)
@RIN "advanced-circuit" 5
@RIN "steel-plate" 10
@ROUT "energy-shield-equipment" 1

recipe = Recipe{Assembler}("energy-shield-mk2-equipment", 10)
@RIN "energy-shield-equipment" 10
@RIN "processing-unit" 10
@ROUT "energy-shield-mk2-equipment" 1

recipe = Recipe{Assembler}("battery-equipment", 10)
@RIN "battery" 5
@RIN "steel-plate" 10
@ROUT "battery-equipment" 1

recipe = Recipe{Assembler}("battery-mk2-equipment", 10)
@RIN "battery-equipment" 10
@RIN "processing-unit" 20
@ROUT "battery-mk2-equipment" 1

recipe = Recipe{Assembler}("solar-panel-equipment", 10)
@RIN "solar-panel" 5
@RIN "advanced-circuit" 1
@RIN "steel-plate" 5
@ROUT "solar-panel-equipment" 1

recipe = Recipe{Assembler}("fusion-reactor-equipment", 10)
@RIN "processing-unit" 250
@ROUT "fusion-reactor-equipment" 1

recipe = Recipe{Assembler}("personal-laser-defense-equipment", 10)
@RIN "processing-unit" 1
@RIN "steel-plate" 5
@RIN "laser-turret" 5
@ROUT "personal-laser-defense-equipment" 1

recipe = Recipe{Assembler}("discharge-defense-equipment", 10)
@RIN "processing-unit" 5
@RIN "steel-plate" 20
@RIN "laser-turret" 10
@ROUT "discharge-defense-equipment" 1

recipe = Recipe{Assembler}("exoskeleton-equipment", 10)
@RIN "processing-unit" 10
@RIN "electric-engine-unit" 30
@RIN "steel-plate" 20
@ROUT "exoskeleton-equipment" 1

recipe = Recipe{Assembler}("personal-roboport-equipment", 10)
@RIN "advanced-circuit" 10
@RIN "iron-gear-wheel" 40
@RIN "steel-plate" 20
@RIN "battery" 45
@ROUT "personal-roboport-equipment" 1

recipe = Recipe{Assembler}("personal-roboport-mk2-equipment", 20)
@RIN "personal-roboport-equipment" 5
@RIN "processing-unit" 100
@ROUT "personal-roboport-mk2-equipment" 1

recipe = Recipe{OilBasic}("basic-oil-processing", 5)
@RIN "crude-oil" 100
@ROUT "heavy-oil" 30
@ROUT "light-oil" 30
@ROUT "petroleum-gas" 40

recipe = Recipe{OilAdvanced}("advanced-oil-processing", 5)
@RIN "water" 50
@RIN "crude-oil" 100
@ROUT "heavy-oil" 10
@ROUT "light-oil" 45
@ROUT "petroleum-gas" 55

recipe = Recipe{Assembler}("coal-liquefaction", 5)
@RIN "coal" 10
@RIN "heavy-oil" 25
@RIN "steam" 50
@ROUT "heavy-oil" 35
@ROUT "light-oil" 15
@ROUT "petroleum-gas" 20

recipe = Recipe{ChemPlant}("heavy-oil-cracking", 3)
@RIN "water" 30
@RIN "heavy-oil" 40
@ROUT "light-oil" 30

recipe = Recipe{ChemPlant}("light-oil-cracking", 3)
@RIN "water" 30
@RIN "light-oil" 30
@ROUT "petroleum-gas" 20

recipe = Recipe{ChemPlant}("sulfuric-acid", 1)
@RIN "sulfur" 5
@RIN "iron-plate" 1
@RIN "water" 100
@ROUT "sulfuric-acid" 50

recipe = Recipe{ChemPlant}("plastic-bar", 1)
@RIN "petroleum-gas" 20
@RIN "coal" 1
@ROUT "plastic-bar" 2

recipe = Recipe{ChemPlant}("solid-fuel-from-light-oil", 3)
@RIN "light-oil" 10
@ROUT "solid-fuel" 1

recipe = Recipe{ChemPlant}("solid-fuel-from-petroleum-gas", 3)
@RIN "petroleum-gas" 20
@ROUT "solid-fuel" 1

recipe = Recipe{ChemPlant}("solid-fuel-from-heavy-oil", 3)
@RIN "heavy-oil" 20
@ROUT "solid-fuel" 1

recipe = Recipe{ChemPlant}("sulfur", 1)
@RIN "water" 30
@RIN "petroleum-gas" 30
@ROUT "sulfur" 2

recipe = Recipe{ChemPlant}("lubricant", 1)
@RIN "heavy-oil" 10
@ROUT "lubricant" 10

recipe = Recipe{Assembler}("empty-barrel", 1)
@RIN "steel-plate" 1
@ROUT "empty-barrel" 1

recipe = Recipe{Smelter}("steel-plate", 17.5)
@RIN "iron-plate" 5
@ROUT "steel-plate" 1

recipe = Recipe{Assembler}("long-handed-inserter", 0.5)
@RIN "iron-gear-wheel" 1
@RIN "iron-plate" 1
@RIN "inserter" 1
@ROUT "long-handed-inserter" 1

recipe = Recipe{Assembler}("fast-inserter", 0.5)
@RIN "electronic-circuit" 2
@RIN "iron-plate" 2
@RIN "inserter" 1
@ROUT "fast-inserter" 1

recipe = Recipe{Assembler}("filter-inserter", 0.5)
@RIN "fast-inserter" 1
@RIN "electronic-circuit" 4
@ROUT "filter-inserter" 1

recipe = Recipe{Assembler}("stack-inserter", 0.5)
@RIN "iron-gear-wheel" 15
@RIN "electronic-circuit" 15
@RIN "advanced-circuit" 1
@RIN "fast-inserter" 1
@ROUT "stack-inserter" 1

recipe = Recipe{Assembler}("stack-filter-inserter", 0.5)
@RIN "stack-inserter" 1
@RIN "electronic-circuit" 5
@ROUT "stack-filter-inserter" 1

recipe = Recipe{Assembler}("speed-module", 15)
@RIN "advanced-circuit" 5
@RIN "electronic-circuit" 5
@ROUT "speed-module" 1

recipe = Recipe{Assembler}("speed-module-2", 30)
@RIN "speed-module" 4
@RIN "advanced-circuit" 5
@RIN "processing-unit" 5
@ROUT "speed-module-2" 1

recipe = Recipe{Assembler}("speed-module-3", 60)
@RIN "speed-module-2" 5
@RIN "advanced-circuit" 5
@RIN "processing-unit" 5
@ROUT "speed-module-3" 1

recipe = Recipe{Assembler}("productivity-module", 15)
@RIN "advanced-circuit" 5
@RIN "electronic-circuit" 5
@ROUT "productivity-module" 1

recipe = Recipe{Assembler}("productivity-module-2", 30)
@RIN "productivity-module" 4
@RIN "advanced-circuit" 5
@RIN "processing-unit" 5
@ROUT "productivity-module-2" 1

recipe = Recipe{Assembler}("productivity-module-3", 60)
@RIN "productivity-module-2" 5
@RIN "advanced-circuit" 5
@RIN "processing-unit" 5
@ROUT "productivity-module-3" 1

recipe = Recipe{Assembler}("effectivity-module", 15)
@RIN "advanced-circuit" 5
@RIN "electronic-circuit" 5
@ROUT "effectivity-module" 1

recipe = Recipe{Assembler}("effectivity-module-2", 30)
@RIN "effectivity-module" 4
@RIN "advanced-circuit" 5
@RIN "processing-unit" 5
@ROUT "effectivity-module-2" 1

recipe = Recipe{Assembler}("effectivity-module-3", 60)
@RIN "effectivity-module-2" 5
@RIN "advanced-circuit" 5
@RIN "processing-unit" 5
@ROUT "effectivity-module-3" 1

recipe = Recipe{Assembler}("player-port", 0.5)
@RIN "electronic-circuit" 10
@RIN "iron-gear-wheel" 5
@RIN "iron-plate" 1
@ROUT "player-port" 1

recipe = Recipe{Assembler}("fast-transport-belt", 0.5)
@RIN "iron-gear-wheel" 5
@RIN "transport-belt" 1
@ROUT "fast-transport-belt" 1

recipe = Recipe{Assembler}("express-transport-belt", 0.5)
@RIN "iron-gear-wheel" 10
@RIN "fast-transport-belt" 1
@RIN "lubricant" 20
@ROUT "express-transport-belt" 1

recipe = Recipe{Assembler}("solar-panel", 10)
@RIN "steel-plate" 5
@RIN "electronic-circuit" 15
@RIN "copper-plate" 5
@ROUT "solar-panel" 1

recipe = Recipe{Assembler}("assembling-machine-2", 0.5)
@RIN "iron-plate" 9
@RIN "electronic-circuit" 3
@RIN "iron-gear-wheel" 5
@RIN "assembling-machine-1" 1
@ROUT "assembling-machine-2" 1

recipe = Recipe{Assembler}("assembling-machine-3", 0.5)
@RIN "speed-module" 4
@RIN "assembling-machine-2" 2
@ROUT "assembling-machine-3" 1

recipe = Recipe{Assembler}("car", 2)
@RIN "engine-unit" 8
@RIN "iron-plate" 20
@RIN "steel-plate" 5
@ROUT "car" 1

recipe = Recipe{Assembler}("tank", 5)
@RIN "engine-unit" 32
@RIN "steel-plate" 50
@RIN "iron-gear-wheel" 15
@RIN "advanced-circuit" 10
@ROUT "tank" 1

recipe = Recipe{Assembler}("rail", 0.5)
@RIN "stone" 1
@RIN "iron-stick" 1
@RIN "steel-plate" 1
@ROUT "rail" 2

recipe = Recipe{Assembler}("locomotive", 4)
@RIN "engine-unit" 20
@RIN "electronic-circuit" 10
@RIN "steel-plate" 30
@ROUT "locomotive" 1

recipe = Recipe{Assembler}("cargo-wagon", 1)
@RIN "iron-gear-wheel" 10
@RIN "iron-plate" 20
@RIN "steel-plate" 20
@ROUT "cargo-wagon" 1

recipe = Recipe{Assembler}("fluid-wagon", 1.5)
@RIN "iron-gear-wheel" 10
@RIN "steel-plate" 16
@RIN "pipe" 8
@RIN "storage-tank" 1
@ROUT "fluid-wagon" 1

recipe = Recipe{Assembler}("artillery-wagon", 4)
@RIN "engine-unit" 64
@RIN "iron-gear-wheel" 10
@RIN "steel-plate" 40
@RIN "pipe" 16
@RIN "advanced-circuit" 20
@ROUT "artillery-wagon" 1

recipe = Recipe{Assembler}("train-stop", 0.5)
@RIN "electronic-circuit" 5
@RIN "iron-plate" 10
@RIN "steel-plate" 3
@ROUT "train-stop" 1

recipe = Recipe{Assembler}("rail-signal", 0.5)
@RIN "electronic-circuit" 1
@RIN "iron-plate" 5
@ROUT "rail-signal" 1

recipe = Recipe{Assembler}("rail-chain-signal", 0.5)
@RIN "electronic-circuit" 1
@RIN "iron-plate" 5
@ROUT "rail-chain-signal" 1

recipe = Recipe{Assembler}("heavy-armor", 8)
@RIN "copper-plate" 100
@RIN "steel-plate" 50
@ROUT "heavy-armor" 1

recipe = Recipe{Assembler}("modular-armor", 15)
@RIN "advanced-circuit" 30
@RIN "steel-plate" 50
@ROUT "modular-armor" 1

recipe = Recipe{Assembler}("power-armor", 20)
@RIN "processing-unit" 40
@RIN "electric-engine-unit" 20
@RIN "steel-plate" 40
@ROUT "power-armor" 1

recipe = Recipe{Assembler}("power-armor-mk2", 25)
@RIN "effectivity-module-3" 5
@RIN "speed-module-3" 5
@RIN "processing-unit" 40
@RIN "steel-plate" 40
@ROUT "power-armor-mk2" 1

recipe = Recipe{Assembler}("iron-chest", 0.5)
@RIN "iron-plate" 8
@ROUT "iron-chest" 1

recipe = Recipe{Assembler}("steel-chest", 0.5)
@RIN "steel-plate" 8
@ROUT "steel-chest" 1

recipe = Recipe{Assembler}("stone-wall", 0.5)
@RIN "stone-brick" 5
@ROUT "stone-wall" 1

recipe = Recipe{Assembler}("gate", 0.5)
@RIN "stone-wall" 1
@RIN "steel-plate" 2
@RIN "electronic-circuit" 2
@ROUT "gate" 1

recipe = Recipe{Assembler}("flamethrower", 10)
@RIN "steel-plate" 5
@RIN "iron-gear-wheel" 10
@ROUT "flamethrower" 1

recipe = Recipe{Assembler}("land-mine", 5)
@RIN "steel-plate" 1
@RIN "explosives" 2
@ROUT "land-mine" 4

recipe = Recipe{Assembler}("rocket-launcher", 10)
@RIN "iron-plate" 5
@RIN "iron-gear-wheel" 5
@RIN "electronic-circuit" 5
@ROUT "rocket-launcher" 1

recipe = Recipe{Assembler}("shotgun", 10)
@RIN "iron-plate" 15
@RIN "iron-gear-wheel" 5
@RIN "copper-plate" 10
@RIN "wood" 5
@ROUT "shotgun" 1

recipe = Recipe{Assembler}("combat-shotgun", 10)
@RIN "steel-plate" 15
@RIN "iron-gear-wheel" 5
@RIN "copper-plate" 10
@RIN "wood" 10
@ROUT "combat-shotgun" 1

recipe = Recipe{Assembler}("railgun", 8)
@RIN "steel-plate" 15
@RIN "copper-plate" 15
@RIN "electronic-circuit" 10
@RIN "advanced-circuit" 5
@ROUT "railgun" 1

recipe = Recipe{Assembler}("science-pack-1", 5)
@RIN "copper-plate" 1
@RIN "iron-gear-wheel" 1
@ROUT "science-pack-1" 1

recipe = Recipe{Assembler}("science-pack-2", 6)
@RIN "inserter" 1
@RIN "transport-belt" 1
@ROUT "science-pack-2" 1

recipe = Recipe{Assembler}("science-pack-3", 12)
@RIN "advanced-circuit" 1
@RIN "engine-unit" 1
@RIN "electric-mining-drill" 1
@ROUT "science-pack-3" 1

recipe = Recipe{Assembler}("military-science-pack", 10)
@RIN "piercing-rounds-magazine" 1
@RIN "grenade" 1
@RIN "gun-turret" 1
@ROUT "military-science-pack" 2

recipe = Recipe{Assembler}("production-science-pack", 14)
@RIN "electric-engine-unit" 1
@RIN "electric-furnace" 1
@ROUT "production-science-pack" 2

recipe = Recipe{Assembler}("high-tech-science-pack", 14)
@RIN "battery" 1
@RIN "processing-unit" 3
@RIN "speed-module" 1
@RIN "copper-cable" 30
@ROUT "high-tech-science-pack" 2

recipe = Recipe{Assembler}("lab", 2)
@RIN "electronic-circuit" 10
@RIN "iron-gear-wheel" 10
@RIN "transport-belt" 4
@ROUT "lab" 1

recipe = Recipe{Assembler}("red-wire", 0.5)
@RIN "electronic-circuit" 1
@RIN "copper-cable" 1
@ROUT "red-wire" 1

recipe = Recipe{Assembler}("green-wire", 0.5)
@RIN "electronic-circuit" 1
@RIN "copper-cable" 1
@ROUT "green-wire" 1

recipe = Recipe{Assembler}("underground-belt", 1)
@RIN "iron-plate" 10
@RIN "transport-belt" 5
@ROUT "underground-belt" 2

recipe = Recipe{Assembler}("fast-underground-belt", 2)
@RIN "iron-gear-wheel" 40
@RIN "underground-belt" 2
@ROUT "fast-underground-belt" 2

recipe = Recipe{Assembler}("express-underground-belt", 2)
@RIN "iron-gear-wheel" 80
@RIN "fast-underground-belt" 2
@RIN "lubricant" 40
@ROUT "express-underground-belt" 2

recipe = Recipe{Assembler}("loader", 1)
@RIN "inserter" 5
@RIN "electronic-circuit" 5
@RIN "iron-gear-wheel" 5
@RIN "iron-plate" 5
@RIN "transport-belt" 5
@ROUT "loader" 1

recipe = Recipe{Assembler}("fast-loader", 3)
@RIN "fast-transport-belt" 5
@RIN "loader" 1
@ROUT "fast-loader" 1

recipe = Recipe{Assembler}("express-loader", 10)
@RIN "express-transport-belt" 5
@RIN "fast-loader" 1
@ROUT "express-loader" 1

recipe = Recipe{Assembler}("splitter", 1)
@RIN "electronic-circuit" 5
@RIN "iron-plate" 5
@RIN "transport-belt" 4
@ROUT "splitter" 1

recipe = Recipe{Assembler}("fast-splitter", 2)
@RIN "splitter" 1
@RIN "iron-gear-wheel" 10
@RIN "electronic-circuit" 10
@ROUT "fast-splitter" 1

recipe = Recipe{Assembler}("express-splitter", 2)
@RIN "fast-splitter" 1
@RIN "iron-gear-wheel" 10
@RIN "advanced-circuit" 10
@RIN "lubricant" 80
@ROUT "express-splitter" 1

recipe = Recipe{Assembler}("advanced-circuit", 6)
@RIN "electronic-circuit" 2
@RIN "plastic-bar" 2
@RIN "copper-cable" 4
@ROUT "advanced-circuit" 1

recipe = Recipe{Assembler}("processing-unit", 10)
@RIN "electronic-circuit" 20
@RIN "advanced-circuit" 2
@RIN "sulfuric-acid" 5
@ROUT "processing-unit" 1

recipe = Recipe{Assembler}("logistic-robot", 0.5)
@RIN "flying-robot-frame" 1
@RIN "advanced-circuit" 2
@ROUT "logistic-robot" 1

recipe = Recipe{Assembler}("construction-robot", 0.5)
@RIN "flying-robot-frame" 1
@RIN "electronic-circuit" 2
@ROUT "construction-robot" 1

recipe = Recipe{Assembler}("logistic-chest-passive-provider", 0.5)
@RIN "steel-chest" 1
@RIN "electronic-circuit" 3
@RIN "advanced-circuit" 1
@ROUT "logistic-chest-passive-provider" 1

recipe = Recipe{Assembler}("logistic-chest-active-provider", 0.5)
@RIN "steel-chest" 1
@RIN "electronic-circuit" 3
@RIN "advanced-circuit" 1
@ROUT "logistic-chest-active-provider" 1

recipe = Recipe{Assembler}("logistic-chest-storage", 0.5)
@RIN "steel-chest" 1
@RIN "electronic-circuit" 3
@RIN "advanced-circuit" 1
@ROUT "logistic-chest-storage" 1

recipe = Recipe{Assembler}("logistic-chest-buffer", 0.5)
@RIN "steel-chest" 1
@RIN "electronic-circuit" 3
@RIN "advanced-circuit" 1
@ROUT "logistic-chest-buffer" 1

recipe = Recipe{Assembler}("logistic-chest-requester", 0.5)
@RIN "steel-chest" 1
@RIN "electronic-circuit" 3
@RIN "advanced-circuit" 1
@ROUT "logistic-chest-requester" 1

recipe = Recipe{Assembler}("rocket-silo", 30)
@RIN "steel-plate" 1000
@RIN "concrete" 1000
@RIN "pipe" 100
@RIN "processing-unit" 200
@RIN "electric-engine-unit" 200
@ROUT "rocket-silo" 1

recipe = Recipe{Assembler}("roboport", 5)
@RIN "steel-plate" 45
@RIN "iron-gear-wheel" 45
@RIN "advanced-circuit" 45
@ROUT "roboport" 1

recipe = Recipe{Assembler}("steel-axe", 0.5)
@RIN "steel-plate" 5
@RIN "iron-stick" 2
@ROUT "steel-axe" 1

recipe = Recipe{Assembler}("big-electric-pole", 0.5)
@RIN "steel-plate" 5
@RIN "copper-plate" 5
@ROUT "big-electric-pole" 1

recipe = Recipe{Assembler}("substation", 0.5)
@RIN "steel-plate" 10
@RIN "advanced-circuit" 5
@RIN "copper-plate" 5
@ROUT "substation" 1

recipe = Recipe{Assembler}("medium-electric-pole", 0.5)
@RIN "steel-plate" 2
@RIN "copper-plate" 2
@ROUT "medium-electric-pole" 1

recipe = Recipe{Assembler}("accumulator", 10)
@RIN "iron-plate" 2
@RIN "battery" 5
@ROUT "accumulator" 1

recipe = Recipe{Assembler}("steel-furnace", 3)
@RIN "steel-plate" 6
@RIN "stone-brick" 10
@ROUT "steel-furnace" 1

recipe = Recipe{Assembler}("electric-furnace", 5)
@RIN "steel-plate" 10
@RIN "advanced-circuit" 5
@RIN "stone-brick" 10
@ROUT "electric-furnace" 1

recipe = Recipe{Assembler}("beacon", 15)
@RIN "electronic-circuit" 20
@RIN "advanced-circuit" 20
@RIN "steel-plate" 10
@RIN "copper-cable" 10
@ROUT "beacon" 1

recipe = Recipe{Assembler}("pumpjack", 5)
@RIN "steel-plate" 5
@RIN "iron-gear-wheel" 10
@RIN "electronic-circuit" 5
@RIN "pipe" 10
@ROUT "pumpjack" 1

recipe = Recipe{Assembler}("oil-refinery", 8)
@RIN "steel-plate" 15
@RIN "iron-gear-wheel" 10
@RIN "stone-brick" 10
@RIN "electronic-circuit" 10
@RIN "pipe" 10
@ROUT "oil-refinery" 1

recipe = Recipe{Assembler}("engine-unit", 10)
@RIN "steel-plate" 1
@RIN "iron-gear-wheel" 1
@RIN "pipe" 2
@ROUT "engine-unit" 1

recipe = Recipe{Assembler}("electric-engine-unit", 10)
@RIN "engine-unit" 1
@RIN "lubricant" 15
@RIN "electronic-circuit" 2
@ROUT "electric-engine-unit" 1

recipe = Recipe{Assembler}("flying-robot-frame", 20)
@RIN "electric-engine-unit" 1
@RIN "battery" 2
@RIN "steel-plate" 1
@RIN "electronic-circuit" 3
@ROUT "flying-robot-frame" 1

recipe = Recipe{ChemPlant}("explosives", 5)
@RIN "sulfur" 1
@RIN "coal" 1
@RIN "water" 10
@ROUT "explosives" 1

recipe = Recipe{ChemPlant}("battery", 5)
@RIN "sulfuric-acid" 20
@RIN "iron-plate" 1
@RIN "copper-plate" 1
@ROUT "battery" 1

recipe = Recipe{Assembler}("storage-tank", 3)
@RIN "iron-plate" 20
@RIN "steel-plate" 5
@ROUT "storage-tank" 1

recipe = Recipe{Assembler}("pump", 2)
@RIN "engine-unit" 1
@RIN "steel-plate" 1
@RIN "pipe" 1
@ROUT "pump" 1

recipe = Recipe{Assembler}("chemical-plant", 5)
@RIN "steel-plate" 5
@RIN "iron-gear-wheel" 5
@RIN "electronic-circuit" 5
@RIN "pipe" 5
@ROUT "chemical-plant" 1

recipe = Recipe{Assembler}("small-plane", 30)
@RIN "plastic-bar" 100
@RIN "advanced-circuit" 200
@RIN "electric-engine-unit" 20
@RIN "battery" 100
@ROUT "small-plane" 1

recipe = Recipe{Assembler}("arithmetic-combinator", 0.5)
@RIN "copper-cable" 5
@RIN "electronic-circuit" 5
@ROUT "arithmetic-combinator" 1

recipe = Recipe{Assembler}("decider-combinator", 0.5)
@RIN "copper-cable" 5
@RIN "electronic-circuit" 5
@ROUT "decider-combinator" 1

recipe = Recipe{Assembler}("constant-combinator", 0.5)
@RIN "copper-cable" 5
@RIN "electronic-circuit" 2
@ROUT "constant-combinator" 1

recipe = Recipe{Assembler}("power-switch", 2)
@RIN "iron-plate" 5
@RIN "copper-cable" 5
@RIN "electronic-circuit" 2
@ROUT "power-switch" 1

recipe = Recipe{Assembler}("programmable-speaker", 2)
@RIN "iron-plate" 5
@RIN "copper-cable" 5
@RIN "electronic-circuit" 4
@ROUT "programmable-speaker" 1

recipe = Recipe{Assembler}("low-density-structure", 30)
@RIN "steel-plate" 10
@RIN "copper-plate" 5
@RIN "plastic-bar" 5
@ROUT "low-density-structure" 1

recipe = Recipe{Assembler}("rocket-fuel", 30)
@RIN "solid-fuel" 10
@ROUT "rocket-fuel" 1

recipe = Recipe{Assembler}("rocket-control-unit", 30)
@RIN "processing-unit" 1
@RIN "speed-module" 1
@ROUT "rocket-control-unit" 1

recipe = Recipe{Assembler}("rocket-part", 3)
@RIN "rocket-control-unit" 10
@RIN "low-density-structure" 10
@RIN "rocket-fuel" 10
@ROUT "rocket-part" 1

recipe = Recipe{Assembler}("satellite", 5)
@RIN "low-density-structure" 100
@RIN "solar-panel" 100
@RIN "accumulator" 100
@RIN "radar" 5
@RIN "processing-unit" 100
@RIN "rocket-fuel" 50
@ROUT "satellite" 1

recipe = Recipe{Assembler}("concrete", 10)
@RIN "stone-brick" 5
@RIN "iron-ore" 1
@RIN "water" 100
@ROUT "concrete" 10

recipe = Recipe{Assembler}("hazard-concrete", 0.25)
@RIN "concrete" 10
@ROUT "hazard-concrete" 10

recipe = Recipe{Assembler}("refined-concrete", 15)
@RIN "concrete" 20
@RIN "iron-stick" 8
@RIN "steel-plate" 1
@RIN "water" 100
@ROUT "refined-concrete" 10

recipe = Recipe{Assembler}("refined-hazard-concrete", 0.25)
@RIN "refined-concrete" 10
@ROUT "refined-hazard-concrete" 10

recipe = Recipe{Assembler}("landfill", 0.5)
@RIN "stone" 20
@ROUT "landfill" 1

recipe = Recipe{Assembler}("electric-energy-interface", 0.5)
@RIN "iron-plate" 2
@RIN "electronic-circuit" 5
@ROUT "electric-energy-interface" 1

recipe = Recipe{Assembler}("nuclear-reactor", 8)
@RIN "concrete" 500
@RIN "steel-plate" 500
@RIN "advanced-circuit" 500
@RIN "copper-plate" 500
@ROUT "nuclear-reactor" 1

recipe = Recipe{Assembler}("centrifuge", 4)
@RIN "concrete" 100
@RIN "steel-plate" 50
@RIN "advanced-circuit" 100
@RIN "iron-gear-wheel" 100
@ROUT "centrifuge" 1

recipe = Recipe{Centrifuge}("uranium-processing", 10)
@RIN "uranium-ore" 10
@ROUT "uranium-235" 0.007
@ROUT "uranium-238" 0.993

recipe = Recipe{Centrifuge}("kovarex-enrichment-process", 50)
@RIN "uranium-235" 40
@RIN "uranium-238" 5
@ROUT "uranium-235" 41
@ROUT "uranium-238" 2

recipe = Recipe{Centrifuge}("nuclear-fuel", 60)
@RIN "uranium-235" 1
@RIN "rocket-fuel" 1
@ROUT "nuclear-fuel" 1

recipe = Recipe{Centrifuge}("nuclear-fuel-reprocessing", 50)
@RIN "used-up-uranium-fuel-cell" 5
@ROUT "uranium-238" 3

recipe = Recipe{Assembler}("uranium-fuel-cell", 10)
@RIN "iron-plate" 10
@RIN "uranium-235" 1
@RIN "uranium-238" 19
@ROUT "uranium-fuel-cell" 10

recipe = Recipe{Assembler}("heat-exchanger", 3)
@RIN "steel-plate" 10
@RIN "copper-plate" 100
@RIN "pipe" 10
@ROUT "heat-exchanger" 1

recipe = Recipe{Assembler}("heat-pipe", 1)
@RIN "steel-plate" 10
@RIN "copper-plate" 20
@ROUT "heat-pipe" 1

recipe = Recipe{Assembler}("steam-turbine", 3)
@RIN "iron-gear-wheel" 50
@RIN "copper-plate" 50
@RIN "pipe" 20
@ROUT "steam-turbine" 1

recipe = Recipe{Assembler}("laser-turret", 20)
@RIN "steel-plate" 20
@RIN "electronic-circuit" 20
@RIN "battery" 12
@ROUT "laser-turret" 1

recipe = Recipe{Assembler}("flamethrower-turret", 20)
@RIN "steel-plate" 30
@RIN "iron-gear-wheel" 15
@RIN "pipe" 10
@RIN "engine-unit" 5
@ROUT "flamethrower-turret" 1

recipe = Recipe{Assembler}("artillery-turret", 40)
@RIN "steel-plate" 60
@RIN "concrete" 60
@RIN "iron-gear-wheel" 40
@RIN "advanced-circuit" 20
@ROUT "artillery-turret" 1

recipe = Recipe{Assembler}("wood", 0.5)
@RIN "raw-wood" 1
@ROUT "wood" 2

recipe = Recipe{Assembler}("wooden-chest", 0.5)
@RIN "wood" 4
@ROUT "wooden-chest" 1

recipe = Recipe{Assembler}("iron-stick", 0.5)
@RIN "iron-plate" 1
@ROUT "iron-stick" 2

recipe = Recipe{Assembler}("iron-axe", 0.5)
@RIN "iron-stick" 2
@RIN "iron-plate" 3
@ROUT "iron-axe" 1

recipe = Recipe{Assembler}("stone-furnace", 0.5)
@RIN "stone" 5
@ROUT "stone-furnace" 1

recipe = Recipe{Assembler}("boiler", 0.5)
@RIN "stone-furnace" 1
@RIN "pipe" 4
@ROUT "boiler" 1

recipe = Recipe{Assembler}("steam-engine", 0.5)
@RIN "iron-gear-wheel" 8
@RIN "pipe" 5
@RIN "iron-plate" 10
@ROUT "steam-engine" 1

recipe = Recipe{Assembler}("iron-gear-wheel", 0.5)
@RIN "iron-plate" 2
@ROUT "iron-gear-wheel" 1

recipe = Recipe{Assembler}("electronic-circuit", 0.5)
@RIN "iron-plate" 1
@RIN "copper-cable" 3
@ROUT "electronic-circuit" 1

recipe = Recipe{Assembler}("transport-belt", 0.5)
@RIN "iron-plate" 1
@RIN "iron-gear-wheel" 1
@ROUT "transport-belt" 2

recipe = Recipe{Assembler}("electric-mining-drill", 2)
@RIN "electronic-circuit" 3
@RIN "iron-gear-wheel" 5
@RIN "iron-plate" 10
@ROUT "electric-mining-drill" 1

recipe = Recipe{Assembler}("burner-mining-drill", 2)
@RIN "iron-gear-wheel" 3
@RIN "stone-furnace" 1
@RIN "iron-plate" 3
@ROUT "burner-mining-drill" 1

recipe = Recipe{Assembler}("inserter", 0.5)
@RIN "electronic-circuit" 1
@RIN "iron-gear-wheel" 1
@RIN "iron-plate" 1
@ROUT "inserter" 1

recipe = Recipe{Assembler}("burner-inserter", 0.5)
@RIN "iron-plate" 1
@RIN "iron-gear-wheel" 1
@ROUT "burner-inserter" 1

recipe = Recipe{Assembler}("pipe", 0.5)
@RIN "iron-plate" 1
@ROUT "pipe" 1

recipe = Recipe{Assembler}("offshore-pump", 0.5)
@RIN "electronic-circuit" 2
@RIN "pipe" 1
@RIN "iron-gear-wheel" 1
@ROUT "offshore-pump" 1

recipe = Recipe{Assembler}("copper-cable", 0.5)
@RIN "copper-plate" 1
@ROUT "copper-cable" 2

recipe = Recipe{Assembler}("small-electric-pole", 0.5)
@RIN "wood" 2
@RIN "copper-cable" 2
@ROUT "small-electric-pole" 2

recipe = Recipe{Assembler}("pistol", 5)
@RIN "copper-plate" 5
@RIN "iron-plate" 5
@ROUT "pistol" 1

recipe = Recipe{Assembler}("submachine-gun", 10)
@RIN "iron-gear-wheel" 10
@RIN "copper-plate" 5
@RIN "iron-plate" 10
@ROUT "submachine-gun" 1

recipe = Recipe{Assembler}("firearm-magazine", 1)
@RIN "iron-plate" 4
@ROUT "firearm-magazine" 1

recipe = Recipe{Assembler}("light-armor", 3)
@RIN "iron-plate" 40
@ROUT "light-armor" 1

recipe = Recipe{Assembler}("radar", 0.5)
@RIN "electronic-circuit" 5
@RIN "iron-gear-wheel" 5
@RIN "iron-plate" 10
@ROUT "radar" 1

recipe = Recipe{Assembler}("small-lamp", 0.5)
@RIN "electronic-circuit" 1
@RIN "iron-stick" 3
@RIN "iron-plate" 1
@ROUT "small-lamp" 1

recipe = Recipe{Assembler}("pipe-to-ground", 0.5)
@RIN "pipe" 10
@RIN "iron-plate" 5
@ROUT "pipe-to-ground" 2

recipe = Recipe{Assembler}("assembling-machine-1", 0.5)
@RIN "electronic-circuit" 3
@RIN "iron-gear-wheel" 5
@RIN "iron-plate" 9
@ROUT "assembling-machine-1" 1

recipe = Recipe{Assembler}("repair-pack", 0.5)
@RIN "electronic-circuit" 2
@RIN "iron-gear-wheel" 2
@ROUT "repair-pack" 1

recipe = Recipe{Smelter}("copper-plate", 3.5)
@RIN "copper-ore" 1
@ROUT "copper-plate" 1

recipe = Recipe{Smelter}("iron-plate", 3.5)
@RIN "iron-ore" 1
@ROUT "iron-plate" 1

recipe = Recipe{Smelter}("stone-brick", 3.5)
@RIN "stone" 2
@ROUT "stone-brick" 1


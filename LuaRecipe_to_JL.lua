#!/usr/bin/lua5.3

recipfns = {
  "/home/matt/factorio/data/base/prototypes/recipe/ammo.lua",
  "/home/matt/factorio/data/base/prototypes/recipe/capsule.lua", 
  "/home/matt/factorio/data/base/prototypes/recipe/equipment.lua", 
  "/home/matt/factorio/data/base/prototypes/recipe/fluid-recipe.lua",
  "/home/matt/factorio/data/base/prototypes/recipe/furnace-recipe.lua", 
  "/home/matt/factorio/data/base/prototypes/recipe/inserter.lua",
  "/home/matt/factorio/data/base/prototypes/recipe/module.lua",
  "/home/matt/factorio/data/base/prototypes/recipe/recipe.lua", 
  "/home/matt/factorio/data/base/prototypes/recipe/turret.lua",
  "/home/matt/factorio/data/base/prototypes/recipe/demo-recipe.lua",
  "/home/matt/factorio/data/base/prototypes/recipe/demo-furnace-recipe.lua"
}


function wrt(fid, n, f, t, bits, res, rescnt)
	fid:write("recipe = Recipe{" .. f .. "}(\"" .. n .. "\", ".. tostring(t) .. ")\n")
	for i = 1, #bits do
		printIngs(fid, "@RIN", bits[i])
	end
	if type(res) == "table" then
		for i = 1, #res do
			printIngs(fid, "@ROUT", res[i])
		end
	else
		if rescnt ~= nil then
			a = tostring(rescnt)
		else
			a = "1"
		end
		fid:write("@ROUT \"" .. res .. "\" " .. a .. "\n")
	end

end

data = {}
data["cheap"] = io.open("recipe_protos_cheap.jl", "w+")
data["expensive"] = io.open("recipe_protos_expensive.jl", "w+")
data["extend"] = function(data, recips)
	for r = 1,#recips do
		if recips[r]["type"] == "recipe" then

			if recips[r]["name"] == "basic-oil-processing" then
				f = "OilBasic"
			elseif recips[r]["name"] == "advanced-oil-processing" then
				f = "OilAdvanced"
			elseif recips[r]["category"] == "chemistry" then
				f = "ChemPlant"
			elseif recips[r]["category"] == "smelting" then
				f = "Smelter"
			elseif recips[r]["category"] == "centrifuging" then
				f = "Centrifuge"
			else
				f = "Assembler"
			end

			print(recips[r]["name"] )

			if recips[r]["ingredients"] == nil then
				t = recips[r]["normal"]["energy_required"]
				if t == nil then
					t = 0.5
				end
				wrt(data["cheap"], recips[r]["name"], f, t, recips[r]["normal"]["ingredients"], recips[r]["normal"]["results"] or recips[r]["normal"]["result"], recips[r]["result_count"])

				t = recips[r]["expensive"]["energy_required"]
				if t == nil then
					t = 0.5
				end
				wrt(data["expensive"], recips[r]["name"], f, t, recips[r]["expensive"]["ingredients"], recips[r]["expensive"]["results"] or recips[r]["expensive"]["result"], recips[r]["result_count"])


			else
				t = recips[r]["energy_required"]
				if t == nil then
					t = 0.5
				end
				wrt(data["cheap"], recips[r]["name"], f, t, recips[r]["ingredients"], recips[r]["results"] or recips[r]["result"], recips[r]["result_count"])
				wrt(data["expensive"], recips[r]["name"], f, t, recips[r]["ingredients"], recips[r]["results"] or recips[r]["result"], recips[r]["result_count"])

			end

			data["cheap"]:write("\n")
			data["expensive"]:write("\n")
		end
	end
end



function printIngs(fid, dir, igs)
	if igs["type"] == "fluid" or igs["type"] == "item" then
		k = igs["name"]
		a = igs["amount"]
	elseif igs["probability"] == nil then
		k = igs[1]
		a = igs[2]
		if k == nil then
			k = igs["name"]
			a = igs["amount"]
		end
	else
		k = igs["name"]
		a = igs["probability"] * igs["amount"]
	end
	fid:write(dir .. " \"" .. k .. "\" " .. tostring(a) .. "\n")
end

function writeRecips()

	for fn = 1,#recipfns do
		print(recipfns[fn])
		f = loadfile(recipfns[fn])
		f()
	end
end

writeRecips()


--[[
recipe = Recipe{Assembler}("Blue Circuit", 15)
@RIN "Green Circuit" 20
@RIN "Red Circuit" 2
@RIN "Sulphuric Acid" 0.5
@ROUT "Blue Circuit" 1
]]--





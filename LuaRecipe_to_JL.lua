
recipfns = {
  "C:\\Users\\mwheath\\Documents\\Factorio\\prototypes\\recipe\\ammo.lua",
  "C:\\Users\\mwheath\\Documents\\Factorio\\prototypes\\recipe\\capsule.lua", 
  "C:\\Users\\mwheath\\Documents\\Factorio\\prototypes\\recipe\\equipment.lua", 
  "C:\\Users\\mwheath\\Documents\\Factorio\\prototypes\\recipe\\fluid-recipe.lua",
  "C:\\Users\\mwheath\\Documents\\Factorio\\prototypes\\recipe\\furnace-recipe.lua", 
  "C:\\Users\\mwheath\\Documents\\Factorio\\prototypes\\recipe\\inserter.lua",
  "C:\\Users\\mwheath\\Documents\\Factorio\\prototypes\\recipe\\module.lua",
  "C:\\Users\\mwheath\\Documents\\Factorio\\prototypes\\recipe\\recipe.lua", 
  "C:\\Users\\mwheath\\Documents\\Factorio\\prototypes\\recipe\\turret.lua",
}


function getrecips(fn)
	fid = io.open(fn)
	
	loader = function()
		txt = fid:read()
		if txt == "data:extend(" then
			txt = "return "
		elseif txt == ")" then
			txt = nil
		elseif txt == "})" then
			txt = "}"
		elseif txt == "" then
			txt = loader()
		end
		return txt
	end

	f = load(loader)
	fid:close()
	return f()
end

function printIngs(dir, igs)
	if igs["type"] == "fluid" or igs["type"] == "item" then
		k = igs["name"]
		a = igs["amount"]
	else
		k = igs[1]
		a = igs[2]			
	end
	print(dir .. " \"" .. k .. "\" " .. tostring(a))
end

for fn = 1,#recipfns do
	
	recips = getrecips(recipfns[fn])
	if recips == nil then
		print("nil from " .. recipfns[fn])
	else
		for r = 1,#recips do
			if recips[r]["type"] == "recipe" then
				t = recips[r]["energy_required"]
				if t == nil then
					t = 0.5
				end
				if recips[r]["name"] == "basic-oil-processing" then
					f = "OilBasic"
				elseif recips[r]["name"] == "advanced-oil-processing" then
					f = "OilAdvanced"
				elseif recips[r]["category"] == "chemistry" then
					f = "ChemPlant"
				else
					f = "Assembler"
				end
				
				print("recipe = Recipe{" .. f .. "}(\"" .. recips[r]["name"] .. "\", ".. tostring(t) .. ")")
				
				
				for i = 1, #recips[r]["ingredients"] do
					printIngs("@RIN", recips[r]["ingredients"][i])
				end
				
				res = recips[r]["results"] or recips[r]["result"]
				
				if type(res) == "table" then
					for i = 1, #res do
						printIngs("@ROUT", res[i])
					end
				else
					print("@ROUT \"" .. res .. "\" 1")
				end
				
				print("")
			end
		end
	end
end

--[[
recipe = Recipe{Assembler}("Blue Circuit", 15)
@RIN "Green Circuit" 20
@RIN "Red Circuit" 2
@RIN "Sulphuric Acid" 0.5
@ROUT "Blue Circuit" 1
]]--





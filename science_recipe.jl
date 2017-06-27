
Recipes = Dict{AbstractString, Recipe}()

macro IN(iname, iqty)
	:(r.ins[$iname] = $iqty / r.time)
end

macro OUT(iname, iqty)
	:(r.outs[$iname] = $iqty / r.time)
end

macro FOUTS(K) :(sum([@FOUT(F, $K) for F in @Recipes])) end
macro FINS(K) :(sum([@FIN(F, $K) for F in @Recipes])) end

macro FCON(R, I) :(getvalue(Factories[$R]) * get(Recipes[$R].ins, $I, 0)) end 
macro FCONS(K) :(sum([@FCON(F, $K) for F in @Recipes])) end 



macro Recipes() :(collect(keys(Recipes))) end
macro FIN(F, R) :(Factories[$F] * get(Recipes[$F].ins, $R, 0)) end
macro FOUT(F, R) :(Factories[$F] * get(Recipes[$F].outs, $R, 0))end
macro FOUTS(K) :(sum([@FOUT(F, $K) for F in @Recipes])) end
macro FINS(K) :(sum([@FIN(F, $K) for F in @Recipes])) end

macro minsec(n) :((60($n), ($n), 60 * $n * mins)) end
macro PerSec(R)	
	return quote
		r = get(Recipes, $R, nothing)
		if r == nothing
			1
		else
			1 / Recipes[$R].time
		end
	end
end


r = Recipes["high-tech-science-pack"] = Recipe(14, 5.5)
@IN "battery" 1
@IN "processing-unit" 3
@IN "speed-module" 1
@IN "copper-cable" 30
@OUT "high-tech-science-pack" 2.8

r = Recipes["battery"] = Recipe(5, 2.5)
@IN "sulfuric-acid" 20
@IN "iron-plate" 1
@IN "copper-plate" 1
@OUT "battery" 1.2

r = Recipes["processing-unit"] = Recipe(10, 5.5)
@IN "electronic-circuit" 20
@IN "advanced-circuit" 2
@IN "sulfuric-acid" 5
@OUT "processing-unit" 1.4

r = Recipes["advanced-circuit"] = Recipe(6, 5.5)
@IN "electronic-circuit" 2
@IN "plastic-bar" 2
@IN "copper-cable" 4
@OUT "advanced-circuit" 1.4

r = Recipes["electronic-circuit"] = Recipe(0.5, 5.5)
@IN "iron-plate" 1
@IN "copper-cable" 3
@OUT "electronic-circuit" 1.4
	  
r = Recipes["speed-module"] = Recipe(15, 8.75)
@IN "advanced-circuit" 5
@IN "electronic-circuit" 5
@OUT "speed-module" 1

r = Recipes["copper-cable"] = Recipe(0.5, 5.5)
@IN "copper-plate" 1
@OUT "copper-cable" 2.8

r = Recipes["science-pack-3"] = Recipe(12, 5.5)
@IN "advanced-circuit" 1
@IN "engine-unit" 1
@IN "electric-mining-drill" 1
@OUT "science-pack-3" 1

r = Recipes["engine-unit"] = Recipe(10, 5.5)
@IN "steel-plate" 1
@IN "iron-gear-wheel" 1
@IN "pipe" 2
@OUT "engine-unit" 1

r = Recipes["steel-plate"] = Recipe(17.5, 9.4)
@IN "iron-plate" 5
@OUT "steel-plate" 1.2

r = Recipes["iron-gear-wheel"] = Recipe(0.5, 5.5)
@IN "iron-plate" 1
@OUT "iron-gear-wheel" 1.4

r = Recipes["pipe"] = Recipe(0.5, 5.5)
@IN "iron-plate" 1
@OUT "pipe" 1.4

r = Recipes["electric-mining-drill"] = Recipe(2, 8.75)
@IN "electronic-circuit" 3
@IN "iron-gear-wheel" 5
@IN "iron-plate" 10
@OUT "electric-mining-drill" 1

r = Recipes["plastic-bar"] = Recipe(1, 2.5)
@IN "coal" 1
@IN "petroleum-gas" 20
@OUT "plastic-bar" 1.3

r = Recipes["science-pack-2"] = Recipe(6, 5.5)
@IN "inserter" 1
@IN "transport-belt" 1
@OUT "science-pack-2" 1.4

r = Recipes["inserter"] = Recipe(0.5, 8.75)
@IN "electronic-circuit" 1
@IN "iron-gear-wheel" 1
@IN "iron-plate" 1
@OUT "inserter" 1

r = Recipes["transport-belt"] = Recipe(0.5, 8.75)
@IN "iron-gear-wheel" 1
@IN "iron-plate" 1
@OUT "transport-belt" 2

r = Recipes["science-pack-1"] = Recipe(5, 5.5)
@IN "copper-plate" 1
@IN "iron-gear-wheel" 1
@OUT "science-pack-1" 1.4

r = Recipes["production-science-pack"] = Recipe(14, 5.5)
@IN "electric-engine-unit" 1
@IN "assembling-machine-1" 1
@IN "electric-furnace" 1
@OUT "production-science-pack" 2 

r = Recipes["electric-engine-unit"] = Recipe(10, 5.5)
@IN "engine-unit" 1
@IN "electronic-circuit" 2
@IN "lubricant" 15
@OUT "electric-engine-unit" 1.4

r = Recipes["assembling-machine-1"] = Recipe(0.5, 8.75)
@IN "electronic-circuit" 3
@IN "iron-gear-wheel" 5
@IN "iron-plate" 9
@OUT "assembling-machine-1" 1

r = Recipes["electric-furnace"] = Recipe(5, 8.75)
@IN "steel-plate" 10
@IN "advanced-circuit" 5
@IN "stone-brick" 10
@OUT "electric-furnace" 1

r = Recipes["stone-brick"] = Recipe(3.5, 9.4)
@IN "stone" 2
@OUT "stone-brick" 1

r = Recipes["military-science-pack"] = Recipe(10, 5.5)
@IN "piercing-rounds-magazine" 1
@IN "grenade" 1
@IN "gun-turret" 1
@OUT "military-science-pack" 2

r = Recipes["piercing-rounds-magazine"] = Recipe(3, 8.75)
@IN "firearm-magazine" 1
@IN "steel-plate" 1
@IN "copper-plate" 5
@OUT "piercing-rounds-magazine" 1

r = Recipes["firearm-magazine"] = Recipe(1, 8.75)
@IN "iron-plate" 4
@OUT "firearm-magazine" 1 

r = Recipes["grenade"] = Recipe(8, 8.75)
@IN "coal" 10
@IN "iron-plate" 5
@OUT "grenade" 1 

r = Recipes["gun-turret"] = Recipe(8, 8.75)
@IN "copper-plate" 10
@IN "iron-gear-wheel" 10
@IN "iron-plate" 20
@OUT "gun-turret" 1



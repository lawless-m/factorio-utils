using JuMP

m = Model()

type Recipe
	time::Float64
	outs::Dict{AbstractString, Float64}
	ins::Dict{AbstractString, Float64}
	function Recipe(name, time::Float64, speed::Float64)
		recipes[name] = new(time/speed, Dict{AbstractString, Float64}(), Dict{AbstractString, Float64}())
		recipes[name]
	end
end

function production(name)
	nfacs = getvalue(Factory[name])
	r = recipes[name]
	if nfacs == 0 return end
	@printf "%s: %d\n" name nfacs
	@printf "\tProduces\n"
	for (k,v) in r.outs
		@printf "\t\t%0.2f \"%s\" per min - %0.2f per second\n" 60v * nfacs k v * nfacs
	end
	@printf "\tConsumes\n"
	for (k,v) in r.ins
		@printf "\t\t%0.2f \"%s\" per min - %0.2f per second\n" 60v * nfacs k v * nfacs
	end
end

macro IN(iname, iqty) :(recipe.ins[$iname] = $iqty / recipe.time) end

macro OUT(iname, iqty)
	return quote
		push!(Products, $iname)
		recipe.outs[$iname] = $iqty / recipe.time
	end
end

recipes = Dict{AbstractString, Recipe}()
Products = Set{AbstractString}()

recipe  = Recipe("Advanced Oil Processing", 5.0, 1.)
@IN "Crude Oil" 10.
@IN "Water" 5.
@OUT "Heavy Oil" 1.
@OUT "Light Oil" 4.5
@OUT "Petroleum Gas" 5.5

recipe  = Recipe("Heavy Oil Cracking", 5.0 , 1.25)
@IN "Heavy Oil" 4.
@IN "Water" 3.
@OUT "Light Oil" 3.

recipe  = Recipe("Light Oil Cracking", 5.0 , 1.25)
@IN "Light Oil" 3.
@IN "Water" 3.
@OUT "Petroleum Gas" 2.

recipe  = Recipe("Petroleum Gas Solid Fuel", 2., 1.25)
@IN "Petroleum Gas" 2.0
@OUT "Solid Fuel" 1.

recipe  = Recipe("Light Oil Solid Fuel", 2., 1.25)
@IN "Light Oil" 1.0
@OUT "Solid Fuel" 1.

recipe = Recipe("Heavy Oil Solid Fuel", 2., 1.25)
@IN "Heavy Oil" 1.0
@OUT "Solid Fuel" 1.

recipe = Recipe("Rocket Fuel", 30., 1.25)
@IN "Solid Fuel" 10.
@OUT "Rocket Fuel" 1.

recipe = Recipe("Crude Oil Pumping", 1., 1.)
@IN "Pump" 0.1
@OUT "crude-oil" 0.1

include("recipe_protos.jl")

macro Factories() :(collect(keys(recipes))) end

@variable(m, Factory[@Factories] >= 0, Int)

macro FSUM(fac, recipe, dir) :(Factory[$fac] * get(recipes[$fac].$dir, $recipe, 0)) end
macro ALLFSUM(recipe, dir) :(sum([@FSUM(F, $recipe, $dir) for F in @Factories])) end
macro OUTS(recipe) :(@ALLFSUM($recipe, outs)) end
macro INS(recipe)  :(@ALLFSUM($recipe, ins)) end

for r in Products @constraint(m, @INS(r) <= @OUTS(r)) end
@constraint(m, Factory["@INS("heavy-oil") >= @FSUM("advanced-oil-processing, "heavy-oil", outs))


@constraint(m, Factory["Crude Oil Pumping"] == 20)
@objective(m, Max, @OUTS("rocket-fuel"))

solve(m)

for m in @Factories
	production(m)
end

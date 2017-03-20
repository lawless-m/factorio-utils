using JuMP

type Recipe
	name::AbstractString
	time::Float64
	outs::Dict{AbstractString, Float64}
	ins::Dict{AbstractString, Float64}
	function Recipe(name, time, speed)
		recips[name] = new(name, time/speed, Dict{AbstractString, Float64}(), Dict{AbstractString, Float64}())
		recips[name]
	end
end

recips = Dict{AbstractString, Recipe}()

function production(r::Recipe, nfacs)
	@printf "%s: %d\n" r.name nfacs
	@printf "\tProduces\n"
	for (k,v) in r.outs
		@printf "\t\t%0.2f \"%s\" per min - %f per second\n" 60v * nfacs k v * nfacs
	end
	@printf "\tConsumes\n"
	for (k,v) in r.ins
		@printf "\t\t%0.2f \"%s\" per min - %f per second\n" 60v * nfacs k v * nfacs
	end
end


macro IN(iname, iqty)
	return quote
		recipe.ins[$iname] = $iqty / recipe.time
	end
end

macro OUT(iname, iqty)
	return quote
		recipe.outs[$iname] = $iqty / recipe.time
	end
end


@enum Rnum AOP HOC LOC SOL ROK

recips[AOP] = Recipe("Advanced Oil Processing", 5.0, 1 * 1.5 * 1.5)
@IN AOP "Crude Oil" 10.
@IN AOP "Water" 5.
@OUT AOP "Heavy Oil" 1.
@OUT AOP "Light Oil" 4.5
@OUT AOP "Petroleum Gas" 5.5

recips[HOC] = Recipe("Heavy Oil Cracking", 5.0 , 1.25)
@IN HOC "Heavy Oil" 4.
@IN HOC "Water" 3.
@OUT HOC "Light Oil" 3.

recips[LOC] = Recipe("Light Oil Cracking", 5.0 , 1.25)
@IN LOC "Light Oil" 3.
@IN LOC "Water" 3.
@OUT LOC "Petroleum Gas" 2.

recips[SOL] = Recipe("Solid Fuel", 2., 1.25)
@IN SOL "Petroleum Gas" 2.0
@OUT SOL "Solid Fuel" 1.

recips[ROK] = Recipe("Rocket Fuel Assembly", 30., 1.25)
@IN ROK "Solid Fuel" 10.
@OUT ROK "Rocket Fuel" 1.

m = Model()

@variable(m, AOPs >= 0, Int)
@variable(m, HOCs >= 0, Int)
@variable(m, LOCs >= 0, Int)
@variable(m, SOLs >= 0, Int)
@variable(m, ROKs >= 0, Int)

@constraint(m, AOPs * recips[AOP].ins["Crude Oil"] <= 240)
@constraint(m, HOCs * recips[HOC].ins["Heavy Oil"] <= AOPs * recips[AOP].outs["Heavy Oil"])
@constraint(m, LOCs * recips[LOC].ins["Light Oil"] <= AOPs * recips[AOP].outs["Light Oil"] + HOCs * recips[HOC].outs["Light Oil"])
@constraint(m, SOLs * recips[SOL].ins["Petroleum Gas"] <= AOPs * recips[AOP].outs["Petroleum Gas"] + LOCs * recips[LOC].outs["Petroleum Gas"])
@constraint(m, ROKs * recips[ROK].ins["Solid Fuel"] <= SOLs * recips[SOL].outs["Solid Fuel"])

@objective(m, Max, ROKs)

solve(m)

production(recips[AOP], getvalue(AOPs))
production(recips[HOC], getvalue(HOCs))
production(recips[LOC], getvalue(LOCs))
production(recips[SOL], getvalue(SOLs))
production(recips[ROK], getvalue(ROKs))


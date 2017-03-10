using JuMP

m = Model()

type Recipe
	name::AbstractString
	#nfacs::Int64
	time::Float64
	outs::Dict{AbstractString, Float64}
	ins::Dict{AbstractString, Float64}
	#Recipe(n, t) = new(n, 0, t, Dict{AbstractString, Float64}(), Dict{AbstractString, Float64}())
	Recipe(name, time, speed) = new(name, time/speed, Dict{AbstractString, Float64}(), Dict{AbstractString, Float64}())
end

function production(r::Recipe, nfacs)
	@printf "%s: %d\n" r.name nfacs
	@printf "\tProduces\n"
	for (k,v) in r.outs
		@printf "\t\t%0.2f %s per min\n" 60v * nfacs k
	end
	@printf "\tConsumes\n"
	for (k,v) in r.ins
		@printf "\t\t%0.2f %s per min\n" 60v * nfacs k
	end
end

@enum Rnum AOP HOC LOC SOL ROK

recips = Dict{Rnum, Recipe}()

macro IN(rnum, iname, iqty)
	:(recips[$rnum].ins[$iname] = $iqty / recips[$rnum].time)
end

macro OUT(rnum, iname, iqty)
	:(recips[$rnum].outs[$iname] = $iqty / recips[$rnum].time)
end

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
@IN LOC "Water" 3
@OUT LOC "Petroleum Gas" 2.

recips[SOL] = Recipe("Solid Fuel", 2., 1.25)
@IN SOL "Petroleum Gas" 2.0
@OUT SOL "Solid Fuel" 1

recips[ROK] = Recipe("Rocket Fuel Assembly", 30., 1.25)
@IN ROK "Solid Fuel" 10.
@OUT ROK "Rocket Fuel" 1

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


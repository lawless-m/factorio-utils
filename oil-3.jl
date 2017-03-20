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
		@printf "\t\t%0.2f %s per min / %0.2f per sec\n" 60v * nfacs k v*nfacs
	end
	@printf "\tConsumes\n"
	for (k,v) in r.ins
		@printf "\t\t%0.2f %s per min / %0.2f per sec\n" 60v * nfacs k v*nfacs
	end
end

@enum Rnum PJ AOP HOC LOC PGSOL HOSOL LOSOL ROK

recips = Dict{Rnum, Recipe}()

macro IN(rnum, iname, iqty)
	:(recips[$rnum].ins[$iname] = $iqty / recips[$rnum].time)
end

macro OUT(rnum, iname, iqty)
	:(recips[$rnum].outs[$iname] = $iqty / recips[$rnum].time)
end

recips[PJ] = Recipe("Pumpjacks", 1.0, 1)
@IN PJ "Pump" 1
@OUT PJ "Crude Oil" 0.2

recips[AOP] = Recipe("Advanced Oil Processing", 5.0, 1)
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

recips[PGSOL] = Recipe("PG Solid Fuel", 2., 1.25)
@IN PGSOL "Petroleum Gas" 2.0
@OUT PGSOL "Solid Fuel" 1

recips[LOSOL] = Recipe("LO Solid Fuel", 2., 1.25)
@IN LOSOL "Light Oil" 1.0
@OUT LOSOL "Solid Fuel" 1

recips[HOSOL] = Recipe("HO Solid Fuel", 2., 1.25)
@IN HOSOL "Heavy Oil" 1.0
@OUT HOSOL "Solid Fuel" 1

recips[ROK] = Recipe("Rocket Fuel Assembly", 30., 1.25)
@IN ROK "Solid Fuel" 10.
@OUT ROK "Rocket Fuel" 1

@variable(m, PJs >= 0, Int)
@variable(m, AOPs >= 0, Int)
@variable(m, HOCs >= 0, Int)
@variable(m, LOCs >= 0, Int)
@variable(m, PGSOLs >= 0, Int)
@variable(m, HOSOLs >= 0, Int)
@variable(m, LOSOLs >= 0, Int)
@variable(m, ROKs >= 1, Int)

macro FIN(Fn, F, R) :($Fn * recips[$F].ins[$R]) end
macro FOUT(Fn, F, R) :($Fn * recips[$F].outs[$R] )end

@constraint(m, @FOUT(PJs, PJ, "Crude Oil") <= 240)
@constraint(m, @FIN(AOPs, AOP, "Crude Oil") == @FOUT(PJs, PJ, "Crude Oil"))
@constraint(m, @FIN(HOCs, HOC, "Heavy Oil") + @FIN(HOSOLs, HOSOL, "Heavy Oil") == @FOUT(AOPs, AOP, "Heavy Oil"))
@constraint(m, @FIN(LOCs, LOC, "Light Oil") + @FIN(LOSOLs, LOSOL, "Light Oil") == @FOUT(AOPs, AOP, "Light Oil") + @FOUT(HOCs, HOC, "Light Oil"))
@constraint(m, @FIN(PGSOLs, PGSOL, "Petroleum Gas") == @FOUT(AOPs, AOP, "Petroleum Gas") + @FOUT(LOCs, LOC, "Petroleum Gas"))
@constraint(m, @FIN(ROKs, ROK, "Solid Fuel") == @FOUT(PGSOLs, PGSOL, "Solid Fuel") + @FOUT(HOSOLs, HOSOL, "Solid Fuel") + @FOUT(LOSOLs, LOSOL, "Solid Fuel"))

@objective(m, Min, sum([PJs, AOPs, HOCs, LOCs, PGSOLs, HOSOLs, LOSOLs, ROKs]))
solve(m)


production(recips[PJ], getvalue(PJs))
production(recips[AOP], getvalue(AOPs))
production(recips[HOC], getvalue(HOCs))
production(recips[LOC], getvalue(LOCs))
production(recips[PGSOL], getvalue(PGSOLs))
production(recips[LOSOL], getvalue(LOSOLs))
production(recips[HOSOL], getvalue(HOSOLs))
production(recips[ROK], getvalue(ROKs))

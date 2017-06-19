using JuMP

m = Model()

type Recipe
	name::AbstractString
	time::Float64
	outs::Dict{AbstractString, Float64}
	ins::Dict{AbstractString, Float64}
	Recipe(name, time, speed) = new(name, time/speed, Dict{AbstractString, Float64}(), Dict{AbstractString, Float64}())
end

function production(r::Recipe, nfacs)
	@printf "%s: %0.1f\n" r.name nfacs
	@printf "\tProduces\n"
	for (k,v) in r.outs
		@printf "\t\t%0.2f %s per min / %0.2f per sec\n" 60v * nfacs k v*nfacs
	end
	@printf "\tConsumes\n"
	for (k,v) in r.ins
		@printf "\t\t%0.2f %s per min / %0.2f per sec\n" 60v * nfacs k v*nfacs
	end
end

@enum Rnum RED GREEN WIRE

recips = Dict{Rnum, Recipe}()

macro IN(rnum, iname, iqty)
	:(recips[$rnum].ins[$iname] = $iqty / recips[$rnum].time)
end

macro OUT(rnum, iname, iqty)
	:(recips[$rnum].outs[$iname] = $iqty / recips[$rnum].time)
end

recips[GREEN] = Recipe("Green", 0.5, 1.25)
@IN GREEN "Iron" 1
@IN GREEN "Wire" 3
@OUT GREEN "Green" 1

recips[RED] = Recipe("Red", 6.0, 1.25)
@IN RED "Green" 2
@IN RED "Plastic" 2
@IN RED "Wire" 4
@OUT RED "Red" 1


recips[WIRE] = Recipe("Wire", 0.5, 1.25)
@IN WIRE "Copper" 1
@OUT WIRE "Wire" 2

@variable(m, REDs >= 0) #, Int)
@variable(m, GREENs >= 0) #, Int)
@variable(m, WIREs >= 0) #, Int)

macro FIN(Fn, F, R) :($Fn * recips[$F].ins[$R]) end
macro FOUT(Fn, F, R) :($Fn * recips[$F].outs[$R] )end

@constraint(m, REDs == 6)

@constraint(m, @FIN(REDs, RED, "Green") == @FOUT(GREENs, GREEN, "Green"))
@constraint(m, @FIN(REDs, RED, "Wire") + @FIN(GREENs, GREEN, "Wire") == @FOUT(WIREs, WIRE, "Wire"))

@objective(m, Max, sum([REDs, GREENs, WIREs]))
solve(m)

production(recips[RED], getvalue(REDs))
production(recips[GREEN], getvalue(GREENs))
production(recips[WIRE], getvalue(WIREs))

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
@enum Rnum BPACK BATT WIRE GREEN BLUE RED SPEED1

recips = Dict{Rnum, Recipe}()

include("science_recipe.jl")


macro IN(rnum, iname, iqty)
	:(recips[$rnum].ins[$iname] = $iqty / recips[$rnum].time)
end

macro OUT(rnum, iname, iqty)
	:(recips[$rnum].outs[$iname] = $iqty / recips[$rnum].time)
end

recips[YPACK] = Recipe("high-tech-science-pack", 14, 0.5)
@IN YPACK "battery" 1
@IN YPACK "processing-unit" 3
@IN YPACK "speed-module" 1
@IN YPACK "copper-cable" 30
@OUT YPACK "high-tech-science-pack" 2.8

recips[BATT] = Recipe("battery", 5, 1.25)
@IN BATT "sulfuric-acid" 20
@IN BATT "iron-plate" 1
@IN BATT "copper-plate" 1
@OUT BATT "battery" 1

recips[BLUE] = Recipe("processing-unit", 10, 1.25)
@IN BLUE "electronic-circuit" 20
@IN BLUE "advanced-circuit" 2
@IN BLUE "sulfuric-acid" 5
@OUT BLUE "processing-unit" 1

recips[RED] = Recipe("advanced-circuit", 6, 1.25)
@IN RED "electronic-circuit" 2
@IN RED "plastic-bar" 2
@IN RED "copper-cable" 4
@OUT RED "advanced-circuit" 1

recips[GREEN] = Recipe("electronic-circuit", 0.5, 1.25)
@IN GREEN "iron-plate" 14
@IN GREEN "copper-cable" 3
@OUT GREEN "electronic-circuit" 1
	  
recips[SPEED1] = Recipe("speed-module", 15, 1.25)
@IN SPEED1 "advanced-circuit" 5
@IN SPEED1 "electronic-circuit" 5
@OUT SPEED1  "speed-module" 1


recips[WIRE] = Recipe("copper-cable", 0.5, 1.25)
@IN WIRE "copper-plate" 1
@OUT WIRE "copper-cable" 2


@variable(m, YPACKs >= 0) #, Int)
@variable(m, BATTs >= 0) #, Int)
@variable(m, BLUEs >= 0) #, Int)
@variable(m, REDs >= 0) #, Int)
@variable(m, GREENs >= 0) #, Int)
@variable(m, SPEED1s >= 0) #, Int)
@variable(m, WIREs >= 0) #, Int)

macro FIN(Fn, F, R) :($Fn * recips[$F].ins[$R]) end
macro FOUT(Fn, F, R) :($Fn * recips[$F].outs[$R] )end

@constraint(m, YPACKs == 10)

@constraint(m, @FIN(YPACKs, YPACK, "copper-cable") + @FIN(GREENs, GREEN, "copper-cable") +  + @FIN(REDs, RED, "copper-cable") == @FOUT(WIREs, WIRE, "copper-cable"))
@constraint(m, @FIN(YPACKs, YPACK, "battery") == @FOUT(BATTs, BATT, "battery"))
@constraint(m, @FIN(YPACKs, YPACK, "processing-unit") == @FOUT(BLUEs, BLUE, "processing-unit"))
@constraint(m, @FIN(YPACKs, YPACK, "speed-module") == @FOUT(SPEED1s, SPEED1, "speed-module"))

@constraint(m, @FIN(BLUEs, BLUE, "electronic-circuit") + @FIN(REDs, RED, "electronic-circuit") + @FIN(SPEED1s, SPEED1, "electronic-circuit") + @FIN(SPEED1s, SPEED1, "electronic-circuit") == @FOUT(GREENs, GREEN, "electronic-circuit"))
@constraint(m, @FIN(BLUEs, BLUE, "advanced-circuit") + @FIN(SPEED1s, SPEED1, "advanced-circuit") == @FOUT(REDs, RED, "advanced-circuit"))


@objective(m, Min, sum([YPACKs, WIREs]))
solve(m)

production(recips[YPACK], getvalue(YPACKs))
production(recips[BATT], getvalue(BATTs))
production(recips[BLUE], getvalue(BLUEs))
production(recips[RED], getvalue(REDs))
production(recips[GREEN], getvalue(GREENs))
production(recips[WIRE], getvalue(WIREs))
production(recips[SPEED1], getvalue(SPEED1s))

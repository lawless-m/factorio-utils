using JuMP

include("JuMP.jl")

const ASS3SPD = 1.25
const CHEMSPD = 1.25
const SMELTSPD = 2
const DRILLSPD = 1 / 0.525

recipe = Recipe("Production 1", 15, ASS3SPD)
@RIN "Red Circuit" 5
@RIN "Green Circuit" 5
@ROUT "Production 1" 1

recipe = Recipe("Production 2", 30, ASS3SPD)
@RIN "Red Circuit" 5
@RIN "Blue Circuit" 5
@RIN "Production 1" 4
@ROUT "Production 2" 1

recipe = Recipe("Production 3", 60, ASS3SPD)
@RIN "Red Circuit" 5
@RIN "Blue Circuit" 5
@RIN "Production 2" 4
@RIN "Alien Artifact" 1
@ROUT "Production 3" 1

recipe = Recipe("Blue Circuit", 15, ASS3SPD)
@RIN "Green Circuit" 20
@RIN "Red Circuit" 2
@RIN "Sulphuric Acid" 0.5
@ROUT "Blue Circuit" 1

recipe = Recipe("Red Circuit", 8, ASS3SPD)
@RIN "Green Circuit" 2
@RIN "Plastic" 2
@RIN "Copper Cable" 4
@ROUT "Red Circuit" 1

recipe = Recipe("Green Circuit", 0.5, ASS3SPD)
@RIN "Iron Plate" 1
@RIN "Copper Cable" 3
@ROUT "Green Circuit" 1

recipe = Recipe("Copper Cable", 0.5, ASS3SPD)
@RIN "Copper Plate" 1
@ROUT "Copper Cable" 2

recipe = Recipe("Plastic", 1, CHEMSPD)
@RIN "Coal" 1
@RIN "Petroleum Gas" 3
@ROUT "Plastic" 2

recipe = Recipe("Iron Plate", 3.5, SMELTSPD)
@RIN "Iron Ore" 1
@ROUT "Iron Plate" 1

recipe = Recipe("Copper Plate", 3.5, SMELTSPD)
@RIN "Copper Ore" 1
@ROUT "Copper Plate" 1

recipe = Recipe("Iron Ore", 1, DRILLSPD)
@RIN "Rock" 1
@ROUT "Iron Ore" 1
 
recipe = Recipe("Copper Ore", 1, DRILLSPD)
@RIN "Rock" 1
@ROUT "Copper Ore" 1


m = Model()

@variable(m, PROD1s >= 0, Int)
@variable(m, PROD2s>= 0, Int)
@variable(m, PROD3s >= 0, Int)
@variable(m, BLUECs >= 0, Int)
@variable(m, REDCs >= 0, Int)
@variable(m, GREENCs >= 0, Int)
@variable(m, COPPERCs >= 0, Int)
@variable(m, PLASTICs >= 0, Int)
@variable(m, IRONPs >= 0, Int)
@variable(m, COPPERPs >= 0, Int)
@variable(m, IRONOs >= 0, Int)
@variable(m, COPPEROs >= 0, Int)

Machine = Dict(
	PROD3s=>"Production 3",
	PROD2s=>"Production 2",
	PROD1s=>"Production 1",
	BLUECs=>"Blue Circuit",
	REDCs=>"Red Circuit",
	GREENCs=>"Green Circuit",
	COPPERCs=>"Copper Cable",
	PLASTICs=>"Plastic",
	IRONPs=>"Iron Plate",
	COPPERPs=>"Copper Plate",
	IRONOs=>"Iron Ore",
	COPPEROs=>"Copper Ore"
	)

macro OUT(fac)
	return quote
		$fac * recips[Machine[$fac]].outs[Machine[$fac]]
	end
end

macro INS(item)
	return quote
		sum([OtherM * get(recips[Machine[OtherM]].ins, Item, 0) for OtherM in collect(keys(Machine))])
	end
end

@constraint(m, @OUT(PROD3s) >= 1)
for (M,Item) in Machine
	@constraint(m, @OUT(M) >= @INS N)
end
@objective(m, Min, sum(collect(keys(Machine))))

solve(m)

for m in [IRONOs COPPEROs IRONPs COPPERPs COPPERCs GREENCs BLUECs PLASTICs REDCs PROD1s PROD2s PROD3s]
	production(recips[Machine[m]], getvalue(m))
end

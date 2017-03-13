using JuMP

include("JuMP.jl")

const ASS3SPD = 1.25
const CHEMSPD = 1.25
const SMELTSPD = 2 

recipe = Recipe("Production 1", 15, ASS3SPD)
@IN "Red Circuit" 5
@IN "Green Circuit" 5
@OUT "Production 1" 1

recipe = Recipe("Production 2", 30, ASS3SPD)
@IN "Red Circuit" 5
@IN "Blue Circuit" 5
@IN "Production 1" 4
@OUT "Production 2" 1

recipe = Recipe("Production 3", 60, ASS3SPD)
@IN "Red Circuit" 5
@IN "Blue Circuit" 5
@IN "Production 2" 4
@IN "Alien Artifact" 1
@OUT "Production 3" 1

recipe = Recipe("Blue Circuit", 15, ASS3SPD)
@IN "Green Circuit" 20
@IN "Red Circuit" 2
@IN "Sulphuric Acid" 0.5
@OUT "Blue Circuit" 1

recipe = Recipe("Red Circuit", 8, ASS3SPD)
@IN "Green Circuit" 2
@IN "Plastic" 2
@IN "Copper Cable" 4
@OUT "Red Circuit" 1

recipe = Recipe("Green Circuit", 0.5, ASS3SPD)
@IN "Iron Plate" 1
@IN "Copper Cable" 3
@OUT "Green Circuit" 1

recipe = Recipe("Copper Cable", 0.5, ASS3SPD)
@IN "Copper Plate" 1
@OUT "Copper Cable" 2

recipe = Recipe("Plastic", 1, CHEMSPD)
@IN "Coal" 1
@IN "Petroleum Gas" 3
@OUT "Plastic" 2

recipe = Recipe("Iron Plate", 3.5, SMELTSPD)
@IN "Iron Ore" 1
@OUT "Iron Plate" 1

recipe = Recipe("Copper Plate", 3.5, SMELTSPD)
@IN "Copper Ore" 1
@OUT "Copper Plate" 1

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


macro OUTS(fac, item)
	return quote
		$fac * recips[$item].outs[$item]
	end
end
macro INS(fac, recip, item)
	return quote
		$fac * recips[$recip].ins[$item]
	end
end

@constraint(m, @OUTS(PROD3s, "Production 3") >= 10/60)
@constraint(m, @OUTS(PROD2s, "Production 2") >= @INS(PROD3s, "Production 3", "Production 2"))
@constraint(m, @OUTS(PROD1s, "Production 1") >= @INS(PROD2s, "Production 2", "Production 1"))
@constraint(m, @OUTS(BLUECs, "Blue Circuit") >= @INS(PROD2s, "Production 2", "Blue Circuit") + @INS(PROD3s, "Production 3", "Blue Circuit"))
@constraint(m, @OUTS(REDCs, "Red Circuit") >= @INS(PROD2s, "Production 2", "Red Circuit") + @INS(PROD3s, "Production 3", "Red Circuit") + @INS(BLUECs, "Blue Circuit", "Red Circuit"))
@constraint(m, @OUTS(GREENCs, "Green Circuit") >= @INS(REDCs, "Red Circuit", "Green Circuit") + @INS(PROD1s, "Production 1", "Green Circuit") + @INS(BLUECs, "Blue Circuit", "Green Circuit"))
@constraint(m, @OUTS(COPPERCs, "Copper Cable") >= @INS(GREENCs, "Green Circuit", "Copper Cable") + @INS(REDCs, "Red Circuit", "Copper Cable"))
@constraint(m, @OUTS(PLASTICs, "Plastic") >= @INS(REDCs, "Red Circuit", "Plastic"))
@constraint(m, @OUTS(IRONPs, "Iron Plate") >= @INS(GREENCs, "Green Circuit", "Iron Plate"))
@constraint(m, @OUTS(COPPERPs, "Copper Plate") >= @INS(COPPERCs, "Copper Cable", "Copper Plate"))


@objective(m, Min, PROD1s + PROD2s + PROD3s + BLUECs + REDCs + GREENCs + COPPERCs + PLASTICs + IRONPs + COPPERPs)

solve(m)

for (r, n) in [("Iron Plate", IRONPs) ("Copper Plate", COPPERPs) ("Copper Cable", COPPERCs) ("Green Circuit", GREENCs) ("Blue Circuit", BLUECs) ("Plastic", PLASTICs) ("Red Circuit", REDCs) ("Production 1", PROD1s) ("Production 2", PROD2s) ("Production 3", PROD3s)]
	production(recips[r], getvalue(n))
end

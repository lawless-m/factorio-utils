

```julia
Pkg.add("JuMP")
Pkg.add("Cbc")
;
```

```julia
using JuMP
;
```

Recipe Type and some macros


```julia

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

macro RIN(iname, iqty)
	return quote
		recipe.ins[$iname] = $iqty / recipe.time
	end
end

macro ROUT(iname, iqty)
	return quote
		recipe.outs[$iname] = $iqty / recipe.time
	end
end
```

The Assembler / Chemical Plant / Smelter / Drill speeds


```julia
const ASS3SPD = 1.25
const CHEMSPD = 1.25
const SMELTSPD = 2
const DRILLSPD = 1 / 0.525
;
```

Specify the crafting recipes, some macros (@RIN & @ROUT) make it more readable


```julia

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
;

```

All these are the number of crafting stations, we want an integer number and we want zero or more.
We can use the same recipes for finding out items below Prod3 e.g. I want 20 Red Circuits an hour, what do I need ?


```julia

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
;
```

Specify what does each factory produces


```julia

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
;
```

These macros make constraints a bit easier to type


```julia

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
```

Constrain all the outputs of each machine to produce at least as much as the inputs of the next machine


```julia
for (M,Item) in Machine
	@constraint(m, @OUT(M) >= @INS N)
end
```

That's the components, now to specify our problem

We want at least 1 PROD3 every 1/60th of a minute 


```julia
@constraint(m, @OUT(PROD3s) >= 1/60)
```

And, in this case, our objective is to have as few assembly machines as possible


```julia


@objective(m, Min, sum(collect(keys(Machine))))

```


That's the code for the problem, so we can now run the solver


```julia
solve(m)
```




    :Optimal



A pretty printer


```julia
function production(r::Recipe, nfacs)
	if nfacs == 0 return end
    @printf "\"%s\": %d production facilities\n" r.name nfacs
	@printf "\tProduces\n"
	for (k,v) in r.outs
		@printf "\t\t%0.2f \"%s\" per min - %0.2f per second\n" 60v * nfacs k v * nfacs
	end
	@printf "\tConsumes\n"
	for (k,v) in r.ins
		@printf "\t\t%0.2f \"%s\" per min - %0.2f per second\n" 60v * nfacs k v * nfacs
	end
end
;
```

Print out the production numbers for each factory in the order we want - I shoudl really make it search itself, bus as Scarhoof says "It is what it is"


```julia
for m in [IRONOs COPPEROs IRONPs COPPERPs COPPERCs GREENCs BLUECs PLASTICs REDCs PROD1s PROD2s PROD3s]
	production(recips[Machine[m]], getvalue(m))
end

# and the output
```

    "Iron Ore": 12 production facilities
    	Produces
    		1371.43 "Iron Ore" per min - 22.86 per second
    	Consumes
    		1371.43 "Rock" per min - 22.86 per second
    "Copper Ore": 23 production facilities
    	Produces
    		2628.57 "Copper Ore" per min - 43.81 per second
    	Consumes
    		2628.57 "Rock" per min - 43.81 per second
    "Iron Plate": 40 production facilities
    	Produces
    		1371.43 "Iron Plate" per min - 22.86 per second
    	Consumes
    		1371.43 "Iron Ore" per min - 22.86 per second
    "Copper Plate": 75 production facilities
    	Produces
    		2571.43 "Copper Plate" per min - 42.86 per second
    	Consumes
    		2571.43 "Copper Ore" per min - 42.86 per second
    "Copper Cable": 17 production facilities
    	Produces
    		5100.00 "Copper Cable" per min - 85.00 per second
    	Consumes
    		2550.00 "Copper Plate" per min - 42.50 per second
    "Green Circuit": 9 production facilities
    	Produces
    		1350.00 "Green Circuit" per min - 22.50 per second
    	Consumes
    		4050.00 "Copper Cable" per min - 67.50 per second
    		1350.00 "Iron Plate" per min - 22.50 per second
    "Blue Circuit": 7 production facilities
    	Produces
    		35.00 "Blue Circuit" per min - 0.58 per second
    	Consumes
    		70.00 "Red Circuit" per min - 1.17 per second
    		700.00 "Green Circuit" per min - 11.67 per second
    		17.50 "Sulphuric Acid" per min - 0.29 per second
    "Plastic": 3 production facilities
    	Produces
    		450.00 "Plastic" per min - 7.50 per second
    	Consumes
    		225.00 "Coal" per min - 3.75 per second
    		675.00 "Petroleum Gas" per min - 11.25 per second
    "Red Circuit": 22 production facilities
    	Produces
    		206.25 "Red Circuit" per min - 3.44 per second
    	Consumes
    		825.00 "Copper Cable" per min - 13.75 per second
    		412.50 "Green Circuit" per min - 6.88 per second
    		412.50 "Plastic" per min - 6.88 per second
    "Production 1": 4 production facilities
    	Produces
    		20.00 "Production 1" per min - 0.33 per second
    	Consumes
    		100.00 "Red Circuit" per min - 1.67 per second
    		100.00 "Green Circuit" per min - 1.67 per second
    "Production 2": 2 production facilities
    	Produces
    		5.00 "Production 2" per min - 0.08 per second
    	Consumes
    		25.00 "Red Circuit" per min - 0.42 per second
    		25.00 "Blue Circuit" per min - 0.42 per second
    		20.00 "Production 1" per min - 0.33 per second
    "Production 3": 1 production facilities
    	Produces
    		1.25 "Production 3" per min - 0.02 per second
    	Consumes
    		6.25 "Red Circuit" per min - 0.10 per second
    		5.00 "Production 2" per min - 0.08 per second
    		1.25 "Alien Artifact" per min - 0.02 per second
    		6.25 "Blue Circuit" per min - 0.10 per second


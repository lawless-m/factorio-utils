using JuMP

m = Model()

macro persec(d,t)
	return quote
		for (k,v) in $d
			$d[k] = v / $t
		end
	end
end


@enum Item IronPlate IronOre Steel Items
@enum Assembler ElecSmelt Assemblers

iNames = Dict{Item, AbstractString}(IronPlate=>"Iron Plate", IronOre=>"Iron Ore", Steel=>"Steel")

n = Int64(Items)-1
f = Int64(Assemblers)-1

type Recipe
	outs::Dict{Item, Float64}
	ins::Dict{Item, Float64}
	function Recipe(time, outs, ins)
		@persec outs time
		@persec ins time
		new(outs, ins)
	end
end

function production(n::AbstractString, r::Recipe, nfacs)
	@printf "%s\n" n
	@printf "\tProduces\n"
	for (k,v) in r.outs
		@printf "\t\t%f %s per min\n" 60v * nfacs iNames[k]
	end
	@printf "\tConsumes\n"
	for (k,v) in r.ins
		@printf "\t\t%f %s per min\n" 60v * nfacs iNames[k]
	end
end

facSpeed = Dict{Assembler, Float64}(ElecSmelt=>2.0)



Steel_Time = 17.5/facSpeed[ElecSmelt]
Iron_Time = 3.5/facSpeed[ElecSmelt]
Ore_Time = 1 / 0.525

recips = Dict{Item, Recipe}()
recips[Steel] = Recipe(Steel_Time, Dict(Steel=>1.), Dict(IronPlate=>5.))
recips[IronPlate] = Recipe(Iron_Time, Dict(IronPlate=>1.), Dict(IronOre=>1.))
recips[IronOre] = Recipe(Ore_Time, Dict(IronOre=>1.), Dict(IronOre=>1.))

@variable(m, facSteel >= 1, Int)
@variable(m, facIron >= 1, Int)
@variable(m, facOre >= 1, Int)


@constraint(m, facSteel * recips[Steel].outs[Steel] >= 0)
@constraint(m, facIron * recips[IronPlate].outs[IronPlate] >= facSteel * recips[Steel].ins[IronPlate])
@constraint(m, facOre * recips[IronOre].outs[IronOre] >= facIron * recips[IronPlate].ins[IronOre])

@objective(m, Min, (facIron * recips[IronPlate].outs[IronPlate] - facSteel * recips[Steel].ins[IronPlate]))

solve(m)

production("Steel", recips[Steel], getvalue(facSteel))
production("Iron Plate", recips[IronPlate], getvalue(facIron))
production("Iron Ore", recips[IronOre], getvalue(facOre))

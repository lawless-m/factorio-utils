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
n = Int64(Items)-1


type Recipe
	outs::Dict{Item, Float64}
	ins::Dict{Item, Float64}
	function Recipe(time, outs, ins)
		@persec outs time
		@persec ins time
		new(outs, ins)
	end
end

Steel_Time = 17.5/2
Iron_Time = 3.5/2
Ore_Time = 1 / 0.525

recips = Dict{Item, Recipe}()
recips[Steel] = Recipe(Steel_Time, Dict(Steel=>1.), Dict(IronPlate=>5.))
recips[IronPlate] = Recipe(Iron_Time, Dict(IronPlate=>1.), Dict(IronOre=>1.))
recips[IronOre] = Recipe(Ore_Time, Dict(IronOre=>1.), Dict(IronOre=>1.))

@variable(m, facSteel >= 1, Int)
@variable(m, facIron >= 1, Int)
@variable(m, facOre >= 1, Int)

# produces
Steel_Steel = 1 / Steel_Time
# consumes
Steel_IronPlate = 5 / Steel_Time

# produces
IronPlate_IronPlate = 1 / Iron_Time
#consumes
IronPlate_IronOre = 1 / Iron_Time

#produces
IronOre_IronOre = 1 / Ore_Time

@constraint(m, facSteel * Steel_Steel >= 0)
@constraint(m, facIron * IronPlate_IronPlate >= facSteel * Steel_IronPlate)
@constraint(m, facOre * IronOre_IronOre >= facIron * IronPlate_IronOre)



#@objective(m, Min, (facIron * IronPlate_IronPlate - facSteel * Steel_IronPlate) + (facOre * IronOre_IronOre - facIron * IronPlate_IronOre))

@objective(m, Min, (facIron * IronPlate_IronPlate - facSteel * Steel_IronPlate))

solve(m)

v1 = getvalue(facSteel)
r = recips[Steel]
@printf "Steel factories:%f, making %f steel, consuming %f iron plate\n" v1 v1*r.outs[Steel] v1*r.ins[IronPlate]

v2 = getvalue(facIron)
r = recips[IronPlate]
@printf "Iron factories:%f, making %f iron plate, consuming %f iron ore\n" v2 v2*r.outs[IronPlate] v2*r.ins[IronOre]

v3 = getvalue(facOre)
r = recips[IronOre]
@printf "Iron mines:%f, making %f iron ore\n" v3 v3*r.outs[IronOre]


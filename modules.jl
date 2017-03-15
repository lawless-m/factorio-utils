using JuMP

include("JuMP.jl")
include("Types.jl")
include("Recipes.jl")

m = Model()

macro Recipes()
	:(collect(keys(Recipes)))
end

@variable(m, Factories[@Recipes] >= 0, Int)

@constraint(m, length(Factories[@Recipes].factory) == 1)

#=

macro OUT(fac)
	return quote
		$fac * recips[Machine[$fac]].outs[Machine[$fac]]
	end
end

macro INS(item)
	return quote
		sum([Factories[SourceF] * get(recipes[F].ins, Item, 0) for SourceF in Factories)])
	end
end

@constraint(m, Factories[@Recipes])

@constraint(m, @OUT(Factories["Production 3"]) >= 1)
for F in Factories
	@constraint(m, @OUT F >= @INS)
end
@objective(m, Min, sum(@Machines))

solve(m)

for m in @Recipes
	production(Recipes[Machine[m]], getvalue(m))
end
=#
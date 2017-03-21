using JuMP

include("Types.jl")
include("recipe_protos.jl")

function production(r::Recipe, nfacs)
	if nfacs == 0 return end
	@printf "%s: %d\n" r.name nfacs
	@printf "\tProduces\n"
	for (k,v) in r.outs
		@printf "\t\t%0.2f \"%s\" per min - %0.2f per second\n" 60v * nfacs k v * nfacs
	end
	@printf "\tConsumes\n"
	for (k,v) in r.ins
		@printf "\t\t%0.2f \"%s\" per min - %0.2f per second\n" 60v * nfacs k v * nfacs
	end
end

macro Recipes()
	:(collect(keys(Recipes)))
end

macro FOUT(R, I) :(Factories[$R] * get(Recipes[$R].outs, $I, 0)) end
macro FIN(R, I) :(Factories[$R] * get(Recipes[$R].ins, $I, 0)) end 
macro FOUTS(R) :(sum([@FOUT(F, $R) for F in @Recipes])) end
macro FINS(R) :(sum([@FIN(F, $R) for F in @Recipes])) end


function report(status)
	if status == :Optimal
		for r in @Recipes
			production(Recipes[r], getvalue(Factories[r]))
		end
	elseif status == :Unbounded
		print("Problem is unbounded")
	elseif status == :Infeasible
		print("Problem is infeasible")
	elseif status == :UserLimit
		print("Iteration limit or timeout")
	elseif status == :Error
		print("Solver exited with an error")
	elseif status == :NotSolved
		print("Model built in memory but not optimized")
	end
end

m = Model()
@variable(m, Factories[@Recipes] >= 0, Int)
for R in @Recipes
	@constraint(m, @FOUTS(R) >= @FINS(R))
end

const PerMin = 1 / 60
const Minutes = 1 / 15

#@constraint(m, @FOUTS("solar-panel") >= 188PerMin * Minutes)
#@constraint(m, @FOUTS("accumulator") >= 155PerMin * Minutes)
#@constraint(m, @FOUTS("medium-electric-pole") >= 16PerMin * Minutes)
@constraint(m, @FOUTS("substation") >= 1PerMin * Minutes)

@objective(m, Min, sum([Factories[R] for R in @Recipes]))

report(solve(m))



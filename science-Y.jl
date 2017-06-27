using JuMP

m = Model()

type Recipe
	time::Float64
	outs::Dict{AbstractString, Float64}
	ins::Dict{AbstractString, Float64}
	Recipe(time, speed) = new(time/speed, Dict{AbstractString, Float64}(), Dict{AbstractString, Float64}())
end

include("science_recipe.jl")


function production(r, nfacs)
	if nfacs == 0 return end
	
	function prnt(igs)
		for (k,v) in igs
			@printf "\t\t \"%s\" %0.2f /s %0.2f /m\n" k v*nfacs 60v*nfacs
		end
	end
	@printf "%s: %0.2f factories\n" r nfacs
	@printf "\tProduces\n"
	prnt(Recipes[r].outs)
	@printf "\tConsumes\n"
	prnt(Recipes[r].ins)
end

function report(status)
	if status == :Optimal
		for r in @Recipes
			production(r, getvalue(Factories[r]))
		end
		function prnt(i)
			n = @FCONS(i)
			if n > 0
				@printf "\"%s\" %0.2f /s %0.2f /m\n" i n 60n
			end
		end
		@printf "Raws\n"
		for k in ["iron-plate" "copper-plate" "water" "coal" "petroleum-gas" "stone" "sulfuric-acid" "lubricant"]
			prnt(k)
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



@variable(m, Factories[@Recipes] >= 0)
#@variable(m, Factories[@Recipes] >= 0, Int)
#@constraint(m, @FOUTS("high-tech-science-pack") >= 5)
@constraint(m, @FOUTS("production-science-pack") >= 5)


for r in @Recipes
	@constraint(m, @FINS(r) <= @FOUTS(r))
end

#const YellowBelt = 800PerMin
#const RedBelt = 1600PerMin
#const BlueBelt = 2400PerMin

@objective(m, Min, sum(Factories))
report(solve(m))

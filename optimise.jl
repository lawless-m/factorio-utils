#!/usr/local/bin/julia 

using JuMP

include("Types.jl")
include("recipe_protos_cheap.jl")

macro minsec(n) :((60($n), ($n), 60 * $n * mins)) end
macro PerSec(R)	
	return quote
		r = get(Recipes, $R, nothing)
		if r == nothing
			1
		else
			Recipes[$R].factory[end:end][1].speed / Recipes[$R].time
		end
	end
end
macro Recipes() :(collect(keys(Recipes))) end
macro FOUT(R, I) :(Factories[$R] * get(Recipes[$R].outs, $I, 0) * @PerSec($R)) end
macro FIN(R, I) :(Factories[$R] * get(Recipes[$R].ins, $I, 0) * @PerSec($R))  end 
macro FOUTS(K) :(sum([@FOUT(F, $K) for F in @Recipes])) end
macro FINS(K) :(sum([@FIN(F, $K) for F in @Recipes])) end

macro FCON(R, I) :(getvalue(Factories[$R]) * get(Recipes[$R].ins, $I, 0)) end 
macro FCONS(K) :(sum([@FCON(F, $K) for F in @Recipes])) end 

function production(r::Recipe, nfacs, mins)
	if nfacs == 0 return end
	
	function prnt(igs)
		for (k,v) in igs
			@printf "\t\t \"%s\" %0.2f / %0.2f per min/sec : Total %0.2f in \n" k @minsec(@PerSec(k) * v * nfacs)...
		end
	end
	@printf "%s: %0.2f factories in %d mins\n" r.name nfacs mins
	@printf "\tProduces\n"
	prnt(r.outs)
	@printf "\tConsumes\n"
	prnt(r.ins)
end


function report(status, mins)
	if status == :Optimal
		for r in @Recipes
			production(Recipes[r], getvalue(Factories[r]), mins)
		end
		function prnt(i)
			n = @FCONS(i)
			if n > 0
				@printf "\"%s\" %0.2f / %0.2f per min/sec : Total %0.2f\n" i @minsec(n)...
			end
		end
		@printf "Raws in %d mins\n" mins
		for k in ["iron-plate" "copper-plate" "water" "coal" "petroleum-gas" "stone"]
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

m = Model()
@variable(m, Factories[@Recipes] >= 0)
for R in @Recipes
	@constraint(m, @FOUTS(R) >= @FINS(R))
end

@objective(m, Min, sum([Factories[R] for R in @Recipes]))

const PerMin = 1 / 60
const Minutes = 1

const YellowBelt = 800PerMin
const RedBelt = 1600PerMin
const BlueBelt = 2400PerMin

@constraint(m, @FOUTS("rocket-part") >= RedBelt / Minutes)



report(solve(m), Minutes)

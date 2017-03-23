using JuMP

include("Types.jl")
include("recipe_protos.jl")

macro minsec(n) :((60($n), ($n), 60 * $n * mins)) end

function production(r::Recipe, nfacs, mins)
	if nfacs == 0 return end
	
	function prnt(igs)
		for (k,v) in igs
			@printf "\t\t \"%s\" %0.2f / %0.2f per min/sec : Total %0.2f in \n" k @minsec(v * nfacs)...
		end
	end
	@printf "%s: %0.2f factories in %d mins\n" r.name nfacs mins
	@printf "\tProduces\n"
	prnt(r.outs)
	@printf "\tConsumes\n"
	prnt(r.ins)
end

macro Recipes()
	:(collect(keys(Recipes)))
end

macro FOUTx(R, I) 
	return quote
		t = get(Recipes[$R].outs, $I, 0)
		if t > 0
			ps = perSec(Recipes[$R].time,1 )
			@printf("R:%s I:%s t:%0.2f ps:%0.2f\n", $R, $I, t, ps)
			Factories[$R] * t / ps
		else
			0.
		end
	end
end
macro FOUT(R, I)
	return quote
		Factories[$R] * (get(Recipes[$R].outs, $I, 0) * Recipes[$R].factory[end:end][1].speed)
	end
end

macro FIN(R, I) :(Factories[$R] * (get(Recipes[$R].ins, $I, 0) * Recipes[$R].factory[end:end][1].speed))  end 
macro FOUTS(K) :(sum([@FOUT(F, $K) for F in @Recipes])) end
macro FINS(K) :(sum([@FIN(F, $K) for F in @Recipes])) end

macro FCON(R, I) :(getvalue(Factories[$R]) * get(Recipes[$R].ins, $I, 0)) end 
macro FCONS(K) :(sum([@FCON(F, $K) for F in @Recipes])) end 

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


#@constraint(m, @FOUTS("solar-panel") >= 188PerMin / Minutes)
#@constraint(m, @FOUTS("accumulator") >= 155PerMin / Minutes)
#@constraint(m, @FOUTS("medium-electric-pole") >= 16PerMin / Minutes)
@constraint(m, @FOUTS("substation") >= 1PerMin / Minutes)

#@constraint(m, @FOUTS("flamethrower-turret") >= 10PerMin / Minutes)
#@constraint(m, @FOUTS("laser-turret") >= 10PerMin / Minutes)
#@constraint(m, @FOUTS("medium-electric-pole") >= 10PerMin / Minutes)
#@constraint(m, @FOUTS("big-electric-pole") >= 10PerMin / Minutes)
#@constraint(m, @FOUTS("stone-wall") >= 400PerMin / Minutes)
#@constraint(m, @FOUTS("pipe") >= 10PerMin / Minutes)
#@constraint(m, @FOUTS("pipe-to-ground") >= 10PerMin / Minutes)

#@constraint(m, @FOUTS("electric-furnace") >= 1PerMin / Minutes)

report(solve(m), Minutes)

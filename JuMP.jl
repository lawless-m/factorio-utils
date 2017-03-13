


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

function production(r::Recipe, nfacs)
	@printf "%s: %d\n" r.name nfacs
	@printf "\tProduces\n"
	for (k,v) in r.outs
		@printf "\t\t%0.2f \"%s\" per min - %f per second\n" 60v * nfacs k v * nfacs
	end
	@printf "\tConsumes\n"
	for (k,v) in r.ins
		@printf "\t\t%0.2f \"%s\" per min - %f per second\n" 60v * nfacs k v * nfacs
	end
end


macro IN(iname, iqty)
	return quote
		recipe.ins[$iname] = $iqty / recipe.time
	end
end

macro OUT(iname, iqty)
	return quote
		recipe.outs[$iname] = $iqty / recipe.time
	end
end

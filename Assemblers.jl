
type Module
	speed::Float64
	energy::Float64
	production::Float64
end

function stats(pse)
	if pse[1] > 0
		return [[0.04 -0.15 0.05]; [0.06 -0.15 0.6]; [0.1 -0.15 0.8]][pse[1],:]
	end
	if pse[2] > 0
		return [[0 0.2 0.5]; [0 0.3 0.6]; [0 0.5 0.7]][pse[2],:]
	end
	if pse[3] > 0
		return [[0 0 -0.3]; [0 0 -0.4]; [0 0 -0.5]][pse[3],:]
	end
end

type Assembler
	name::AbstractString
	kw::Int64
	speed::Float64
	slots::Int64
	#slots::Vector{Module}
end

function stats(a::Assembler, pse)
	([1 a.speed a.kw]' * [1+pse[1] 1+pse[2] 1+pse[3]])[1,:]
end

function string(a::Assembler, prods, speeds, effs)
	
	#@sprintf "%s : %0.2fkW %0.2f speed %0.2f J per Work" a.name
end

macro taken()
	:(sum([sum(prod) sum(speed) sum(eff)]))
end

macro rem()
	:(0:max(0, a.slots-@taken))
end

prod = [0 0 0]
speed = [0 0 0]
eff = [0 0 0]
for a in [Assembler("A1", 90, 0.5, 0) Assembler("A2", 150, 0.75, 2) Assembler("A3", 210, 1.25, 4)]
	for prod[1] in @rem
		for prod[2] in @rem
			for prod[3] in @rem
				for speed[1] in @rem
					for speed[2] in @rem
						for speed[3] in @rem
							for eff[1] in @rem
								for eff[2] in @rem
									for eff[3] in @rem
										@printf "%s - " a.name
										stat = [0 0 0]
										for p in 1:3
											if prod[p] > 0
												stat = prod[p] * stats([p 0 0]) 
												@printf "\t%d Prod %d" prod[p] p 
											end
										end
										for s in 1:3
											if speed[s] > 0
												stat = speed[s] * stats([0 s 0])
												@printf "\t%d Speed %d" speed[s] s
											end
										end
										for e in 1:3
											if eff[e] > 0
												stat = eff[e] * stats([0 0 e])
												@printf "\t%d Eff %d" eff[e] e
											end
										end
										@printf "\t%s\n" stats(a, stat)
									end
									eff[3] = 0
								end
								eff[2] = 0
							end
							eff[1] = 0
						end
						speed[3] = 0
					end
					speed[2] = 0
				end
				speed[1] = 0
			end
			prod[3] = 0
		end
		prod[2] = 0
	end
	prod[1] = 0
end
					
	
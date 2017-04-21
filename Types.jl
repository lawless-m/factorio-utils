abstract Module

type Productivity <: Module
	yield::Float64
	speed::Float64
	energy::Float64
	pollution::Float64
	function Productivity(n::Int64)
		if n > 0 && n < 4
			y, s, e, p = [(0.04, -0.15, 0.4, 0.05) (0.06, -0.15, 0.6, 0.075) (0.10, -0.15, 0.8, 0.10)][n]...
			return new(y, s, e, p)
		end
	end
end

type Speed <: Module
	yield::Float64
	speed::Float64
	energy::Float64
	pollution::Float64
	function Speed(n::Int64)
		if n > 0 && n < 4
			y, s, e, p = [(0.0, 0.2, 0.5, 0.) (0.0, 0.3, 0.6, 0.) (0.0, 0.5, 0.7, 0.)][n]
			return new(y, s, e, p)
		end
	end
end

type Efficiency <: Module
	yield::Float64
	speed::Float64
	energy::Float64
	pollution::Float64
	function Efficiency(n::Int64)
		if n > 0 && n < 4
			y, s, e, p = [(0.0, 0.0, -0.3, 0.) (0.0, 0.0, -0.4, 0.) (0.0, 0.0, -0.5, 0.)][n]...
			return new(y, s, e, p)
		end
	end
end
abstract Factory

type Assembler <: Factory
	modules::Vector{Module}
	speed::Float64
	function Assembler(n)
		if n > 0 && n < 4
			return new(Vector{Module}([0 2 4][n]), [0.75 1 1.25][n]) # [nmodules...][n], [speeds...][n]
		end
	end
end
	
type OilBasic <: Factory
	modules::Vector{Module}
	speed::Float64
	function OilBasic()
		return new(Vector{Module}(), 1)
	end
end

type OilAdvanced <: Factory
	modules::Vector{Module}
	speed::Float64
	function OilAdvanced()
		return new(Vector{Module}(2), 1)
	end
end

type ChemPlant <: Factory	
	modules::Vector{Module}
	speed::Float64
	function ChemPlant()
		return new(Vector{Module}(2), 1.25)
	end
end

abstract Smelter <: Factory 

type ElectricSmelter <: Smelter
	modules::Vector{Module}
	speed::Float64
	function ElectricSmelter()
		return new(Vector{Module}(2), 2)
	end
end

type Drill <: Factory	
	modules::Vector{Module}
	speed::Float64
	function Drill(n)
		if n > 0 && n < 3
			return new(Vector{Module}([0 2][n]), [0.35 0.525][n]) # [nmodules...][n], [speeds...][n]
		end
	end
end

type Silo <: Factory	
	modules::Vector{Module}
	speed::Float64
	function Silo()
		return new(Vector{Module}(4), 1)
	end
end

type Recipe{Factory}
	name::AbstractString
	time::Float64
	factory::Vector{Factory}
	outs::Dict{AbstractString, Float64}
	ins::Dict{AbstractString, Float64}
	function Recipe(name, time)
		# it's trick to rock a rhyme
		Recipes[name] = new(name,
			time, 
			Dict(
				Assembler=>[Assembler(1), Assembler(2), Assembler(3)], 
				ChemPlant=>[ChemPlant()], 
				Drill=>[Drill(1), Drill(2)], 
				Smelter=>[ElectricSmelter()],
				OilBasic=>[OilBasic()],
				OilAdvanced=>[OilAdvanced()],
				Silo=>[Silo()]
				)[Factory], 
			Dict{AbstractString, Float64}(),
			Dict{AbstractString, Float64}()
			)
		return Recipes[name]
	end
end


Recipes = Dict{AbstractString, Recipe}()

macro RIN(iname, iqty) :(recipe.ins[$iname] = $iqty) end
macro ROUT(iname, iqty) :(recipe.outs[$iname] = $iqty) end

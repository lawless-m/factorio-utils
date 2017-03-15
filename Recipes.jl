
recipe = Recipe{Assembler}("Production 1", 15)
@RIN "Red Circuit" 5
@RIN "Green Circuit" 5
@ROUT "Production 1" 1

recipe = Recipe{Assembler}("Production 2", 30)
@RIN "Red Circuit" 5
@RIN "Blue Circuit" 5
@RIN "Production 1" 4
@ROUT "Production 2" 1

recipe = Recipe{Assembler}("Production 3", 60)
@RIN "Red Circuit" 5
@RIN "Blue Circuit" 5
@RIN "Production 2" 4
@RIN "Alien Artifact" 1
@ROUT "Production 3" 1

recipe = Recipe{Assembler}("Blue Circuit", 15)
@RIN "Green Circuit" 20
@RIN "Red Circuit" 2
@RIN "Sulphuric Acid" 0.5
@ROUT "Blue Circuit" 1

recipe = Recipe{Assembler}("Red Circuit", 8)
@RIN "Green Circuit" 2
@RIN "Plastic" 2
@RIN "Copper Cable" 4
@ROUT "Red Circuit" 1

recipe = Recipe{Assembler}("Green Circuit", 0.5)
@RIN "Iron Plate" 1
@RIN "Copper Cable" 3
@ROUT "Green Circuit" 1

recipe = Recipe{Assembler}("Copper Cable", 0.5)
@RIN "Copper Plate" 1
@ROUT "Copper Cable" 2

recipe = Recipe{ChemPlant}("Plastic", 1)
@RIN "Coal" 1
@RIN "Petroleum Gas" 3
@ROUT "Plastic" 2

recipe = Recipe{Smelter}("Iron Plate", 3.5)
@RIN "Iron Ore" 1
@ROUT "Iron Plate" 1

recipe = Recipe{Smelter}("Copper Plate", 3.5)
@RIN "Copper Ore" 1
@ROUT "Copper Plate" 1

recipe = Recipe{Drill}("Iron Ore", 1)
@RIN "Rock" 1
@ROUT "Iron Ore" 1
 
recipe = Recipe{Drill}("Copper Ore", 1)
@RIN "Rock" 1
@ROUT "Copper Ore" 1

recipe = Recipe{Assembler}("Production Science", 14) # 354 pumpjacks per minute
@RIN "Pumpjack" 1
@RIN "Electric Engine" 1
@RIN "Electic Furnace" 1 
@ROUT "Production Science" 2

recipe = Recipe{Assembler}("Pumpjack", 20) 
@RIN "Steel" 15
@RIN "Iron Gears" 10
@RIN "Green Circuits" 10
@RIN "Pipe" 10
@ROUT "Pumpjack" 1

recipe = Recipe{Assembler}("Pipe", 0.5)
@RIN "Iron Plate" 1
@ROUT "Pipe" 1 

recipe = Recipe{Assembler}("Iron Gears", 0.5)
@RIN "Iron Plate" 2 
@ROUT "Iron Gears" 1

recipe = Recipe{Assembler}("Electric Furnace", 5)
@RIN "Steel" 15 
@RIN "Stone Block" 10
@RIN "Red Circuit" 5
@ROUT "Electric Furnace" 1

recipe = Recipe{Assembler}("Electric Engine", 20)
@RIN "Engine Unit" 1
@RIN "Green Circuit" 2
@RIN "Lubricant" 2
@ROUT "Electric Engine" 1

recipe = Recipe{Assembler}("Electric Unit", 20)
@RIN "Steel" 1
@RIN "Iron Gears" 1
@RIN "Pipe" 1
@ROUT "Electric Unit" 1

recipe = Recipe{Smelter}("Stone Block", 3.5)
@RIN "Stone" 2
@ROUT "Stone Block" 1

recipe = Recipe{ChemPlant}("Lubricant", 1)
@RIN "Heavy Oil" 1
@ROUT "Lubricant" 1






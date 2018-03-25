recipe = Recipe{Assembler}("piercing-rounds-magazine", 3)
@RIN "firearm-magazine" 1
@RIN "steel-plate" 1
@RIN "copper-plate" 5

recipe = Recipe{Assembler}("uranium-rounds-magazine", 10)
@RIN "piercing-rounds-magazine" 1
@RIN "uranium-238" 1

recipe = Recipe{Assembler}("rocket", 8)
@RIN "electronic-circuit" 1
@RIN "explosives" 1
@RIN "iron-plate" 2

recipe = Recipe{Assembler}("explosive-rocket", 8)
@RIN "rocket" 1
@RIN "explosives" 2

recipe = Recipe{Assembler}("atomic-bomb", 50)
@RIN "processing-unit" 20
@RIN "explosives" 10
@RIN "uranium-235" 30

recipe = Recipe{Assembler}("shotgun-shell", 3)
@RIN "copper-plate" 2
@RIN "iron-plate" 2

recipe = Recipe{Assembler}("piercing-shotgun-shell", 8)
@RIN "shotgun-shell" 2
@RIN "copper-plate" 5
@RIN "steel-plate" 2

recipe = Recipe{Assembler}("railgun-dart", 8)
@RIN "steel-plate" 5
@RIN "electronic-circuit" 5

recipe = Recipe{Assembler}("cannon-shell", 0.5)

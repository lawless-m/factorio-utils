cd(ENV["USERPROFILE"] * "/Documents")
unshift!(LOAD_PATH, "GitHub/factorio-utils/")

using FactorioJSON

print(pwd())

recipes()


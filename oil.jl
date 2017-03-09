using JuMP

m = Model()

@variable(m, oil >= 1, Int)
@variable(m, h2l >= 1, Int)
@variable(m, l2g >= 1, Int)

@constraint(m, 10oil <= 240)
@constraint(m, 5.5oil + 2l2g <= 240)
@constraint(m, 4.5oil +  3h2l <= 3l2g)
@constraint(m, 4oil <= h2l)

@objective(m, Min, oil + h2l + l2g)

solve(m)

@printf "oil %f\n" getvalue(oil)
@printf "h2l %f\n" getvalue(h2l)
@printf "l2g %f\n" getvalue(l2g)
@printf "consumes %f oil & produces %f gas per s\n" 10getvalue(oil)/5 (5.5getvalue(oil)+2getvalue(l2g))/5


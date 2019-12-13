import Pkg;
Pkg.add("Cbc")
using JuMP,Cbc

m = Model(with_optimizer(Cbc.Optimizer, logLevel=1))
@variable(m, 0 <= cand[0:98] <= 250,integer=true)#(n*n+1)/2=5000 n=groupupperbound=99) is maximized group number(1...99)-> Because every group can take most 1 candidates in this stuation  (All groups can take most 250 candidaes and less 0 candidades)
@expression(m, tot_votes, sum(i * cand[i] for i in 0:98))#Sum of votes multiply people number must be equal to 5000 
@constraint(m, tot_votes==5000)
@constraint(m, flow[i in 1:98], cand[i-1]>=cand[i])#To push group number maximize we want first groups bigger than last groups 
@constraint(m, sum(cand)==250)#Sum of candidades must be equal to 250 
@objective(m, Min, cand[0])#Upper Constraint makes zeros to maximize also we need to minimize (zero-0 vote group)
status = optimize!(m)



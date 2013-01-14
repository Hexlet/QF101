% quiz 1 answers

%% Question 1
2+3

%% Question 2
sum(1:2:100)

%% Question 3
% Solving $(x^2+10x+16)^\prime = 0$
syms x
solve(diff(x^2+10*x+16))

%% Question 4
m = [1 2 3];
m * ones(3) * m'

%% Question 5
ccode(taylor(exp(x),'order',4))
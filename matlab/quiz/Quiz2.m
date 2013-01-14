% Quiz 2 Answers
format bank
syms q q0 r t m k qn

%% Question 1
% Discrete value calculated as $Q_d=Q_0(1+r/m)^{tm}$
qd = q0*(1+r/m) ^ (t*m);
subs(qd,[q0,r,m,t],[100,0.04,2,5])

%% Question 2
% Present value is calculated as $Q_{0}=Q_n \mathrm{e}^{rt}$
qc = q0*exp(r*t);
q0c = qn*exp(-r*t);
subs(q0c,[qn,r,t],[1000000,0.05,100])

%% Question 3
% This is a solution to
% 
% $$\frac{dQ}{dt} = rQ+k$$
% 
qa = dsolve('Dq = r*q + k','q(0)=q0','t');
subs(qa,[q0,r,t,k],[25,0.06,60,5000])
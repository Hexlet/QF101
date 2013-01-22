%% Time Value of Money

%% Discrete Compounding (One Period)
% This is a really simple idea. Say you've got an amount of money $Q_0 =
% 100$ that you want to put into a bank account that pays 5% ($r = 0.05$)
% per year.
q0=100;r=0.05;

%%
% Then, after one year your account balance is equal to the original
% deposit plus 5% on that deposit:

q1 = q0 + q0*r

%%
% To calculate the balance after two years, we take the balance $Q_1$ and
% apply the same procedure:

q2 = q1 + q1*r

%%
% Using symbolic notation, we can try to evaluate $Q_1$ and $Q_2$ in terms
% of the initial deposit $Q_0$:
syms q0 q1 q2 r
q1 = q0 + q0*r;
factor(q1)
q2 = q1 + q1*r;
factor(q2)

%%
% This lets us deduce that after $t$ years,
%
% $$Q_t = Q_0(1+r)^t$$
%
% So for a period of 10 years, we would get the following graph of $Q$
% against $t$:
t = linspace(0,10);
q0 = 100; r = 0.05;
q = q0*(1+r) .^ t;
figure
xlabel('Time in years');
ylabel('Account balance');
plot(t,q);

%% Discrete Compounding (Multiple Periods)
% The above suggests that we are paid interest once per year. This might
% not necessarily be the case: we could be paid twice a year.
% In this case, we pay half the interest rate, but twice as often and
%
% \[ Q_t = Q_0(1+r/2)^{2t} \]
%
% Plotting this against a single-period model we get a higher return:
q2 = q0*(1+r/2) .^ (2*t);
figure
xlabel('Time in years');
ylabel('Account balance');
plot(t,q,'blue',t,q2,'red');
legend('m = 1','m = 2','location','east')

%%% 
% The above formula can be generalized to:
%
% \[ Q_t = Q_0(1+r/m)^{mt} \]
%
% where $m$ is the number of times per year that interest is paid.

%% Continuous Compounding via Limit Calculation
% Given that a higher value of $m$ yields higher returns, one might see
% banks offering more and more frequent payoffs in order to entice
% customers. The terminal case is when the number of payoffs per year is
% infinite, and thus interest is said to be paid _continuously_.
%
% To get a formula for continuous interest, we simply calculate the limit
% when $m$ becomes infinite:
%
% \[ \lim_{m \to \infty}Q_0 (1+r/m)^{tm} \]
%
% We can factor out $Q_0$ (it's a constant) and use the substitution
%
% \[ (1+r/m)^{tm}=\mathrm{e}^{tm \ln(1+r/m)} \]
%
% Now, remembering that the Taylor series espansion for logarithms is
%
% \[ \ln(1+x)=x-\frac{x^2}{2}+\frac{x^3}{3}-\cdots \]
%
% we use the substitution $x = r/m$ and throw away all terms of second
% order and higher (they all contain $r/m=r/\infty=0$). We arrive at the
% final result
%
% \[ Q = Q_0 \mathrm{e}^{tm \frac{r}{m}}=Q_0 \mathrm{e}^{rt} \]

%% Continuous Compounding via Differential Equation
% Another way of arriving at the same result is to start thinking in
% continuous time, i.e. imagine a process in which the change in account
% balance is always equal to the current balance times the interest rate.
% This can be expressed as
%
% \[ \frac{dQ}{dt} = Qr\\  \]
% 
% We now solve this for $t$:
%
% \begin{split}
% \frac{dQ}{Q}&=&r\, dt\\ 
% \int\frac{dQ}{Q}&=&\int r\, dt\\
% \ln\left|Q\right|&=&rt+c\\e^{\ln\left|Q\right|}&=&e^{rt+c}\\
% Q&=&ke^{rt}
% \end{split}
%
% Substing the initial condition $Q(t=0) = Q_0$ we arrive at
%
% \begin{split}
% Q_{0} &=& ke^{r\cdot0}\\
% Q_{0} &=& k\\
% \therefore Q &=& Q_{0}e^{rt}
% \end{split}
%
% As you can see, both results yield exactly the same formula.

%% Future Value and Present Value
% The _future_ value of an investment is how much money it will be worth in
% the future. For example, if you let 100 dollars accrue 5% interest for 10
% years, with continuous compounding you'll end up with

100 * exp(0.05*10)

%%
% dollars. Alternative, say you've got a million dollars that's been in the
% bank for 10 years at 5% per year (continuosly compounded, of course).
% What was the original investment?

1000000 * exp(-0.05*10)

%%
% This is the _present value_ of the investment. We'll be seeing more of
% present value calculations than future value ones. Note that to get the
% present value we simply multiply $\mathrm{e}^{-rt}$, and is used to
% 'discount' investments by taking away the time value of the money
% invested in them.

%%
% Please note that this formula cannot be used to evaluate, e.g., consumer
% credit based on APR, as those types of calculations involve more
% complicated manipulations.
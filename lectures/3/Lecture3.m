%% Binomial Model
% We start with the simple casewith predefined values of $u$ and $d$.
% The value %N% is 1 + number of steps in the binomial model.

N = 4;
s = zeros(N,N);
c = zeros(N,N);
s = 80;
k = 80;
t = 0.5;
r = 1.1;

u = 1.5;
d = 0.5;
p = (r-d) / (u-d);

%%%
% This gets us a matrix of underlying prices:

for n = 2:N
  for z = 1:n
    if z == 1
      s(z,n) = s(z,n-1) * u;
    else
      s(z,n) = s(z-1,n-1) * d;
    end
  end
end

disp(s);

%%%
% Now, $s(:,N)$ contains the option prices, so we
% calculate terminal option values
c(:,N) = max(s(:,N)-k, 0);
disp(c);

%%%
% How we simply back out of the option prices using the
% formula
% 
% $$C=\frac{pC_u+(1-p)C_d}{r}$$
% 

for n = N-1:-1:1
  for z = 1:n
    c(z,n) = (p*c(z,n+1)+(1-p)*c(z+1,n+1))/r;
  end
end

disp(c);

%%%
% Did we get it right?
[s2,c2] = binprice(s(1,1),k,r,4,1,0.4,0,0,0,0)
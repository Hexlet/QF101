%% Lecture 4

%% Five realizations of brownian motion
m=5;
n=3000;
t=linspace(0,1,n+1);
h=diff(t(1:2));
dw=sqrt(h)*randn(n,m);
w=cumsum([zeros(1,m);dw]);
plot(t,w);

%% Scaled Wiener process
n=300;
t=linspace(0,1,n+1)';
h=diff(t(1:2));
dw=sqrt(h)*randn(n,1);
w=cumsum([0;dw]);
plot(t,t*[0 2 2 -1 1] + w*[1 0.5 2 0.3 3]);
legend('0,1', '2,½','2,2','-1,0.3','1,3');

%% Fire realizations of 
% $$dS = \alpha S \, dt + \beta S \, dW$$
alpha = 1;
beta = 2;
n = 1000;
m = 5;
t = linspace(0, 1, n+1)';
h = diff(t(1:2));
s = ones(n+1,m);
for j=1:n
  dw = randn(1,m) * sqrt(h);
  s(j+1,:) = s(j,:) + alpha*s(j,:)*h + beta*s(j,:).*dw;
end
plot(t,s);
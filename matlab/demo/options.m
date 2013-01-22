%% initial values
s = 0:100; % stock price
k = 50;    % strike
o = 5;     % premium

%% Let's define functions for call and put profits
Bc = max(s-k, 0)-o;
Bp = max(k-s, 0)-o;
hold on
plot(s,Bc,'-r');
plot(s,Bp,'-b');
line([100 0],[0 0],'color','black')
xlabel('Price of underlying (S)');
ylabel('Option payoff');
legend('call','put','location','north');
hold off

%% same idea for sold calls and puts
Sc = min(k-s, 0)+o;
Sp = min(s-k, 0)+o;
figure
hold on
plot(s,Sc,'-r');
plot(s,Sp,'-b');
line([100 0],[0 0],'color','black')
line([100 0],[0 0],'color','black')
xlabel('Price of underlying (S)');
ylabel('Option payoff');
legend('call','put','location','south');
hold off

%% call and put spread
k1 = 45;
k2 = 55;
figure
hold on
plot(s, max(s-k1, 0)-o + min(k2-s, 0)+o, '-b', 'linewidth',5); % buy call@45 sell call@55
plot(s, min(s-k1, 0)+o + max(k2-s, 0)-o, '-r', 'linewidth',5);
legend('call','put');

%% straddle
figure % call and put on same strike
plot(s, Bc + Bp,'color','black','linewidth',5);
line([100 0],[0 0],'color','black')

%% risk reversal
% long call with strike>spot, short put with strike below
figure
plot(s, max(s-k2, 0)-o + min(s-k1, 0)+o,'linewidth',5)
line([100 0],[0 0],'color','black')

%% butterfly
% long call with strike<spot, sell 2 calls atm, long call with strike >
% spot
figure
plot(s, max(s-k1, 0)-o + 2*(min(k-s, 0)+o) + max(s-k2, 0)-o,'linewidth',5)
line([100 0],[0 0],'color','black')
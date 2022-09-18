clear; close all;

% Filter length
N = 19;

% Sampling frequency
fs = 4000;

% Pass band / Transition band
pb = [800/fs, 2000/fs];
tb = [700/fs, 900/fs];

% Interval of normalized frequency
dF = 0.001;
F = 0:dF:0.5;

% Weighting function
W = [0.5*ones(1, round(tb(1)/dF+1)),...
     zeros(1, round((tb(2)-tb(1))/dF)),...
     ones(1, round((pb(2)-tb(2))/dF))];

% Desired filter
Hd = [zeros(1, round(pb(1)/dF+1)),...
      ones(1, round((pb(2)-pb(1))/dF))];

% Stopping criterion
d = 1e-4;

% Arbitrary k+2 extreme frequencies (N=19 -> k=(N-1)/2=9)
% choose outside the range: 0.1750 ~ 0.2250
init_F = [0, 0.04, 0.1, 0.16, 0.25, 0.28, 0.32, 0.365, 0.41, 0.455, 0.5];


% Implement
tic;
[R, h, maxerr] = minmax_FIR(N, F, W, Hd, d, init_F);
toc;

H = 0;
for i = 1:N
    H = H + h(i) * exp(-2i*pi*i*F);
end

% Plot
figure
plot(F, Hd, F, R, 'linewidth',1.5)
title('Frequency response')
xlabel('F')
legend('Desired filter Hd(F)', 'Designed filter R(F)', 'location','southEast')
grid on

figure
plot(F, Hd, F, abs(H), 'linewidth',1.5)
title('Frequency response')
xlabel('F')
axis([0 0.5 -0.2 1.2])
legend('Desired filter Hd(F)', 'Designed filter |H(F)|', 'location','southEast')
grid on

figure
stem(0:N-1, h, 'filled', 'linewidth',1.5)
title('Impulse response')
xlabel('n')
ylabel('h[n]')
grid on





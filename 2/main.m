clear; clc;

% Both x1 and x2 have 8 points
x1 = 1:8;
x2 = [zeros(1,4),ones(1,4)];

% Only need 8 points FFT
[X1, X2] = fftreal(x1,x2)
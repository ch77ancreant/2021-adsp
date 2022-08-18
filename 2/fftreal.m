function [X1, X2] = fftreal(x1, x2)

% Only need one DFT (p.412)
% step1: x3[n] = x[n] + y[n]
x3 = x1 + 1i*x2;
% --------------------------
N = length(x3);
X3 = zeros(1, N);
% --------------------------
% step2: X3[m] = DFT{x3[n]}
for m = 1:N
    X3(m) = sum(x3 .* exp(-2i*pi/N*(m-1) .* [0:N-1]));
end
% --------------------------
% step3: X1[m] = (X3[m]+X3*[N-m])/2
%        X2[m] = (X3[m]-X3*[N-m])/2j
X1 = ( X3 + conj(fliplr(X3))) / 2; 
X2 = ( X3 - conj(fliplr(X3))) / (2i);


    


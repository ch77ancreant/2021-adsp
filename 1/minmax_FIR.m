function [RF, h, maxerr] = minmax_FIR(N, F, W, Hd, d, extreme_F)

k = (N-1)/2;
dF = F(2) - F(1);
a = 0:2:2*k;
iteration = 0;

while 1
    iteration
    A = cos(pi*a.*extreme_F');
    w = W(round(extreme_F/dF+1));

    if mod(k,2) == 0
        w(2:2:k+2) = -w(2:2:k+2);
    else
        w(2:2:k+1) = -w(2:2:k+1);
    end

    A(:, k+2) = (1./w)';

    hd = Hd(round(extreme_F/dF+1))';
    s = A \ hd;

    RF = 0;
    for i = 1:k+1
        RF = RF + s(i)*cos(2*pi*(i-1)*F);
    end

    errF = (RF-Hd).*W;
    extreme_F = [];

    for f = 2:length(F)-1
        if errF(f) > errF(f-1) && errF(f) > errF(f+1)
            extreme_F = [extreme_F, F(f)];
        elseif errF(f) < errF(f-1) && errF(f) < errF(f+1)
            extreme_F = [extreme_F, F(f)];
        end
    end

    if length(extreme_F) < k+2
        extreme_F = [F(1), extreme_F, F(end)];
    end

    if length(extreme_F) > k+2
        extreme_F = extreme_F(length(extreme_F)-k-1:end);
    end
    
    iteration = iteration + 1;
    if iteration == 1
        E0 = max(abs(errF(round(extreme_F/dF+1))));
        continue
    end
    
    E1 = E0;
    E0 = max(abs(errF(round(extreme_F/dF+1))));
    
    if abs(E1-E0) <= d
        break
    end
end

% h[0] = s[0];
% h[k+n] = s[n]/2, h[k-n] = s[n]/2, for n = 1,2,3,...k
maxerr = E0;
s = s';
h = [s(k+1:-1:2)/2, s(1), s(2:k+1)/2];

end


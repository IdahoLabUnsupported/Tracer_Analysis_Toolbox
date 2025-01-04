
%% This function is obsolete, is replaced by TempProfile, vectorized with err fixes

function TP = TempProfileCJ(axis,lambda_r,L,xr,v,b,cpf,cpr,rhof,rhor,top,nChn,Tres,Tinj,npts)
% TempProfile: Calculates temperature profile
% Based on Carslaw & Jaeger (1959, Section 15.3, Case III, p. 396)

TP = zeros(nChn,npts); % Preallocate tp variable
if (axis == "Time")
    for i = 1:npts
        for j = 1:nChn
            if (86400*top(i) <= L(j)*xr(j)/v(j))
%MAP            TP = 0.; Modified to provide consistent vector shape
                TP = Tres .* ones(1,npts);
            else
                TP(j,i) = Tinj-(Tinj-Tres)*erf(lambda_r(j)*L(j)*xr(j)/(v(j)*rhof*b(j)*cpf*sqrt(lambda_r(j)*(86400*top(i) - L(j)*xr(j)/v(j))/(rhor*cpr))));
            end
        end
    end
else % axis = 'Distance'
    for i = 1:npts
        for j = 1:nChn
            if (86400*top(j) <= L(j)*xr(i)/v(j))
%MAP            TP = 0.; Modified to provide consistent vector shape
                TP = Tres .* ones(1,npts);
            else
                TP(j,i) = Tinj-(Tinj-Tres)*erf(lambda_r(j)*L(j)*xr(i)/(v(j)*rhof*b(j)*cpf*sqrt(lambda_r(j)*(86400*top(j) - L(j)*xr(i)/v(j))/(rhor*cpr))));
            end
        end
    
    end
end
end
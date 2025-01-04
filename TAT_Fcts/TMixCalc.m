function T_mix = TMixCalc(T_C,FractionX)
% Function calculated temperature in a mixture of waters
% Inputs: temperature in deg. C, mass fraction

maxiter = 100;

%Number of groups for which to calculate mixture temperature
nCols = size(T_C,2);

T_K = T_C + 273.15;                         
T_mix = sum(T_K .* FractionX,1);          % Initial guess of temperature 
dH = sum(IntRhoCpCalc(T_K).*FractionX,1); % Enthalpy of Mixture

for j = 1:nCols
    iter = 0;
    % Solve for temperature using Newton Iteration
    while (abs((IntRhoCpCalc(T_mix(j))-dH(j))./dIntRhoCpCalc(T_mix(j)))) > 1.0e-6            
        T_mix(j) = T_mix(j) - (IntRhoCpCalc(T_mix(j))-dH(j))./dIntRhoCpCalc(T_mix(j));
        iter = iter + 1;
        if iter > maxiter           
            errordlg('Mixing calc did not converge after 100 iters','Error');
            return
        end
    end 
end 
T_mix = T_mix - 273.15;    % Display Error message if solution did not converge
end 
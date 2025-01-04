function [dIntrhoCpdT] = dIntRhoCpCalc(T_K)
% dIntRhCpCalc calculates the derivative of the integral of the product of density and heat
% capacity of water at % the saturation pressure for a given temperature
% Inputs: temperature of fluid in kelvins

    % Coefficients for polynomial 
    a6 = 0.0;
    a5 = 2.348479E-08;
    a4 = -5.168630E-05;
    a3 = 4.500080E-02;
    a2 = -1.935886E+01;
    a1 = 4.110542E+03;
    a0 = -3.402373E+05;

    % Equation for derivative of the integral of rho*cp of water from 280 to T in kelvin
    dIntrhoCpdT = ((((((a6.*T_K+a5).*T_K+a4).*T_K +a3).*T_K + a2).*T_K+a1).*T_K+a0);
            
end
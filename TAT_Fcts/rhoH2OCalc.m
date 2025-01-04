function [rhoH2O] = rhoH2OCalc(tempC)
% rhoH2O calculates the density of water at the vapor saturation pressure at a given temperature
%   Inputs: temperature of fluid (degC)
%   Output: density of fluid (kg/m^3)


    temp = tempC+273.15;  % Convert temperature to kelvins

    % Coefficients for polynomial section
    a4 = -2.7476461E-08;
    a3 = 4.5323728E-05;
    a2 = -3.0087593E-02;
    a1 = 8.5102963E+00;
    a0 = 1.4999491E+02;

    % Coefficients for exponential term
    b3 = 0.000014975;
    b2 = - 0.0018461;
    b1 = 0.13689;
    b0 = -1.0437;

    % Equation for density of water
    rhoH2O = ((((a4.*temp +a3).*temp + a2).*temp+a1).*temp+a0) - exp(b3.*(temp-575).^3 + b2.*(temp-575).^2+b1.*(temp-575)+b0);
            
end
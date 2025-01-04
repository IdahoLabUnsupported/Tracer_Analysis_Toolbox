function [mu_f] = muH2O_LCalc(tempC)
% muH2O_LCalc calculates the viscosity of liquid water at the vapor saturation pressure at a given temperature
% Inputs: temperature of fluid (degC)
% Output: Viscosity in kPa*s
% Equation valid for temperature range of 280 - 640 K with max Error of
% 1.79% at 640 K and average absolute error of 0.31%

    temp = tempC+273.15;  % Convert temperature to kelvins
    temp = temp -280;

    % Coefficients for exponential term
    a6 = 0.00000000;
    a5 = -1.788782E-12;
    a4 = 1.757346E-09;
    a3 = -7.265342E-07;
    a2 = 0.0001709358;
    a1 = -0.02828975;
    a0 = 7.258235;

    % Equation for viscosity of water
    mu_f = exp(((((((a6*temp+a5)*temp+a4)*temp +a3)*temp + a2)*temp+a1)*temp+a0))/10^9;
            
end
function [cp_f] = cpH2OCalc(T_C)
% cpH2O calculates the specific heat of water at the vapor saturation pressure at a given temperature
%   Inputs: temperature of fluid (Celsius)
%   Outputs: specific heat (J/kg/degC)

    T_K = T_C + 273.15;  % Convert temperature to kelvins

    % Coefficients for polynomial term
    a6 = 4.70777616280339E-14;
    a5 = -1.16978966703786E-10;
    a4 = 1.2023115194198E-07;
    a3 = -0.0000653379314057028;
    a2 = 0.0197921172090977;
    a1 = -3.16818447408784;
    a0 = 2.135301E+02;

    % Coefficients for exponential term
    b6 = 0.000000007794127;
    b5 = -0.000000885442;
    b4 = 0.00003795962;
    b3 = -0.0007385481;
    b2 = 0.006489947;
    b1 = -1.675846E-02;
    b0 = 0.0;

    % Equation for specific heat of water
    cp_f = ((((((a6.*T_K+a5).*T_K+a4).*T_K +a3).*T_K + a2).*T_K+a1).*T_K+a0);

    if(T_K > 600)
        dT_K = T_K - 600;
        cp_f =cp_f*exp(((((((b6.*dT_K+b5).*dT_K+b4).*dT_K +b3).*dT_K + b2).*dT_K+b1).*dT_K+b0));
    end
cp_f = 1000 .* cp_f ; % convert to per kilogram     
end
function [IntrhoCpdT] = IntRhoCpCalc(temp)
% IntRhoCpCalc calculates the integral of the product of density and heat capacity of water 
% at the vapor saturation pressure from 280 kelvin to the temperature temp.
% Inputs: temperature of fluid in kelvins

    % Coefficients for polynomial
    % Fitted to NIST steam table values betwee 280 & 340K
    % Error < 0.5% for 325 <= |temp| <= 635K and -6.1% at 645K and 12.8% at 285K
    % Integral calculated using trapezoidal rule.Cal
    a6 = 3.9141310E-09;
    a5 = -1.0337260E-05;
    a4 = 1.1250200E-02;
    a3 = -6.4529530E+00;
    a2 = 2.0552710E+03;
    a1 = -3.4023730E+05;
    a0 = 2.2548440E+07;

    % Equation for integral of rho*cp of water from 280 to T in kelvin
    IntrhoCpdT = ((((((a6.*temp+a5).*temp+a4).*temp +a3).*temp + a2).*temp+a1).*temp+a0);
            
end
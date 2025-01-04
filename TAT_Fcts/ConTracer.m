
%% Transport function
function [Cmean,C] = ConTracer(axisType,tDataDays,M,Q,alphaParams,ParamArray,rho_f)
% CONSERVATIVE TRACER Calculated concentration of conservative tracer
% Based on Crank (1975, Eq. 2.6, p. 12)
% If Axistype = 'Distance', tData must be vertical per-channel vector
%   Returns per-channel c vs relative distance
% If Axistype = 'Time', tData must be horizontal vector
%   Returns per-channel c vs t and mean c vs t

v = ParamArray(:,1);
L = ParamArray(:,2);
f = ParamArray(:,3);           
alpha = alphaParams(1).*L.^alphaParams(2);

% Convert time units to seconds
tData = tDataDays*86400; 

if axisType == "Time"
    C = 10^9*f.*(v.*M./(rho_f*Q)).*(1./(sqrt(4*pi*alpha.*v.*tData)).*exp(-(L-v.*tData).^2./(4*alpha.*v.*tData)));
    Cmean = sum(C,1);
else
    x_rel = linspace(0,1,101);
    C = 10^9*f.*(v.*M./(rho_f*Q)).*(1./(sqrt(4*pi*alpha.*v.*tData)).*exp(-(x_rel.*L-v.*tData).^2./(4*alpha.*v.*tData)));   
    Cmean = [];
end

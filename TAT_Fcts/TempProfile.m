function T_vec = TempProfile(lambda_r,L,x_rel,v,b,cp_f,cp_r,rho_f,rho_r,t_vec,T_res,T_inj)
% TempProfile: Calculates temperature vs time or distance, 
% Based on Carslaw & Jaeger (1959, Section 15.3, Case III, p. 396)
% Input requirements:
% For T vs t:     x_rel = 1,                  t_vec is long hor. vector
% For T vs x_rel: x_rel is long hor. vector,  t_vec is per-channel t_op
% time units argument must be seconds

% Eliminate negative values in the sqrt function
PositionTerm = max(0, t_vec - L.*x_rel./v);

T_vec = T_inj-(T_inj-T_res).*...
    erf(lambda_r.*L.*x_rel./...
    (v.*rho_f.*b.*cp_f.*sqrt(lambda_r./(rho_r.*cp_r).*PositionTerm)));

% Fix where x_rel and t_vec give 0/0
T_vec(isnan(T_vec)) = T_res;
end
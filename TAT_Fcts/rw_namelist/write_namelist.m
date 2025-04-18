function write_namelist(S, filename)
% WRITE_NAMELIST(S, FILENAME) writes a namelist data structure S to a
% file FILENAME. S should follow the following structure:
%
%                  |--VAR1
%                  |--VAR2
%     |-- NMLST_A--|...
%     |            |--VARNa
%     |
%     |            |--VAR1
%     |-- NMLST_B--|--VAR2
%     |            |...
% S --|     ...    |--VARNb
%     |
%     |            |--VAR1
%     |-- NMLST_M--|--VAR2
%                  |...
%                  |--VARNm
% 
%   Notes: Only supports variables of type: 
%   Scalars, vectors and 2D numeric arrays (integers and floating points)
%   Scalars and 1D boolean arrays specified as '.true.' and '.false.' strings
%   Single and 1D arrays of strings
%    
%   Example:
%       NMLST = read_namelist('OPTIONS.nam');
%       NMLST.NAM_FRAC.XUNIF_NATURE = 0.1;
%       write_namelist(NMlST, 'MOD_OPTIONS.nam');
%
%   Written by:     Darien Pardinas Diaz (darien.pardinas-diaz@monash.edu)
%   Version:        1.0
%   Date:           16 Dec 2011

fid = fopen(filename, 'w');
name_lists = fieldnames(S);
n_name_lists = length(name_lists);

for i = 1:n_name_lists,
    % Write individual namelist records
    fprintf(fid, '&%s\n', name_lists{i});
    rcrds = S.(name_lists{i});
    
    rcrds_name = fieldnames(rcrds);
    n_rcrds = length(rcrds_name);
    
    for j = 1:n_rcrds,
        var = rcrds.(rcrds_name{j});
        % Find variable type...
        if iscell(var),
            fprintf(fid, '   %s =', rcrds_name{j});
            if strcmp(var{1},'.true.') || strcmp(var{1},'.false.'),    
                for k = 1:length(var),
                    fprintf(fid, ' %s,', var{k});    
                end
            else
                for k = 1:length(var),
                    fprintf(fid, ' %s,', ['''' var{k} '''']);    
                end
            end
            fprintf(fid, '%s\n', '');
        else
            [r,c] = size(var);
            if r == 1 || c == 1,
                % Variable is a scalar or vector
                fprintf(fid, '   %s =', rcrds_name{j});
                fprintf(fid, ' %g,', var);
                fprintf(fid, '%s\n', '');
            else
                % Varible is a two dimensional array
                for k = 1:r,
                    fprintf(fid, '   %s(%i,:) =', rcrds_name{j}, k);
                    fprintf(fid, ' %g,', var(k,:));
                    fprintf(fid, '%s\n', ''); 
                end
            end
        end
    end
    fprintf(fid, '%s\n', '/');
end

function [tcHorArray,headers] = ReadData()
%Import two comma-delimited columns, in form t vs c, with two text lines:
    % (1) data description
    % (2) column headers
% Output is [horizontal array of t (row 1) and c(row 2)] with optional
% output of header text for each column used
    
    % Select file
    [filename,pathname] = uigetfile('*.*');
    if isequal(filename,0)
        return;
    end            
    fileNamefull = fullfile(pathname,filename);
    
    % Import all data from file line-by-line as text
    delimiterIn = ',';
    infileID = fopen(fileNamefull);
    allData = readlines(fileNamefull);
    fclose(infileID);
    
    % Line 1: Data Description
    textVar = textscan(allData(1),'%s', 'Delimiter',delimiterIn);
    dataDescription = textVar{1}{1};
    
    % Line 2: Headings
    textVar = textscan(allData(2),'%s', 'Delimiter',delimiterIn);

    % If more than two cols, have user select column to pair with first
    if size(textVar{1},1) > 2
        [indx,~] = listdlg('PromptString',{'Select the column to pair with first column.',...
            'Only one concentration column can be selected.',''},...
            'SelectionMode','single','ListString',textVar{1});    
    else
        indx = 2;
    end
    headers = {[textVar{1}{1} ', '] textVar{1}{indx}};
    
    % Get numeric data (lines 3+)
    endLoop = size(allData,1)-1;
    for i = 3:endLoop
        textVar = textscan(allData(i),'%s', 'Delimiter',delimiterIn);
        tcHorArray(1,i-2) = str2num(textVar{1}{1});
        tcHorArray(2,i-2) = str2num(textVar{1}{indx});
    end
end
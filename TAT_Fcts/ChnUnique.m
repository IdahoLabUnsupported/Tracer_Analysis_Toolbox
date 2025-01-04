function ChnUniqErr = ChnUnique(app,ChnNo)
% Check for uniqueness of channel in parameters Table
% Returns error code ChnUniqErr of 0 chn are unique 1 if the Chn No. are not unique
    [nRows, nCols] = size(ChnNo);
    ChnUniqErr = 0;
    for i = 1 : nRows - 1
        check = ChnNo(i,1);
        for j = i + 1 : nRows
            if (check == ChnNo(j,1))
                ChnUniqErr= 1;
                errTxt = sprintf('Row %d has duplicate channel number at row %d. \nEdit the input file to ensure unique channel numbers',i,j);
                errordlg(errTxt,'Input Error');
                % Return to page
                return;
            end
        end
    end
end
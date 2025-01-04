
function [xy_Ratio] = RatioOnCommonTime(xy_1,xy_2)
    % Interpolate one x vs y record onto x record of the other
    % Ask user which record to use for x 
    dlgtitle = 'Choose interpolation basis';
    quest = 'Choose which record to use as time record';
    btn1 = 'Conservative tracer';
    btn2 = 'Reactive tracer';
    defbtn = btn1;
    response = questdlg(quest,dlgtitle,btn1,btn2,defbtn);
    if isequal(response,0)
        xy_Ratio = 0;
    end
    
    % Eliminate zeros from conservative tracer history
    MinCon = 1e-6;
    xy_1 = xy_1(:,xy_1(2,:)>MinCon);
    if strcmp(response,'Conservative tracer') 
        xy_2new(2,:) = interp1(xy_2(1,:),xy_2(2,:),xy_1(1,:));
        xy_2new(1,:) = xy_1(1,:);
        xy_Ratio(1,:) = xy_1(1,:);
        xy_Ratio(2,:) = xy_2new(2,:)./xy_1(2,:); 
    else 
        xy_1new(2,:) = interp1(xy_1(1,:),xy_1(2,:),xy_2(1,:));
        xy_1new(1,:) = xy_2(1,:);
        xy_Ratio(1,:) = xy_2(1,:);
        xy_Ratio(2,:) = xy_2(2,:)./xy_1new(2,:); 
    end 

    % Eliminate extrapolation failures
    NonNaNs = ~isnan(xy_Ratio(2,:));
    xy_Ratio = xy_Ratio(:,NonNaNs);
end
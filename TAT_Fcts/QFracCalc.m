function fraction = QFracCalc(v,b,includeTP)
%QFracCalc: Calculates the fraction flow in each channel given v and b
%   
total = transpose(v)*(b.*includeTP);
n = sum(includeTP);
if (total == 0)
    fraction(1:n) = includeTP/n;
else
    fraction = v.*b.*includeTP/total;
end
end
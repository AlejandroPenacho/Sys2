function [EBO, R, p] = create_EBO(malfRateArray, repairTimeArray,nLRU)
%CREATE_EBO Determining the EBO, R and p matrices recursively.

maxSpares = 50;     %maximum number of spare parts
EBO = zeros(nLRU, maxSpares);

% Initializing the first values for each matrix
p(:,1) = exp(-malfRateArray.*repairTimeArray);     
R(:,1) = 1-p(:,1);
EBO(:,1) = malfRateArray.*repairTimeArray;

for i = 2:maxSpares
    p(:,i) = (malfRateArray.*repairTimeArray).*p(:,i-1)/(i-1);
    R(:,i) = R(:,i-1) - p(:,i);
    EBO(:,i) = EBO(:,i-1)-R(:,i-1);
end


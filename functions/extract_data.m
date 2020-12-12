function [malfRateArray, repairTimeArray, costArray] = extract_data(filename, nLRU)
    %EXTRACT_DATA Summary of this function goes here
    %   Detailed explanation goes here
    fID = fopen(filename);
    
    fgetl(fID);
    fgetl(fID);
    fgetl(fID);
    
    fscanf(fID, "Malfunction rate");
    malfRateArray = fscanf(fID, "%f", nLRU);
    fscanf(fID, "\nRepair time");
    repairTimeArray = fscanf(fID, "%f", nLRU); 
    fscanf(fID, "\nPurchase cost");
    costArray = fscanf(fID, "%f", nLRU); 
    
    fclose(fID);
end


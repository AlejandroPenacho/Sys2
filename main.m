clc; clear; close all
addpath(genpath("."))

nLRU = 9;

[malfRateArray, repairTimeArray, costArray] = extract_data("files/data.txt", nLRU);

[EBOarray, R, p] = create_EBO(malfRateArray, repairTimeArray, nLRU);

tic
[sparePartsOptimals, mallocCostOptimals, mallocEBOoptimals] = malloc(EBOarray, costArray, nLRU);
time = toc;
fprintf("Marginal allocations:\t%.3f\tms\n",time*1000)

tic
[dynCostOptimals,dynEBOoptimals] = dynamic(EBOarray, costArray, nLRU);
time = toc;
fprintf("Dynamic programming:\t%.3f\tms\n",time*1000)

plot_results(mallocCostOptimals,mallocEBOoptimals,dynCostOptimals, dynEBOoptimals, false);
    
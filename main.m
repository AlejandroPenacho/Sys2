clc; clear; close all
addpath(genpath("."))

nLRU = 9;

[malfRateArray, repairTimeArray, costArray] = extract_data("files/data.txt", nLRU);

[EBOarray, R, p] = create_EBO(malfRateArray, repairTimeArray, nLRU);

tic
[sparePartsOptimals, mallocCostOptimals, mallocEBOoptimals] = malloc(EBOarray, costArray, nLRU);
time = toc;
fprintf("Marginal allocations:\t%.3f\tms",time*1000)

tic
[dynCostOptimals,dynEBOoptimals] = dynamic(EBOarray, costArray, nLRU);
time = toc;
fprintf("Dynamic programming:\t%.3f\tms",time*1000)

figure
hold on
plot(mallocCostOptimals,mallocEBOoptimals, "color", [0, 0.4470, 0.7410]);
scatter(mallocCostOptimals,mallocEBOoptimals,40,'MarkerFaceColor', [0, 0.4470, 0.7410])
plot(dynCostOptimals, dynEBOoptimals, "color", [0.8500, 0.3250, 0.0980]);
scatter(dynCostOptimals, dynEBOoptimals, 10,'MarkerFaceColor', [0.8500, 0.3250, 0.0980]);
hold off

grid minor
ylabel('f, EBO');
xlabel('g, cost');
set(gca, "FontSize", 13)
rectangle("Position", [450,0.4,50,0.06])
rectangle("Position", [85,2.64,30,0.4])

axes('position',[.65 .65 .25 .25])
box on
hold on
plot(mallocCostOptimals,mallocEBOoptimals, "color", [0, 0.4470, 0.7410]);
scatter(mallocCostOptimals,mallocEBOoptimals,40,'MarkerFaceColor', [0, 0.4470, 0.7410])
plot(dynCostOptimals, dynEBOoptimals, "color", [0.8500, 0.3250, 0.0980]);
scatter(dynCostOptimals, dynEBOoptimals, 10,'MarkerFaceColor', [0.8500, 0.3250, 0.0980]);
hold off
grid minor
xlim([450 500])

set(gca, "FontSize", 13)



axes('position',[.2 .2 .2 .2])
box on
hold on
plot(mallocCostOptimals,mallocEBOoptimals, "color", [0, 0.4470, 0.7410]);
scatter(mallocCostOptimals,mallocEBOoptimals,40,'MarkerFaceColor', [0, 0.4470, 0.7410])
plot(dynCostOptimals, dynEBOoptimals, "color", [0.8500, 0.3250, 0.0980]);
scatter(dynCostOptimals, dynEBOoptimals, 10,'MarkerFaceColor', [0.8500, 0.3250, 0.0980]);
hold off
grid minor
xlim([85 115])

set(gca, "FontSize", 13)
function plot_results(mallocCostOptimals,mallocEBOoptimals,dynCostOptimals, dynEBOoptimals, save_figure)
    

    figure
    hold on
    h(1) = plot(mallocCostOptimals,mallocEBOoptimals, "color", [0, 0.4470, 0.7410]);
    scatter(mallocCostOptimals,mallocEBOoptimals,40,'MarkerFaceColor', [0, 0.4470, 0.7410], 'MarkerEdgeColor', [0, 0.4470, 0.7410])
    h(2) = plot(dynCostOptimals, dynEBOoptimals, "color", [0.8500, 0.3250, 0.0980]);
    scatter(dynCostOptimals, dynEBOoptimals, 10,'MarkerFaceColor', [0.8500, 0.3250, 0.0980], 'MarkerEdgeColor', [0.8500, 0.3250, 0.0980])
    hold off

    grid minor
    ylabel('f, EBO');
    xlabel('g, cost');
    set(gca, "FontSize", 13)
    rectangle("Position", [450,0.3,50,0.2])
    rectangle("Position", [85,2.64,30,0.4])
    legend(h, "Malloc","Dynamic","location","east")

    axes('position',[.65 .65 .25 .25])
    box on
    hold on
    plot(mallocCostOptimals,mallocEBOoptimals, "color", [0, 0.4470, 0.7410]);
    scatter(mallocCostOptimals,mallocEBOoptimals,40,'MarkerFaceColor', [0, 0.4470, 0.7410], 'MarkerEdgeColor', [0, 0.4470, 0.7410])
    plot(dynCostOptimals, dynEBOoptimals, "color", [0.8500, 0.3250, 0.0980]);
    scatter(dynCostOptimals, dynEBOoptimals, 10,'MarkerFaceColor', [0.8500, 0.3250, 0.0980], 'MarkerEdgeColor', [0.8500, 0.3250, 0.0980])
    hold off
    grid minor
    xlim([450 500])

    set(gca, "FontSize", 13)



    axes('position',[.2 .2 .2 .2])
    box on
    hold on
    plot(mallocCostOptimals,mallocEBOoptimals, "color", [0, 0.4470, 0.7410]);
    scatter(mallocCostOptimals,mallocEBOoptimals,40,'MarkerFaceColor', [0, 0.4470, 0.7410], 'MarkerEdgeColor', [0, 0.4470, 0.7410])
    plot(dynCostOptimals, dynEBOoptimals, "color", [0.8500, 0.3250, 0.0980]);
    scatter(dynCostOptimals, dynEBOoptimals, 10,'MarkerFaceColor', [0.8500, 0.3250, 0.0980], 'MarkerEdgeColor', [0.8500, 0.3250, 0.0980])
    hold off
    grid minor
    xlim([85 115])

    set(gca, "FontSize", 13)
    
    if save_figure
        saveas(gcf, "files/optimization.eps",'epsc');
    end
end


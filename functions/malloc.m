function [sparePartsOptimals, costOptimals, EBOoptimals] = malloc(EBOarray, costArray, nLRU)
    %MALLOC Summary of this function goes here
    %   Detailed explanation goes here
    sparePartsArray = zeros(nLRU, 1);
    nOptimals = 1;
    
    progressMatrix = -(EBOarray(:, 2:end) - EBOarray(:, 1:end-1))./costArray;
    
    fID = fopen("files/mallocOutput.txt", "w");
    
    fprintf(fID, "1\t2\t3\t4\t5\t6\t7\t8\t9\tEBO\tCost\n\n");
    
    write_line(fID, sparePartsArray, EBOarray, costArray);
    
    [cost, EBO] = compute_current_state(sparePartsArray, EBOarray, costArray);
    sparePartsOptimals(nOptimals,:) = sparePartsArray';
    costOptimals(nOptimals) = cost;
    EBOoptimals(nOptimals) = EBO;
    
    done = false;
    while ~done
        currentProgressArray = zeros(9,1);
        for i=1:9
            if costArray(i) < (500 - sparePartsArray'*costArray)
                currentProgressArray(i) = progressMatrix(i,sparePartsArray(i)+1);
            else
                currentProgressArray(i) = 0;
            end
        end
        
        [~, nextPart] = max(currentProgressArray);
        
        sparePartsArray(nextPart) = sparePartsArray(nextPart) + 1;
        write_line(fID, sparePartsArray, EBOarray, costArray);
        
        nOptimals = nOptimals + 1;
        [cost, EBO] = compute_current_state(sparePartsArray, EBOarray, costArray);
        sparePartsOptimals(nOptimals,:) = sparePartsArray';
        costOptimals(nOptimals) = cost;
        EBOoptimals(nOptimals) = EBO;
        
        if 500 - sparePartsArray'*costArray < min(costArray)
            done = true;
        end
    end
    
    fclose(fID);
end


function write_line(fID, sparePartsArray, EBOarray, costArray)
	[cost, EBO] = compute_current_state(sparePartsArray, EBOarray, costArray);
	
	for i=1:9
		fprintf(fID, "%d\t", sparePartsArray(i));
	end
	fprintf(fID, "%.3f\t%d\n", EBO, cost);
end


function [cost, EBO] = compute_current_state(sparePartsArray, EBOarray, costArray)
	EBO = 0;
        for i=1:9
            EBO = EBO + EBOarray(i, sparePartsArray(i)+1);
        end
	cost = costArray'*sparePartsArray;
end
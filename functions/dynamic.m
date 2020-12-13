function [costOptimals,EBOoptimals] = dynamic(EBOArray, costArray, nLRU)

    fID = fopen("files/dynOutput.txt", "w");
    fprintf(fID, "1\t2\t3\t4\t5\t6\t7\t8\t9\tEBO\tCost\n\n");
    
    maxBudget = 500;
    
    % currentStates holds all states that are being considered at a given
    % time, each row being a state. They are defined by cost, EBO, and
    % number of each LRU. The size of the matrix (2000) is due to
    % preallocation. The first state corresponds to no LRUs.
    
    currentCases = zeros(2000, nLRU+2);
    currentCases(1,2) = getEBO(currentCases(1,3:end),EBOArray);
    nCurrentCases = 1;
    
    % optimalStates holds all states that have been fund to provide the
    % lowest EBO for their given cost.
    
    optimalStates = zeros(500, nLRU+2);
    nOptimalStates = 0;
    
    
    linearArray = 1:100;
    
    while true
        
        %% Obtain confirmed optimal state
        
        % First, the state with the lowest cost is taken, as it is going to
        % be the base for the next batch of states to be considered.
        
        earliestStage = min(currentCases(1:nCurrentCases,1));
        
        if earliestStage == 0
            earliestStageCasesIndexes = 1;
        else
            earliestStageCasesIndexes = (currentCases(1:nCurrentCases,1) == earliestStage);
        end
        
        
        referenceIndexes = linearArray(earliestStageCasesIndexes);
        
        [~, lowestEBOatEarliestStageIndex] = min(currentCases(earliestStageCasesIndexes,2));
       
        updatedCaseIndex = referenceIndexes(lowestEBOatEarliestStageIndex);
        updatedCase = currentCases(updatedCaseIndex,:);
        
        
        currentCases(updatedCaseIndex,:) = [];
        
        nCurrentCases = nCurrentCases - 1;
        
                %% Add state to the optimal set
        
        % If the state with the lowest cost has a cost above the budget,
        % the loop is stopped and the function exits.
        
        if updatedCase(1) >= maxBudget
            break
        end
        
        % Since the state has the lowest cost among the considered states,
        % there is no way a more optimal way to arrive at this cost is
        % going to be obtained at this point. SO, the state is added to the
        % optimal set.
        
        nOptimalStates = nOptimalStates + 1;
        optimalStates(nOptimalStates,:) = updatedCase;

        
        for i=1:nLRU
            fprintf(fID, "%d\t", updatedCase(i+2));
        end
        fprintf(fID, "%.3f\t%d\n", updatedCase(2), updatedCase(1));
        
        
        
        %% Delete non-optimal states
        
        nDeletedCases = length(currentCases(currentCases(:,2) >= updatedCase(2), 1));
        
        currentCases(currentCases(:,2) >= updatedCase(2), :) = [];
        
        nCurrentCases = nCurrentCases - nDeletedCases;
        
        %% Generation of new cases
        
        
        for i=1:nLRU
            
            % 9 new states are generated, by adding one LRU of each type.
            % Cost and EBO of each new state is computed, and the new
            % states are added to currentStates.
            
            newState = updatedCase;
            newState(2+i) = newState(2+i) + 1;
            newState(1) = newState(3:end)*costArray;
            newState(2) = getEBO(newState(3:end),EBOArray);
            
            currentCases(nCurrentCases+i,:) = newState;
        end
        

        nCurrentCases = nCurrentCases + nLRU;

        
    end
    
    costOptimals = optimalStates(1:nOptimalStates,1);
    EBOoptimals = optimalStates(1:nOptimalStates,2);
    
    fclose(fID);
end

function EBO = getEBO(state, EBOArray)
    
    EBO = 0;
    
    for i=1:length(state)
        EBO = EBO + EBOArray(i,state(i)+1);
    end
    
end
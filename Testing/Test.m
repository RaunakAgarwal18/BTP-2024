clc
clear                   
SearchAgents=30;                        
Max_iterations=50;
best_fitness = inf(23,2); % 1 - Ho, 2 - HLOA, 3 - MSA
best_convergence = zeros(23,2,Max_iterations);
% figure;
for i = 1:23                       
    [lowerbound,upperbound,dimension,fitness] = Functions(i);                     % Object function
    for j = 1:30
        % [Best_score_HO,Best_pos_HO,HO_curve]=HO(SearchAgents,Max_iterations,lowerbound,upperbound,dimension,fitness);
        % [Best_score_HLOA,Best_pos_HLOA,HLOA_curve]=HLOA(SearchAgents,Max_iterations,lowerbound,upperbound,dimension,fitness);
        % [Best_score_MSA,Best_pos_MSA,MSA_curve]=MSA(SearchAgents,Max_iterations,lowerbound,upperbound,dimension,fitness);
        % if Best_score_HO < best_fitness(i,1)
        %     best_fitness(i,1) = Best_score_HO;
        %     best_convergence(i,1,:) = HO_curve;
        % end
        % if Best_score_HLOA < best_fitness(i,2)
        %     best_fitness(i,2) = Best_score_HLOA;
        %     best_convergence(i,2,:) = HLOA_curve;
        % end
        % if Best_score_MSA < best_fitness(i,3)
        %     best_fitness(i,3) = Best_score_MSA;
        %     best_convergence(i,3,:) = MSA_curve;
        % end
        [Best_score_FLO,Best_pos_FLO,FLO_curve]=FLO(SearchAgents,Max_iterations,lowerbound,upperbound,dimension,fitness);
        [Best_score_FLO_Updated,Best_pos_FLO_Updated,FLO_Updated_curve]=FLO_Updated(SearchAgents,Max_iterations,lowerbound,upperbound,dimension,fitness);
        if Best_score_FLO < best_fitness(i,1)
            best_fitness(i,1) = Best_score_FLO;
            best_convergence(i,1,:) = FLO_curve;
        end
        if Best_score_FLO_Updated < best_fitness(i,2)
            best_fitness(i,2) = Best_score_FLO_Updated;
            best_convergence(i,2,:) = FLO_Updated_curve;
        end
    end
    subplot(5,5,i)
    hold on;
    plot(squeeze(best_convergence(i,1,:)),"r");
    plot(squeeze(best_convergence(i,2,:)),"g");
    % plot(squeeze(best_convergence(i,3,:)),"m");
    % plot(squeeze(best_convergence(i,4,:)),"b");
    hold off;
    title(i);
    xlabel('X-axis');
    ylabel('Fitness');
    legend('FLO','FLO_Updated')
end

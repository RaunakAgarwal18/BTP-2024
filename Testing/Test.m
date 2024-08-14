clc
clear                   
SearchAgents=30;                        
Max_iterations=50;
best_fitness = inf(23,3); % 1 - Ho, 2 - HLOA, 3 - MSA
best_convergence = zeros(23,3,Max_iterations);
% figure;
for i = 1:23                       
    [lowerbound,upperbound,dimension,fitness] = Functions(i);                     % Object function
    for j = 1:30
        [Best_score_HO,Best_pos_HO,HO_curve]=HO(SearchAgents,Max_iterations,lowerbound,upperbound,dimension,fitness);
        [Best_score_HLOA,Best_pos_HLOA,HLOA_curve]=HLOA(SearchAgents,Max_iterations,lowerbound,upperbound,dimension,fitness);
        [Best_score_MSA,Best_pos_MSA,MSA_curve]=MSA(SearchAgents,Max_iterations,lowerbound,upperbound,dimension,fitness);
        if Best_score_HO < best_fitness(i,1)
            best_fitness(i,1) = Best_score_HO;
            best_convergence(i,1,:) = HO_curve;
        end
        if Best_score_HLOA < best_fitness(i,2)
            best_fitness(i,2) = Best_score_HLOA;
            best_convergence(i,2,:) = HLOA_curve;
        end
        if Best_score_MSA < best_fitness(i,3)
            best_fitness(i,3) = Best_score_MSA;
            best_convergence(i,3,:) = MSA_curve;
        end
    end
    subplot(5,5,i)
    hold on;
    plot(squeeze(best_convergence(i,1,:)),"r");
    plot(squeeze(best_convergence(i,2,:)),"g");
    plot(squeeze(best_convergence(i,3,:)),"m");
    hold off;
    title(i);
    xlabel('X-axis');
    ylabel('Fitness');
    legend('Ho','HLOA','MSA')
end

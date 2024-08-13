clc
clear

% figure;
for i = 1:23
    Fun_name = i;                             % number of test functions: 'F1' to 'F23'
    SearchAgents=30;                           % number of Hippopotamus (population members)
    Max_iterations=50;                         % maximum number of iteration
    [lowerbound,upperbound,dimension,fitness]=Functions(Fun_name);                     % Object function
    
    [Best_score_HO,Best_pos_HO,HO_curve]=HO(SearchAgents,Max_iterations,lowerbound,upperbound,dimension,fitness);
    [Best_score_HLOA,Best_pos_HLOA,HLOA_curve]=HLOA(SearchAgents,Max_iterations,lowerbound,upperbound,dimension,fitness);
    [Best_score_MSA,Best_pos_MSA,MSA_curve]=MSA(SearchAgents,Max_iterations,lowerbound,upperbound,dimension,fitness);

    subplot(5,5,i)
    hold on;
    plot(HO_curve);
    plot(HLOA_curve);
    plot(MSA_curve);
    hold off;
    grid on;

    title(i);
    xlabel('X-axis');
    ylabel('Fitness');
    legend('Ho','HLOA','MSA')
end

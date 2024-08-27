


%% 
% Frilled Lizard Optimization: A Novel Bio-inspired Optimizer for Solving Engineering Applications

% 
% " Optimizer"
%%
clc
clear
close all
%%
% % Ibraheem Abu Falahah1, Osama Al-Baik2, Saleh Alomari3, Gulnara Bektemyssova4, Saikat Gochhait5,6, Irina Leonova7, Om Parkash Malik8, Frank Werner9,*, and Mohammad Dehghani10
% % 1Department of Mathematics, Faculty of Science, The Hashemite University, P.O. Box 330127, Zarqa 13133, Jordan
% % 2Department of Software Engineering, Al-Ahliyya Amman University, Amman, Jordan
% % 3Faculty of Science and Information Technology, Software Engineering, Jadara University, Irbid 21110, Jordan
% % 4Department of Computer Engineering, International Information Technology University,
% % Almaty 050000, Kazakhstan
% % 5Symbiosis Institute of Digital and Telecom Management, Constituent of Symbiosis International Deemed University, Pune 412115, India
% % 6Neuroscience Research Institute, Samara State Medical University, 89 Chapaevskaya str., 443001 Samara, Russia
% % 7Faculty of Social Sciences, Lobachevsky University, 603950 Nizhny Novgorod, Russia
% % 8Department of Electrical and Software Engineering, University of Calgary, Calgary, AB T2N 1N4, Canada
% % 9Faculty of Mathematics, Otto-von-Guericke University, P.O. Box 4120, 39016 Magdeburg, Germany
% % 10Department of Electrical and Electronics Engineering, Shiraz University of Technology, Shiraz 7155713876, Iran
% % *Corresponding Author: Frank Werner. Email: frank.werner@ovgu.de
%%
%%
Fun_name='F1'; % number of test functions: 'F1' to 'F23'

SearchAgents=30;                      % population members 
Max_iterations=1000;                  % maximum number of iteration
[lowerbound,upperbound,dimension,fitness]=fun_info(Fun_name); % Object function information
[Best_score,Best_pos,FLO_curve]=FLO(SearchAgents,Max_iterations,lowerbound,upperbound,dimension,fitness);  % Calculating the solution of the given problem using OOA 

%%
display(['The best optimal value of the objective funciton found by FLO  for ' [num2str(Fun_name)],'  is : ', num2str(Best_score)]);
%%

        
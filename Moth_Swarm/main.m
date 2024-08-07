%______________________________________________________________________________________________
%  Moth Swarm Algorithm (MSA)                                                            
                                                                                               
%  Developed in MATLAB R2008b 
%                                                                                                     
%  Author and programmer: Al-Attar Ali Mohamed
%                                                                                                     
%         e-Mail: engatar@yahoo.com
%_______________________________________________________________________________________________
%    This algorithm has a fast convergence characteristics. 
%    Appreciated results can be obtained with a small number of iterations.   

for iji=[1,8,21]
     if iji==1;F=('F1');elseif iji==2;F=('F2');elseif iji==3;F=('F3');elseif iji==4;F=('F4');elseif iji==5;F=('F5'); ...
     elseif iji==6;F=('F6');elseif iji==7; F=('F7'); elseif iji==8; F=('F8');elseif iji==9; F=('F9'); ... 
     elseif iji==10; F=('F10');elseif iji==11; F=('F11');elseif iji==12; F=('F12'); ...
     elseif iji==13; F=('F13');elseif iji==14; F=('F14');elseif iji==15; F=('F15');
     elseif iji==16; F=('F16');elseif iji==17; F=('F17');elseif iji==18; F=('F18');
     elseif iji==19; F=('F19');elseif iji==20; F=('F20');elseif iji==21; F=('F21');
     elseif iji==22; F=('F22');elseif iji==23; F=('F23');
     end
     
     if iji < 14;Max_iteration=1000;else Max_iteration=500;end% Maximum number of iterations

     SearchAgents_no=30;% Number of search agents
     Nc=6;% Number of Pathfinders: 4 <=  Nc  <= 20% of SearchAgents_no

     % Load details of the selected benchmark function
     [lb,ub,dim,fobj]=Get_Functions_details(F);
     
     [Best_pos,Best_score,Convergence_curve]=MSA(SearchAgents_no,Nc,Max_iteration,ub,lb,dim,fobj);
     
%Draw and display objective function

figure,semilogy(Convergence_curve); title( F ); xlabel('Iteration'); ylabel('Best score');
display(['The optimal solution of ',F, ' is: ',num2str(Best_pos)]);
display(['The optimal value of ',F,' is : ', num2str(Best_score)]);
end

% =====================================================
        




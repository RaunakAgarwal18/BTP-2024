%______________________________________________________________________________________________
%  Moth Swarm Algorithm (MSA)                                                            
                                                                                               
%  Developed in MATLAB R2008b 
%                                                                                                     
%  Author and programmer: Al-Attar Ali Mohamed
%                                                                                                     
%         e-Mail: engatar@yahoo.com
%_______________________________________________________________________________________________

function [X,Moth_fitness] =initialization(SearchAgents_no,dim,ub,lb,fobj)
Boundary_no= size(ub,2); % numnber of boundaries
if Boundary_no==1;
    X=rand(SearchAgents_no,dim).*(ub-lb)+lb;
end
if Boundary_no>1;% If each variable has a different lb and ub
    for i=1:dim; ub_i=ub(i); lb_i=lb(i);
        X(:,i)=rand(SearchAgents_no,1).*(ub_i-lb_i)+lb_i;
    end
end

for i2 = 1:SearchAgents_no
 Moth_fitness(i2,:) = fobj(X(i2,:)); %#ok<AGROW>
end
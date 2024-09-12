%%% Designed and Developed by Mohammad Dehghani %%%
function[Best_score,Best_pos,FLO_curve]=FLO(SearchAgents,Max_iterations,lowerbound,upperbound,dimension,fitness)
lowerbound=ones(1,dimension).*(lowerbound);                              % Lower limit for variables
upperbound=ones(1,dimension).*(upperbound);                              % Upper limit for variables

%% INITIALIZATION
for i=1:dimension
    X(:,i) = lowerbound(i)+rand(SearchAgents,1).*(upperbound(i) - lowerbound(i));                          % Initial population
end

for i =1:SearchAgents
    L=X(i,:);
    fit(i)=fitness(L);
end
%%

for t=1:Max_iterations  % algorithm iteration

    %%  update: BEST proposed solution
    [Fbest , blocation]=min(fit);

    if t==1
        xbest=X(blocation,:);                                           % Optimal location
        fbest=Fbest;                                           % The optimization objective function
    elseif Fbest<fbest
        fbest=Fbest;
        xbest=X(blocation,:);
    end
    %%
    %%
    for i=1:SearchAgents
        %% 3.3.1 Phase 1: Hunting strategy (exploration)candidate_preys 
        prey_position=find(fit<fit(i));% Eq(4)
        if size(prey_position,2)==0
            selected_prey=xbest;
        else
            if rand <0.5
                selected_prey=xbest;
            else
                k=randperm(size(prey_position,2),1);
                selected_prey=X(prey_position(k));
            end
        end
        %
        I=round(1+rand);
        X_new_P1=X(i,:)+rand(1,1).*(selected_prey-I.*X(i,:));%Eq(5)
        X_new_P1 = max(X_new_P1,lowerbound);X_new_P1 = min(X_new_P1,upperbound);

        % update position based on Eq (6)
        L=X_new_P1;
        fit_new_P1=fitness(L);
        if fit_new_P1<fit(i)
            X(i,:) = X_new_P1;
            fit(i) = fit_new_P1;
        end
        %% END Phase 1

        %%
        %% 3.3.2 Phase 2: Moving up the tree (exploitation)
        X_new_P2=X(i,:)+(1-2*rand).*((upperbound-lowerbound)/t);%Eq(7)
        X_new_P2 = max(X_new_P2,lowerbound./t);X_new_P2 = min(X_new_P2,upperbound./t);
        % update position based on Eq (8)
        L=X_new_P2;
        fit_new_P2=fitness(L);
        if fit_new_P2<fit(i)
            X(i,:) = X_new_P2;
            fit(i) = fit_new_P2;
        end
        %% END Phase 2
        %%
    end
    %%

    best_so_far(t)=fbest;
    average(t) = mean (fit);

end
Best_score=fbest;
Best_pos=xbest;
FLO_curve=best_so_far;
end
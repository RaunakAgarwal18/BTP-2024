%______________________________________________________________________________________________
%  Moth Swarm Algorithm (MSA)                                                            
                                                                                               
%  Developed in MATLAB R2008b 
%                                                                                                     
%  Author and programmer: Al-Attar Ali Mohamed
%                                                                                                     
%         e-Mail: engatar@yahoo.com
%_______________________________________________________________________________________________

%  Moth Swarm Algorithm (MSA)                                                            
function [Best_pos,Best_score,Convergence_curve]=MSA(SearchAgents_no,Nc,G,ub,lb,d,fobj)
%Initialize the fitnesses and positions of moths
[Moth_pos,Moth_fitness]=initialization(SearchAgents_no,d,ub,lb,fobj);
[Moth_fitness,location]=sort(Moth_fitness);Moth_pos=Moth_pos(location,:);
Convergence_curve=inf*ones(1,G-1);
g=1;                              % Loop counter
% Main loop
while g<G 
    pMoth_pos = Moth_pos;
    pMoth_fitness = Moth_fitness; 

    %____________________ 1. Reconnaissance phase : Pathfinder moths ____________________________________________________    
    
    Lights=Moth_pos(1:Nc,:);   
    Light_fitness=Moth_fitness(1:Nc);      % best moths considered to be pathfinders
    
    [Lights,Light_fitness] = Pathfinders(Lights,Light_fitness,Nc,fobj,ub,lb); % improve pathfinders
    
    Moth_fitness(1:Nc)=Light_fitness;      Moth_pos(1:Nc,:)=Lights; % insertion in the swarm
    
    % Sharing of luminescence intensities using Eqs.(28) and (29). 
    for i=1:Nc
        if Light_fitness(i)>=0
            Light_fitness(i)=1/(1+Light_fitness(i));
        else
            Light_fitness(i)=1+abs(Light_fitness(i));
        end
    end
    
    for i=1:Nc
        probability(i)=Light_fitness(i)/sum(Light_fitness);
    end 
    
    [VV,R] = histc(rand(1,SearchAgents_no),cumsum([0;probability(:)]));a1 = 1:Nc;new_Light = Lights(a1(R),:);
    
    %__________________2. Transverse orientation phase : prospector moths_________________________________    
    % inspired from Moth-flame Optimization (MFO) [14]: with each variable as an integrated unit
    
    Predictor_no=round((SearchAgents_no-Nc)*(1-g/(G))); %No. of prospectors using Eq.(30).
    a=-1-g/G;
    
    for i=Nc+1:Predictor_no+Nc
           t=(a-1)*rand()+1; spiral=exp(t).*cos(t.*2*pi);    
           D_to_Light=abs(new_Light(i,:)-Moth_pos(i,:));
           Moth_pos(i,:)=D_to_Light.*spiral+new_Light(i,:);       % updating prospectors using Eq.(31)          
    end
    
    % Return back prospectors that go beyond the boundaries
    Moth_pos(Nc+1:Predictor_no+Nc,:) =Bound_Checking(Moth_pos(Nc+1:Predictor_no+Nc,:),ub,lb);
    
    %Fitness evaluation for prospectors
    for i2 = Nc+1:Predictor_no+Nc
     Moth_fitness(i2,:) = fobj(Moth_pos(i2,:));
    end
    
    [gbest, location] = min(Moth_fitness);    gx = Moth_pos(location,:);
    
    %_______________________ 3. Celestial navigation phase: onlooker moths____________________
    % 
    
    % 3.1 Gaussian walks
     x3=round((SearchAgents_no-Predictor_no-Nc)*1/2);
     j2=SearchAgents_no;
    
     for j1=1:x3
        j2=j1+Predictor_no+Nc;

        % updating prospectors using Eqs.(32-33)
        Moth_pos(j2,:)=normrnd(gx(1,:),(log(g)/g)*(abs((Moth_pos(j2,:)-gx(1,:)))), [1 size(Moth_pos,2)])+(randn*gx(1,:)-randn*Moth_pos(j2,:));    %gaussian(large step away)
     
        out=Moth_pos(j2,:)<lb | Moth_pos(j2,:) > ub;
        Moth_pos(j2,out)=normrnd(pMoth_pos(j2,out),(abs((rand*pMoth_pos(j2,out)-rand*gx(1,out)))), [1 size(Moth_pos(j2,out),2)]);                 %(step around);    
     end
       
    % 3.2 Associative learning mechanism with immediate memory (ALIM)
    x3=SearchAgents_no-j2; % no. of onlookers moves with ALIM
    
    for j1=1:x3 
        j3=j1+j2;
        % updating prospectors using Eq.(34)
        Moth_pos(j3,:)=Moth_pos(j3,:)+0.001*unifrnd(lb-Moth_pos(j3,:),ub-Moth_pos(j3,:))+(2*g/G)*rand(size(gx)).*(gx(1,:)-Moth_pos(j3,:))+(1-g/G)*rand(size(gx)).*(new_Light(j3,:)-Moth_pos(j3,:));%step away like PSO
    end
    
    % Apply Position Limits for onlookers
    Moth_pos(Predictor_no+Nc+1:SearchAgents_no,:) = Bound_Checking(Moth_pos(Predictor_no+Nc+1:SearchAgents_no,:),ub,lb);
    
    %Fitness evaluation for onlookers 
    for i2 = Predictor_no+Nc+1:SearchAgents_no
        Moth_fitness(i2,:) = fobj(Moth_pos(i2,:));
    end
    %===================================================================== 
    % select the best moths
    [Moth_fitness,I]=unique([Moth_fitness, pMoth_fitness],'first');  
    Moth_fitness=Moth_fitness(1:SearchAgents_no);
    dMoth_pos=[Moth_pos; pMoth_pos];
    Moth_pos=dMoth_pos(I(1:SearchAgents_no),:);

    % Find the global best solution
    [Best_score, location] = min(Moth_fitness);    Best_pos = Moth_pos(location,:);
    
    Convergence_curve(g)=Best_score;
       
    % Display the iteration and best optimum obtained so far
    if mod(g,50)==0 
        display(['At iteration: ', num2str(g), ' Best fitness is: ', num2str(Best_score)]);
    end
    g=g+1; 
end

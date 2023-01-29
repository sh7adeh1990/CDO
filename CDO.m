%___________________________________________________________________%
% Chernobyl Disaster Optimizer (CDO) source codes version 1.0       %
%                                                                   %
%  Developed in MATLAB 2020                                         %
%                                                                   %
%                         				            %
%                                                                   %
%         e-Mail: sh7adeh1990@hotmail.com                           %
%                    
%                                                                   %
%   Main paper: H. Shehadeh (2023).           
%               Chernobyl Disaster Optimizer (CDO): 
%               A Novel Metaheuristic Method for Global Optimization,
%               Neural Computing and Applications.                  %
%               DOI: https://dx.doi.org/10.1007/s00521-023-08261-1  %
%                                                                   %
%  other algorithms available on: https://github.com/sh7adeh1990    %
%___________________________________________________________________%


function [Alpha_score,Alpha_pos,Convergence_curve]=CDO(SearchAgents_no,Max_iter,lb,ub,dim,fobj)

% initialize alpha, beta, and gamma particle positions (search radiations (Agents)) 
Alpha_pos=zeros(1,dim);
Alpha_score=inf; %change this to -inf for maximization problems

Beta_pos=zeros(1,dim);
Beta_score=inf; %change this to -inf for maximization problems

Gamma_pos=zeros(1,dim);
Gamma_score=inf; %change this to -inf for maximization problems

%Initialize the positions of search radiations (Agents)
Positions=initialization(SearchAgents_no,dim,ub,lb);

Convergence_curve=zeros(1,Max_iter);

l=0;% Loop counter

% Main loop
while l<Max_iter
    for i=1:size(Positions,1)  
        
       % Return back the search radiations (Agents) that go beyond the boundaries of the search space
        Flag4ub=Positions(i,:)>ub;
        Flag4lb=Positions(i,:)<lb;
        Positions(i,:)=(Positions(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;               
        
        % Calculate objective function for each search radiations (Agents)
        fitness=fobj(Positions(i,:));
        
        % Update Alpha, Beta, and Gamma - search radiations (Agents)
       if fitness<Alpha_score 
          Alpha_score=fitness; % Update alpha
          Alpha_pos=Positions(i,:);
        end
        
        if fitness>Alpha_score && fitness<Beta_score 
            Beta_score=fitness; % Update beta
            Beta_pos=Positions(i,:);
        end
        
        if fitness>Alpha_score && fitness>Beta_score && fitness<Gamma_score 
            Gamma_score=fitness; % Update gamma
            Gamma_pos=Positions(i,:);
        end
        
        
        
        
    end
    
  % a=(log10((300000-16000)*rand(1,1)+16000))-l*((log10((300000-16000)*rand(1,1)+16000))/rand());
    a=3-l*((3)/Max_iter); % a decreases linearly from 3 to 0 Equation(9)
    
   a1 = ((log10((16000-1)*rand(1,1)+16000)));
                a2 = ((log10((270000-1)*rand(1,1)+270000)));
    a3 = ((log10((300000-1)*rand(1,1)+300000)));  
            
            
    % Update the Position of search radiations (Agents)
    for i=1:size(Positions,1)
        for j=1:size(Positions,2)     
             
            %------------------- alpha------------------------------           

            r1=rand(); % r1 is a random number in [0,1]
            r2=rand(); % r2 is a random number in [0,1]
            pa=pi*r1*r1/(0.25*a1)- a*rand() ; % Equation (23)
            C1=r2*r2*pi; 
            
            D_alpha=abs(C1*Alpha_pos(j)-Positions(i,j)); 
            va=0.25*(Alpha_pos(j)-pa*D_alpha); % Equation (22)
            
            %------------------- Beta------------------------------           
            r1=rand();
            r2=rand();
            pb=pi*r1*r1/(0.5*a2)- a*rand()  ; % Equation (17)
            C2=r2*r2*pi; 
            
            D_beta=abs(C2*Beta_pos(j)-Positions(i,j)); 
            vb=0.5*(Beta_pos(j)-pb*D_beta); % Equation (16)      
            
           %------------------- Gamma ------------------------------           

            r1=rand();
            r2=rand(); 
            py=(pi*r1*r1)/a3- a*rand() ; % Equation (11)
            C3=r2*r2*pi; 
            
            D_gamma=abs(C3*Gamma_pos(j)-Positions(i,j));
            vy=Gamma_pos(j)-py*D_gamma; % Equation (10)             
            
            
            
            
            Positions(i,j)=(va+vb+vy)/3;% Equation (28)
            
        end
    end
    l=l+1;    
    Convergence_curve(l)=Alpha_score;
end




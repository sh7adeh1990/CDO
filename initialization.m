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

% This function initialize the first population of search radiations (Agents)
function Positions=initialization(SearchAgents_no,dim,ub,lb)

Boundary_no= size(ub,2); % numnber of boundaries

% If the boundaries of all variables are equal and user enter a signle
% number for both ub and lb
if Boundary_no==1
    Positions=rand(SearchAgents_no,dim).*(ub-lb)+lb;
end

% If each variable has a different lb and ub
if Boundary_no>1
    for i=1:dim
        ub_i=ub(i);
        lb_i=lb(i);
        Positions(:,i)=rand(SearchAgents_no,1).*(ub_i-lb_i)+lb_i;
    end
end
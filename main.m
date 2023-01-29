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

% lb=[lb1,lb2,...,lbn] where lbn is the lower bound of variable n
% ub=[ub1,ub2,...,ubn] where ubn is the upper bound of variable n
% If all the variables have equal lower bound you can just
% define lb and ub as two single number numbers

% To run CDO: [Best_score,Best_pos,CDO_cg_curve]=CDO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj)
%__________________________________________

clear all 
clc

SearchAgents_no=30; % Number of search agents

Function_name='F1'; % Name of the test function that can be from F1 to F23 Appendix A in the paper
Max_iteration=1000; % Maximum numbef of iterations

% Load details of the selected benchmark function
[lb,ub,dim,fobj]=Get_Functions_details(Function_name);

[Best_score,Best_pos,CDO_cg_curve]=CDO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);

figure('Position',[500 500 660 290])
%Draw search space
subplot(1,2,1);
func_plot(Function_name);
title('Parameter space')
xlabel('x_1');
ylabel('x_2');
zlabel([Function_name,'( x_1 , x_2 )'])

%Draw objective space
subplot(1,2,2);
semilogy(CDO_cg_curve,'Color','r')
title('Objective space')
xlabel('Iteration');
ylabel('Best score obtained so far');

axis tight
grid on
box on
legend('CDO')

display(['The best solution obtained by CDO is : ', num2str(Best_pos)]);
display(['The best optimal value of the objective funciton found by CDO is : ', num2str(Best_score)]);

        




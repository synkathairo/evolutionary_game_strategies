%%% ECE6263 final project

%% Consider the dove-hawk game as defined in sandholm et al 2020
% page 576
% the resource of value v>0
v = 1;
% cost c > v from both escalating
c = 2;

PLOT_SAVE_DIR = "../..";

% payoff matrix
A = [1/2*v 0; v 1/2*(v-c)];

% initialize the population 
x_initial = [1,0]; % all dove in the beginning
% x_initial = [2/3,1-2/3]; % mostly dove in the beginning
% x_initial = [0.9,0.1]; % mostly dove in the beginning
% x_initial = [0.5,0.5]; %half dove half hawk
% x_initial = [0,1]; % all hawk in the beginning
% x_0 = [0,1];
x_replicator = x_initial;
x_bnn = x_initial; %half dove half hawk
x_smith = x_initial;

% T = 10000; % number of iterations
T = 2e6;
x_vals_replicator = zeros(T,2);
x_vals_bnn = zeros(T,2);
x_vals_smith = zeros(T,2);

h = 1e-6;
dh_f_replicator = @(x) dynamic_replicator(x,A);
dh_f_bnn = @(x) dynamic_bnn(x,A);
dh_f_smith = @(x) dynamic_smith(x,A);

%% use ivp method
% % which ivp method to use?
% ivp_method = @(x,dx) ivp_method_runge_kutta_o4(x,dx,h);
% % ivp_method = @(x,dx) ivp_method_euler(x,dx,h);

% % evaluate to true if the constraint is broken
% validate_constraint = @(x) (any(x>1) || any(x<0));

% T_div10 = T/10;

% % iterate
% for t = 1:T
% 	if mod(t,T_div10)==0
% 		disp(t)
% 	end
% 	x_vals_replicator(t,:) = x_replicator(:);
% 	x_vals_bnn(t,:) = x_bnn(:);
% 	x_vals_smith(t,:) = x_smith(:);

% 	% if (validate_constraint(x_replicator) || validate_constraint(x_bnn) || validate_constraint(x_smith))
% 	% 	break
% 	% end
% 	% if any(x < 0) || any(x > 1)
% 	% 	break
% 	% end
% 	x_replicator = ivp_method(x_replicator,dh_f_replicator);
% 	% x_replicator = euler_method(x_replicator,replicator_dh_f,h);
% 	x_bnn = ivp_method(x_bnn,dh_f_bnn);
% 	x_smith = ivp_method(x_smith,dh_f_smith);

% end

% figure
% % plot(x_vals);
% plot(x_vals_replicator(:,1))
% % semilogy(x_vals_replicator(:,1))
% hold on
% % plot(x_minus_vals);
% plot(x_vals_bnn(:,1))
% % semilogy(x_vals_bnn(:,1))
% % plot(x_vals_replicator(:,2))
% plot(x_vals_smith(:,1))
% % semilogy(x_vals_smith(:,1))
% xlabel("t")
% ylabel("x_1")
% title("Comparing 3 different dynamics for solving dove-hawk game, doves")
% legend("replicator","BNN","Smith")
% % exportgraphics(gcf,"../dove_hawk_dynamics_half_half.pdf")
% % exportgraphics(gcf,"../dove_hawk_dynamics_alldove.pdf")
% % exportgraphics(gcf,"../dove_hawk_dynamics_allhawk.pdf")
% exportgraphics(gcf,"../dove_hawk_dynamics_mostlydove.pdf")

% % title("Replicator dynamics of hawk-dove starting from equal doves/hawks")
% legend("doves","hawks")
% exportgraphics(gcf,"replicator_Dove_Hawk.pdf")

%% try matlab's ode solver

% initialize the population 
% y0 = [1,0]; SAVE_STR = "alldove"; % all dove in the beginning
% y0 = [2/3,1-2/3]; SAVE_STR = "mostlydove"; % mostly dove in the beginning
% y0 = [0.9,0.1]; SAVE_STR = "mostlydove"; % mostly dove in the beginning
% y0 = [0.5,0.5]; SAVE_STR = "half_half"; %half dove half hawk
% y0 = [1/3,1-1/3]; SAVE_STR = "mostlyhawk"; % mostly hawk in the beginning
y0 = [0,1]; SAVE_STR = "allhawk"; % all hawk in the beginning

% tspan = [0 10000];
tspan = [0 1000];

ode_replicator = @(t,y) transpose(dynamic_replicator(y',A));
ode_bnn = @(t,y) transpose(dynamic_bnn(y',A));
ode_smith = @(t,y) transpose(dynamic_smith(y',A));
ode_best_response = @(t,y) transpose(dynamic_best_response(y',A));

% try different solvers. ode89 seems to be the best one.
% https://www.mathworks.com/help/matlab/math/choose-an-ode-solver.html
ode_solver = @(ode) ode89(ode,tspan,y0);
% ode_solver = @(ode) ode45(ode,tspan,y0);

disp("solving ode_replicator")
[t1,y1] = ode_solver(ode_replicator);
disp("solving ode_bnn")
[t2,y2] = ode_solver(ode_bnn);
disp("solving ode_smith")
[t3,y3] = ode_solver(ode_smith);
disp("solving ode_best_response")
[t4,y4] = ode_solver(ode_best_response);

% figure
% plot(t1,y2)
figure
% plot(t2,y2)

% semilogy(y2)
semilogx(t1,y1(:,1))
% plot(t1,y1(:,1))
hold on
semilogx(t2,y2(:,1))
% plot(t2,y2(:,1))
semilogx(t3,y3(:,1))
% plot(t3,y3(:,1))
semilogx(t4,y4(:,1))
% plot(t4,y4(:,1))
title("Comparing 4 different dynamics for solving dove-hawk game, doves")
legend("replicator","BNN","Smith","best response","Location","northwest")
xlabel("t")
ylabel("x_1")

exportgraphics(gcf,compose("%s/dove_hawk_dynamics_%s.pdf",PLOT_SAVE_DIR,SAVE_STR))

% figure
% plot(t3,y3)
% xlabel("t")
% ylabel("x_1")

close all
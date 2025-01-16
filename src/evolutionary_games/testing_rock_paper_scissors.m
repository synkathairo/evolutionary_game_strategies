%%% ECE6263 final project

% TODO: fix orientation so vectors default to column instead of row (this is convention).

%% Consider the rock-paper-scissors as defined in sandholm et al 2020
% page 576
% the benefit of winning the match, 
% good RPS if w > l, standard if w = 1, bad if w < l
% w = 1; l = 1; GAME_TYPE_STR = "standard";
% w = 1; l = 2; GAME_TYPE_STR = "bad";
w = 2; l = 1; GAME_TYPE_STR = "good";
% cost c > v from both escalating

PLOT_SAVE_DIR = "../..";

% payoff matrix
A = [ 0 -l  w; 
      w  0 -l; 
     -l  w  0];

%% try matlab's ode solver

% initialize the population 
% y0 = [1 0 0]; SAVE_STR = "allrock"; START_TYPE_STR = "x = [1 0 0], all rock";
y0 = [1/3 1/3 1/3]; SAVE_STR = "equalRPS"; START_TYPE_STR = "x = [1/3 1/3 1/3], all rock";
% y0 = [2/3,1-2/3]; SAVE_STR = "mostlydove"; % mostly dove in the beginning
% y0 = [0.9,0.1]; SAVE_STR = "mostlydove"; % mostly dove in the beginning
% y0 = [0.5,0.5]; SAVE_STR = "half_half"; %half dove half hawk
% y0 = [1/3,1-1/3]; SAVE_STR = "mostlyhawk"; % mostly hawk in the beginning
% y0 = [0,1]; SAVE_STR = "allhawk"; % all hawk in the beginning

% tspan = [0 10000];
tspan = [0 1000];

ode_replicator = @(t,y) transpose(dynamic_replicator(y',A));
% ode_replicator = @(t,y) transpose(dynamic_maynardsmith(y',A));
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

subplot(2,2,1)
semilogx(t1,y1)
title("replicator dynamic")
legend("rock","paper","scissors","Location","northwest")
% figure
subplot(2,2,2)
semilogx(t2,y2)
% title(compose("%s RPS, starting from all rock, BNN dynamic",GAME_TYPE_STR))
title("BNN dynamic")
legend("rock","paper","scissors","Location","northwest")
% figure
subplot(2,2,3)
semilogx(t3,y3)
% title(compose("%s RPS, starting from all rock, Smith dynamic",GAME_TYPE_STR))
title("Smith dynamic")
legend("rock","paper","scissors","Location","northwest")
% figure
subplot(2,2,4)
semilogx(t4,y4)
% title(compose("%s RPS, starting from all rock, best response dynamic",GAME_TYPE_STR))
title("best response dynamic")
legend("rock","paper","scissors","Location","northwest")
sgtitle(compose("%s RPS, starting from %s",GAME_TYPE_STR,START_TYPE_STR))
exportgraphics(gcf,compose("%s/rps_dynamics_%s_%s.pdf",PLOT_SAVE_DIR,GAME_TYPE_STR,SAVE_STR))
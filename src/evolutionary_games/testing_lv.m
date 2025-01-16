%% Consider the Lotka-Volterra game as described by Vincent et al 2011

PLOT_SAVE_DIR = "../..";

% parameters
% vincent et al 2005 suggests with r value of 1.5, stable asymptomatic stability
% will occur with respect to the discrete logistic equation
% see evolutionary game theory natural selection (ISBN 9780521841702) 2005
% on page 35
% page 127, 
% r = 1.5; SAVE_STR = "r1_5";
r = 0.25; SAVE_STR = "r0_25";
K_m = 100; SAVE_STR = append(SAVE_STR,"_K_m100");
% K_m = 500; SAVE_STR = append(SAVE_STR,"_K_m500");
% K_m = 100000; SAVE_STR = append(SAVE_STR,"_K_m100000");
% sigma_a = 0.5;
sigma_a = 2;
sigma_k = 2;

% initialize variables
% u = [-3 3];
% v = linspace(-5,5,100);
% u = v;
% x = exp(-v.^2);
% x = x/sum(x);

% v = [-5 5];
% u = v;
% x = exp(-v.^2);
% x = x/sum(x);

% u = [-3 3];
% v = linspace(-5,5,100);
% v = linspace(0,5,100); SAVE_STR = append(SAVE_STR,"_v0to5");
% v = -2;
% v = [1 2];
v = [0 0];
u = v;
% x = exp(-v.^2);
% x = ones(1,100);
% x = x/sum(x);
x = [0.75 0.25]; 


G = @(x) game_lotka_volterra(u,v,x,sigma_k,sigma_a,r,K_m);
dynamic_ecological_lv = @(x) dynamic_ecological(x,G(x));

ode_ecological_lv = @(t,y) transpose(dynamic_ecological_lv(y'));


tspan = [0 10000];

% y0 = x;
% y0 = [0.5 0.5];

ode_solver = @(ode) ode89(ode,tspan,x);
[t1,y1] = ode_solver(ode_ecological_lv);
% semilogx(t1,y1)
figure
plot(t1,y1)
xlabel("t")
ylabel("x")
title("Lotka-Volterra model under ecological dynamics")
% exportgraphics(gcf,compose("%s/lk_dynamics_%s.pdf",PLOT_SAVE_DIR,SAVE_STR))
% close all
%% Fourth-order Runge Kutta (see Kreyszig - Advanced Engineering Mathematics, 10th ed, p 905 (section 21.1))
% note we are using dynamic system where x' = f(x), the argument f here is x'
% ivp problem
function x = ivp_method_runge_kutta_o4(x,f,h)
	k1 = h*f(x);
	k2 = h*f(x+k1/2);
	k3 = h*f(x+k2/2);
	k4 = h*f(x+k3);
	x = x + (k1+2*k2+2*k3+k4)/6;

	% apply a normalization to avoid floating point errors
	x =x/sum(x);

	% we cannot have any values less than 0 or more than 1. 
	% due to the nature of the ivp using runge kutta etc it may happen
	% perhaps other methods are necessary.
	% for now, enforce this constraint as setting such values to 0 or 1
	x(x<0) = 0;
	x(x>1) = 1;
end
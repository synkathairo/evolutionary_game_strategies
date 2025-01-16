%% Euler's method, for a step
function x = ivp_method_euler(x,f,h)
	x = x + h*f(x);

	% apply a normalization to avoid floating point errors
	x =x/sum(x);

	% we cannot have any values less than 0 or more than 1. 
	% due to the nature of the ivp using euler etc it may happen
	% perhaps other methods are necessary.
	% for now, enforce this constraint as setting such values to 0 or 1
	x(x<0) = 0;
	x(x>1) = 1;
end
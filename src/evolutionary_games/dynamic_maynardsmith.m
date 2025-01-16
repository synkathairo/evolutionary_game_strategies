%% Define the Maynard Smith replicator dynamic
function dot_x = dynamic_maynardsmith(x, A)
	x_size = size(x);
	x_len = x_size(2);

	% avg payoff
	F = x*A;
	avg_F = F*x';
	hat_F = F - avg_F*ones(1,x_len);
	dot_x = (hat_F .* x)./avg_F;

	% % using euler's method for simplicity,
	% h = 1e-6;
	% x = x + h*dot_x;
	% x = x / sum(x);
end
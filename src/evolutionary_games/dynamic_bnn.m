%% BNN dynamic
function dot_x = dynamic_bnn(x,A)
	x_size = size(x);
	x_len = x_size(2);

	% avg payoff
	avg_F = x*A*x';
	hat_F = x*A - avg_F*ones(1,x_len);
	hat_F_p = max(hat_F,0);

	total_excess = sum(hat_F_p);

	dot_x = hat_F_p - x*total_excess;

	% % using euler's method for simplicity,
	% h = 1e-6;
	% x = x + h*dot_x;
	% x = x / sum(x);
end
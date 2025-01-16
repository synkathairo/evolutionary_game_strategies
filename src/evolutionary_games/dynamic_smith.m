%% Smith dynamic
function dot_x = dynamic_smith(x,A)
	x_size = size(x);
	x_len = x_size(2);

	F = x*A;

	dot_x = zeros(1,x_len);

	for i=1:x_len
		payoff_diff_sum = 0;
		payoff_diff_sum_weighed = 0;
		for j=1:x_len
			payoff_diff1 = F(i)-F(j);
			payoff_diff2 = F(j)-F(i);
			payoff_diff_sum = payoff_diff_sum + max(payoff_diff2,0);
			payoff_diff_sum_weighed = payoff_diff_sum_weighed + max(payoff_diff1,0)*x(j);
		end
		dot_x(i) = payoff_diff_sum_weighed - x(i)*payoff_diff_sum;
	end

	% % using euler's method for simplicity,
	% h = 1e-6;
	% x = x + h*dot_x;
	% x = x / sum(x);
end
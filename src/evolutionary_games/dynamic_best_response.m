function dot_x = dynamic_best_response(x,F)
	% normalize
	% x = x / sum(x);
	% payoffs
	% F = x * A;

	% best response (pure strategy with maximum payoff)
	[~, best_response_idx] = max(F);
	bf_x = zeros(size(x)); % initialize best response vector
	bf_x(best_response_idx) = 1; % probability 1 to the best response

	% best response dynamic
	dot_x = bf_x - x;
end
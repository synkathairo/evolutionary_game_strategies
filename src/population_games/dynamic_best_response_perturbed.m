function dot_x = dynamic_best_response_perturbed(x,A)
	% Compute payoffs
	F = x * A;

	% Find the best response (pure strategy with maximum payoff)
	[~, best_response_idx] = max(F);
	bf_x = zeros(size(x)); % Initialize best response vector
	bf_x(best_response_idx) = 1; % Assign probability 1 to the best response

	% Compute best response dynamic
	dot_x = bf_x - x;
end
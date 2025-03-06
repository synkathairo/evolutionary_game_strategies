function F = game_random_matching(x,A,B)
	% return the payoff matrix based on the population state 
	% and the strategy distribution per population
	M = [0 A; B' 0];
	F = x*M;
%% ecological dynamic
% takes a G-function instead of normal matrix A as input, 
% G function can be appropriate for that specific ecological game
function dot_x = dynamic_ecological(x,G)
	x = x(:)';
	x = x / sum(x);
	% assuming x and G are both row vectors
	dot_x = x .* G;
end


function G = game_lotka_volterra(v,u,x,sigma_k, sigma_a, r, K_m)
	% carrying capacity
	% K = @(u_val) K_m * exp(-u_val.^2 / (2 * sigma_k^2));
	K_v = K_m * exp(-v.^2/(2*sigma_k^2));
	% competition function
	alpha = exp(-(v - u).^2 ./ (2 * sigma_a^2));
	alpha_weighed = x .* alpha;

	% G function
	G = r - (r./K_v) .*sum(alpha_weighed);
end
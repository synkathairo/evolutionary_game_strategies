function dot_x = dynamic_logit(x,A, eta)
	F_i = A*x;
	exp_term = exp(1/eta*F_i);
	dot_x = exp_term/(sum(exp_term)) - x;
end
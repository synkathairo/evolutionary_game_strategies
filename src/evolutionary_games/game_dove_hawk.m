function F = game_dove_hawk(v,c,x)
	A = [1/2*v 0; v 1/2*(v-c)];
	F = x*A;
end
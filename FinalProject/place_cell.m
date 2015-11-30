% place cell response is a 2D Gaussian based on the distance from the agent
% to the place cell center
function y = place_cell (loc, ctr)

w = 2*0.25^2;
y = exp(-norm(loc-ctr)^2/w);
end

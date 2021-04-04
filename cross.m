function [J] = cross(I, n_iterations, lambda, W, alpha, sigma, guide)

% guide parameter is mandatory for the cross function
J = edgeAware(I, n_iterations, lambda, W, alpha, sigma, guide);

end

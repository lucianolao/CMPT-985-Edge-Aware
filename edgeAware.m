function [J] = edgeAware(I, n_iterations, lambda, W, alpha, sigma)

height = size(I,1);
width = size(I,2);

J = I;

[Hh] = kernelH(I, W, alpha, sigma);
[Hv] = kernelV(I, W, alpha, sigma);

for iter = 1:n_iterations
    % Horizontal
    Jnew = zeros(size(J));
    for i = 1:height
        for j = 1:width
            
        end
    end
    
    % Vertical
    Jnew = zeros(size(J));
    for j = 1:width
        for i = 1:height
            
        end
    end
    
end


end

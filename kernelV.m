function [Hv] = kernelV(I, W, alpha, sigma)

height = size(I,1) - W*2;
width = size(I,2) - W*2;

kernel_size = W*2+1;

kernel = zeros(kernel_size, 1);
Hv = zeros(height, width, size(kernel,1));

kernel_range = -W:W;

for j = 1+W : width+W
    for p = 1+W : height+W % p
        q = p+kernel_range;
        Hv(p,j,:) = permeability(I(p,j,:), I(q,j,:), q, alpha, sigma, W, width);
    end
end


end

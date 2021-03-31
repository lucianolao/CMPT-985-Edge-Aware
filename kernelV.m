function [Hv] = kernelV(I, W, alpha, sigma)

height = size(I,1);
width = size(I,2);

kernel_size = W*2+1;

kernel = zeros(kernel_size, 1);
Hv = zeros(height, width, size(kernel,1));

for j = 1:width
    for p = 1:height % p
        k = 0;
        for kernel_range = -W:W
            k = k+1;
            q = p+kernel_range;
            if q < 1 || q > height
                kernel(k) = 0;
            else
                kernel(k) = permeability(I(p,j,:), I(q,j,:), alpha, sigma);
            end
        end
        kernel = kernel / sum(kernel);
        Hv(p,j,:) = kernel;
    end
end


end

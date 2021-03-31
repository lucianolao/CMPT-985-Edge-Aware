function [Hh] = kernelH(I, W, alpha, sigma)

height = size(I,1);
width = size(I,2);

kernel_size = W*2+1;

kernel = zeros(kernel_size, 1);
Hh = zeros(height, width, size(kernel,1));

for i = 1:height
    for p = 1:width % p
        k = 0;
        for kernel_range = -W:W
            k = k+1;
            q = p+kernel_range;
            if q < 1 || q > width
                kernel(k) = 0;
            else
                kernel(k) = permeability(I(i,p,:), I(i,q,:), alpha, sigma);
            end
        end
        kernel = kernel / sum(kernel);
        Hh(i,p,:) = kernel;
    end
end


end

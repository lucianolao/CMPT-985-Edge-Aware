function [Hv] = kernelV(I, W, alpha, sigma)

height = size(I,1) - W*2;
width = size(I,2) - W*2;

kernel_size = W*2+1;
% channels
% ch = ndims(I);

% kernel = zeros(kernel_size, 1);

Hv = zeros(height, width, kernel_size);

% channels
% Hv = zeros(height, width, kernel_size, ch);

kernel_range = -W:W;

for j = 1+W : width+W
    for p = 1+W : height+W % p
        q = p+kernel_range;
        Hv(p-W,j-W,:) = permeability(I(p,j,:), I(q,j,:), q, alpha, sigma, W, width);
        
        % channels
%         Hv(p-W,j-W,:,1:ch) = permeability(I(p,j,:), I(q,j,:), q, alpha, sigma, W, width);
    end
end


end

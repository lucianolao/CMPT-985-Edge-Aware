function [Hh] = kernelH(I, W, alpha, sigma)

height = size(I,1) - W*2;
width = size(I,2) - W*2;

kernel_size = W*2+1;
% channels
% ch = ndims(I);

% kernel = zeros(kernel_size, 1);

Hh = zeros(height, width, kernel_size);

% channels
% Hh = zeros(height, width, kernel_size, ch);

kernel_range = -W:W;

for i = 1+W : height+W
    for p = 1+W : width+W % p
        q = p+kernel_range;
        Hh(i-W,p-W,:) = permeability(I(i,p,:), I(i,q,:), q, alpha, sigma, W, width+W);
        
        % channels
%         Hh(i-W,p-W,:,1:ch) = permeability(I(i,p,:), I(i,q,:), q, alpha, sigma, W, width+W);
    end
end


end

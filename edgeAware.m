function [J] = edgeAware(I, n_iterations, lambda, W, alpha, sigma, guide)

if nargin == 6
    guide = I;
    disp("Edge-Aware filtering...");
elseif nargin == 7
    if size(I,1) ~= size(guide,1) || size(I,2) ~= size(guide,2)
        guide = imresize(guide,[size(I,1) size(I,2)]);
    end
    disp("Cross filtering...");
else
    error("Invalid number of parameters");
end

height = size(I,1);
width = size(I,2);

ch = ndims(I);
% channels
% kernel_size = W*2+1;

I = padarray(I,[W W]);
J = I;
guide = padarray(guide,[W W]);

% G = rgb2gray(I);
[Hh] = kernelH(guide, W, alpha, sigma);
[Hv] = kernelV(guide, W, alpha, sigma);

% channels
% [Hh] = kernelH(I, W, alpha, sigma);
% [Hv] = kernelV(I, W, alpha, sigma);

kernel_range = -W:W;

for iter = 1:n_iterations
    % Horizontal
    Jnew = zeros(size(J));
    % J(1:W, 1:W, :) = 0;
    % J(height+W:end, width+W:end, :) = 0;
    for i = 1+W : height+W
        for p = 1+W : width+W % p
            q = p+kernel_range;
            
            h = permute(Hh(i-W,p-W,:),[1 3 2]);
            h2 = repmat(h, [1 1 ch]) .* J(i,q,:);
            % h2(1, W+1, :) = 0; % removing I_p*hpp
            h3 = sum(h2,2);
            hpp = h(W+1);
            Jnew(i,p,:) = h3 + lambda*hpp .* (I(i,p,:) - J(i,p,:));
%             Jnew(i,p,:) = h + lambda*h2(1,11,:) .* (I(i,p,:) - J(i,p,:));
            
%             for z = 1:3
%                 h = squeeze(Hh(i-W,p-W,:)) .* squeeze(J(i,q,z)');
%                 h = sum(h);
%                 Jnew(i,p,z) = h + lambda .* (I(i,p,z) - J(i,p,z));
%             end
            
            % channels
%             h = reshape(Hh(i-W,p-W,:,1:ch), [1 kernel_size ch 1]) .* J(i,q,:);
%             h2 = sum(h,2);
%             hpp = h(1,W+1,:);
%             Jnew(i,p,:) = h2 + lambda.*hpp .* (I(i,p,:) - J(i,p,:));
        end
    end
    J = Jnew;
    
    % break;
    
    % Vertical
    Jnew = zeros(size(J));
    % J(1:W, 1:W, :) = 0;
    % J(height+W:end, width+W:end, :) = 0;
    for j = 1+W : width+W
        for p = 1+W : height+W % p
            q = p+kernel_range;
            
            h = permute(Hv(p-W,j-W,:),[3 1 2]);
            h2 = repmat(h, [1 1 ch]) .* J(q,j,:);
            % h2(W+1, 1, :) = 0; % removing I_p*hpp
            h3 = sum(h2,1);
            hpp = h(W+1);
            Jnew(p,j,:) = h3 + lambda*hpp .* (I(p,j,:) - J(p,j,:));
%             Jnew(p,j,:) = h + lambda*lambda*h2(11,1,:) .* (I(p,j,:) - J(p,j,:));
              
%             for z = 1:3
%                 h = squeeze(Hh(p-W,j-W,:)) .* squeeze(J(q,j,z));
%                 h = sum(h);
%                 Jnew(p,j,z) = h + lambda .* (I(p,j,z) - J(p,j,z));
%             end
            
            % channels
%             h = reshape(Hv(p-W,j-W,:,1:ch), [kernel_size 1 ch 1]) .* J(q,j,:);
%             h2 = sum(h,1);
%             hpp = h(W+1,1,:);
%             Jnew(p,j,:) = h2 + lambda.*hpp .* (I(p,j,:) - J(p,j,:));
        end
    end
    J = Jnew;
    
end

J = J(1+W : height+W, 1+W : width+W, :);

end

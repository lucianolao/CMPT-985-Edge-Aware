function [J] = edgeAware(I, n_iterations, lambda, W, alpha, sigma)

height = size(I,1);
width = size(I,2);

ch = ndims(I);
% channels
% kernel_size = W*2+1;

I = padarray(I,[W W]);
J = I;

G = rgb2gray(I);
[Hh] = kernelH(G, W, alpha, sigma);
[Hv] = kernelV(G, W, alpha, sigma);

% channels
% [Hh] = kernelH(I, W, alpha, sigma);
% [Hv] = kernelV(I, W, alpha, sigma);

kernel_range = -W:W;

for iter = 1:n_iterations
    % Horizontal
    Jnew = zeros(size(J));
    for i = 1+W : height+W
        for p = 1+W : width+W % p
            q = p+kernel_range;
            
            h = permute(Hh(i-W,p-W,:),[1 3 2]);
            h = repmat(h, [1 1 ch]) .* J(i,q,:);
            h = sum(h,2);
            Jnew(i,p,:) = h + lambda .* (I(i,p,:) - J(i,p,:));
            
            % channels
%             h = reshape(Hh(i-W,p-W,:,1:ch), [1 kernel_size ch 1]) .* J(i,q,:);
%             h = sum(h,2);
%             Jnew(i,p,:) = h + lambda .* (I(i,p,:) - J(i,p,:));
        end
    end
    J = Jnew;
    
    % break;
    
    % Vertical
    Jnew = zeros(size(J));
    for j = 1+W : width+W
        for p = 1+W : height+W % p
            q = p+kernel_range;
            
            h = permute(Hv(p-W,j-W,:),[3 1 2]);
            h = repmat(h, [1 1 ch]) .* J(q,j,:);
            h = sum(h,1);
            Jnew(p,j,:) = h + lambda .* (I(p,j,:) - J(p,j,:));
            
            % channels
%             h = reshape(Hv(p-W,j-W,:,1:ch), [kernel_size 1 ch 1]) .* J(q,j,:);
%             h = sum(h,1);
%             Jnew(p,j,:) = h + lambda .* (I(p,j,:) - J(p,j,:));
        end
    end
    J = Jnew;
    
end

J = J(1+W : height+W, 1+W : width+W, :);

end

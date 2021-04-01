function [J] = edgeAware(I, n_iterations, lambda, W, alpha, sigma)

height = size(I,1);
width = size(I,2);

n_dims = ndims(I);

I = padarray(I,[W W]);
J = I;

[Hh] = kernelH(I, W, alpha, sigma);
[Hv] = kernelV(I, W, alpha, sigma);

kernel_range = -W:W;

for iter = 1:n_iterations
    % Horizontal
    Jnew = zeros(size(J));
    for i = 1+W : height+W
        for p = 1+W : width+W % p
            q = p+kernel_range;
            h = permute(Hh(i,p,:),[1 3 2]);
            h = repmat(h, [1 1 n_dims]) .* J(i,q,:);
            h = sum(h,2);
            Jnew(i,p,:) = h + lambda .* (I(i,p,:) - J(i,p,:));
        end
    end
    J = Jnew;
    
    % break;
    
    % Vertical
    Jnew = zeros(size(J));
    for j = 1+W : width+W
        for p = 1+W : height+W % p
            q = p+kernel_range;
            h = permute(Hv(p,j,:),[3 1 2]);
            h = repmat(h, [1 1 n_dims]) .* J(q,j,:);
            h = sum(h,1);
            Jnew(p,j,:) = h + lambda .* (I(p,j,:) - J(p,j,:));
        end
    end
    J = Jnew;
    
end

J = J(W+1 : height+W, 1+W : width+W, :);

end

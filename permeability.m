function [pi] = permeability(Ip, Iq, q, alpha, sigma, W, border)
    
    if ndims(Iq) == 2
        pi = 1 + ( (Ip-Iq).^alpha / sigma^alpha );
    elseif ndims(Iq) == 3
        ch_1 = ( Ip(:,:,1)-Iq(:,:,1) ) .^ alpha;
        ch_2 = ( Ip(:,:,2)-Iq(:,:,2) ) .^ alpha;
        ch_3 = ( Ip(:,:,3)-Iq(:,:,3) ) .^ alpha;
        pi = 1 + ( (ch_1+ch_2+ch_3) / sigma^alpha );
    else
        error("Invalid number of dimensions");
    end
    
    pi = 1./pi;
    pi(q<=W) = 0;
    pi(q>border) = 0;
    pi = pi / sum(pi);
    
end

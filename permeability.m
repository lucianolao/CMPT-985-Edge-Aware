function [pi] = permeability(p1, p2, alpha, sigma)

    if ndims(p1) == 1
        pi = 1 + ( (p1-p2).^alpha / sigma^alpha );
        pi = 1/pi;
    elseif ndims(p1) == 3
        ch_1 = ( p1(:,:,1)-p2(:,:,1) ) .^ alpha;
        ch_2 = ( p1(:,:,2)-p2(:,:,2) ) .^ alpha;
        ch_3 = ( p1(:,:,3)-p2(:,:,3) ) .^ alpha;
        pi = 1 + ( (ch_1+ch_2+ch_3) / sigma^alpha );
        pi = 1/pi;
    else
        error("Invalid number of dimensions");
    end    

end

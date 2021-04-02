function [pi] = permeability(Ip, Iq, q, alpha, sigma, W, border)
    
    if ndims(Iq) == 2
        pi = 1 + ( (Ip-Iq).^alpha / sigma^alpha );
        % pi = 1 + (abs(Ip-Iq) ./ sigma ).^alpha;
        
        pi = 1./pi;
        pi(q<=W) = 0;
        pi(q>border) = 0;
        pi = pi / sum(pi);
        
    elseif ndims(Iq) == 3
        ch_1 = ( Ip(:,:,1)-Iq(:,:,1) ) .^ alpha;
        ch_2 = ( Ip(:,:,2)-Iq(:,:,2) ) .^ alpha;
        ch_3 = ( Ip(:,:,3)-Iq(:,:,3) ) .^ alpha;
        
        pi = 1 + ( (ch_1+ch_2+ch_3) / sigma^alpha );
        pi = 1./pi;
        pi(q<=W) = 0;
        pi(q>border) = 0;
        pi = pi / sum(pi);
        
        % channels
%         if size(ch_1,1) == 1
%             % always dimension [kernel_size x 1]
%             ch_1 = ch_1';
%             ch_2 = ch_2';
%             ch_3 = ch_3';
%         end
%         
%         pi_1 = 1 + ( ch_1 / sigma^alpha );
%         pi_2 = 1 + ( ch_2 / sigma^alpha );
%         pi_3 = 1 + ( ch_3 / sigma^alpha );
%         
%         pi_1 = 1./pi_1;
%         pi_1(q<=W) = 0;
%         pi_1(q>border) = 0;
%         pi_1 = pi_1 / sum(pi_1);
%         
%         pi_2 = 1./pi_2;
%         pi_2(q<=W) = 0;
%         pi_2(q>border) = 0;
%         pi_2 = pi_2 / sum(pi_2);
%         
%         pi_3 = 1./pi_3;
%         pi_3(q<=W) = 0;
%         pi_3(q>border) = 0;
%         pi_3 = pi_3 / sum(pi_3);
%         
%         pi = [pi_1 pi_2 pi_3];
        
    else
        error("Invalid number of dimensions");
    end
    
end

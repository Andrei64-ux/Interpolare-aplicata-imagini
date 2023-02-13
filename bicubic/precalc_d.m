function [Ix, Iy, Ixy] = precalc_d(I)
    % =========================================================================
    % Prealculeaza matricile Ix, Iy si Ixy ce contin derivatele dx, dy, dxy ale 
    % imaginii I pentru fiecare pixel al acesteia
    % =========================================================================
    
    % obtine dimensiunea imaginii
    [m n nr_colors] = size(I);
    
    % TODO: fa cast matricii I la double
    I = double(I);
    Ix=zeros(m,n);
    Iy=zeros(m,n);
    Ixy=zeros(m,n);
    % TODO: calculeaza matricea cu derivate fata de x Ix
    for x=1:m
      for y=1:n
        if y > 1 && y < n 
          Ix(x,y) = fx(I,x,y);
        endif
        if x > 1 && x < m 
          Iy(x,y) = fy(I,x,y);
        endif
        if y > 1 && y < n && x > 1 && x < m 
          Ixy(x,y) = fxy(I,x,y);
        endif
      endfor
    endfor
    % TODO: calculeaza matricea cu derivate fata de y Iy

    % TODO: calculeaza matricea cu derivate fata de xy Ixy

endfunction

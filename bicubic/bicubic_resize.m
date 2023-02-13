function R = bicubic_resize(I, p, q)
    % =========================================================================
    % Upscaling de imagine folosind algoritmul de interpolare bicubica
    % Transforma imaginea I din dimensiune m x n in dimensiune p x q
    % =========================================================================

    [m n nr_colors] = size(I);

    % convertestete imaginea de intrare la alb-negru daca este cazul
    if nr_colors > 1
        R = -1;
        return
    endif

    % initializeaza matricea finala
    R = zeros(p, q);
    
    I=double(I);
    % Obs:
    % Atunci cand se aplica o scalare, punctul (0, 0) al imaginii nu se va
    % deplasa.
    % In Octave, pixelii imaginilor sunt indexati de la 1 la n.
    % Daca se lucreaza in indici de la 1 la n si se inmulteste x si y cu s_x
    % si s_y, atunci originea imaginii se va deplasa de la (1, 1) la (sx, sy)!
    % De aceea, trebuie lucrat cu indici in intervalul de la 0 la n - 1!

    % TODO: calculeaza factorii de scalare
    % Obs: daca se lucreaza cu indici in intervalul [0, n - 1], ultimul
    % pixel al imaginii se va deplasa de la (m - 1, n - 1) la (p, q).
    % s_x nu va fi q ./ n
    s_x = (q-1) ./ (n-1);
    s_y = (p-1) ./ (m-1);
    % TODO: defineste matricea de transformare pentru redimensionare
    T = [s_x 0;0 s_y];
    % TODO: calculeaza inversa transformarii
    T_inv = [1 ./s_x 0;0 1 ./s_y];
    % parcurge fiecare pixel din imagine
    [Ix, Iy, Ixy] = precalc_d(I);
    % foloseste coordonate de la 0 la n - 1
    for y = 0 : p - 1
        for x = 0 : q - 1
             % TODO: aplica transformarea inversa asupra (x, y) si calculeaza
            % x_p si y_p din spatiul imaginii initiale
            coord = T_inv*[x , y]';
            % TODO: trece (xp, yp) din sistemul de coordonate de la 0 la n - 1 in
            % sistemul de coordonate de la 1 la n pentru a aplica interpolarea
            x_p = coord(1)+1;
            y_p = coord(2)+1;
            % TODO: calculeaza cel mai apropiat vecin
            R(y+1,x+1) = get_bicubic_neighbour(I,Ix,Iy,Ixy,y_p,x_p);
            % TODO: calculeaza valoarea pixelului din imaginea finala
        endfor
    endfor

    % TODO: converteste matricea rezultat la uint8
    R = cast(R, "uint8");
endfunction

function out = get_bicubic_neighbour(f,fx,fy,fxy,i, j)
    [m, n] = size(f);
    if floor(j) < n
        x1 = floor(j);
        x2 = floor(j) + 1;
    else
        x1 = floor(j) - 1;
        x2 = floor(j);
    endif
    if floor(i) < m
        y1 = floor(i);
        y2 = floor(i) + 1;
    else
        y1 = floor(i) - 1;
        y2 = floor(i);
    endif
    i-=y1;
    j-=x1;
    A = bicubic_coef(f,fx,fy,fxy, x1, y1, x2, y2);
    out = [1 j j^2 j^3]*A*[1 i i^2 i^3]';
endfunction
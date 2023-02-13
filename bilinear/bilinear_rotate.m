
function R = bilinear_rotate(I, rotation_angle)
    % =========================================================================
    % Roteste imaginea alb-negru I de dimensiune m x n cu unghiul
    % rotation_angle, aplicand interpolare biliniara.
    % rotation_angle este exprimat in radiani.
    % =========================================================================
    
    [m n nr_colors] = size(I);
    
    % daca imaginea e alb negru, ignora
    if nr_colors > 1
        R = -1;
        return
    endif
    I=double(I);
    % Obs:
    % Atunci cand se aplica o scalare, punctul (0, 0) al imaginii nu se va
    % deplasa.
    % In Octave, pixelii imaginilor sunt indexati de la 1 la n.
    % Daca se lucreaza in indici de la 1 la n si se inmulteste x si y cu s_x
    % si s_y, atunci originea imaginii se va deplasa de la (1, 1) la (sx, sy)!
    % De aceea, trebuie lucrat cu indici in intervalul de la 0 la n - 1!

    % TODO: calculeaza cos si sin de rotation_angle
    T = [cos(rotation_angle) -sin(rotation_angle);sin(rotation_angle) cos(rotation_angle)];
    % TODO: initializeaza matricea finala
    R=zeros(m,n);
    % TODO: calculeaza matricea de transformare

    % TODO: calculeaza inversa transformarii
    inv_T=[cos(rotation_angle) sin(rotation_angle);-sin(rotation_angle) cos(rotation_angle)];
    % parcurge fiecare pixel din imagine
    % foloseste coordonate de la 0 la n - 1
    for y = 0 : m - 1
        for x = 0 : n - 1
            % TODO: aplica transformarea inversa asupra (x, y) si calculeaza
            % x_p si y_p din spatiul imaginii initiale
            coord = inv_T*[x,y]';
            % trece (xp, yp) din sistemul de coordonate de la 0 la n - 1 in
            % sistemul de coordonate de la 1 la n pentru a aplica interpolarea
            x_p=coord(1)+1;
            y_p=coord(2)+1;
            % TODO: daca xp sau yp se afla in afara imaginii, pune un pixel
            % negru in imagine si treci mai departe
            if x_p < 1 || y_p < 1 || x_p > n || y_p > m
              R(y+1,x+1) = 0;
            else
              R(y+1,x+1) = get_bilinear_neighbour(I,y_p,x_p);
            endif
            % TODO: afla punctele ce inconjoara punctul (xp, yp)

            % TODO: calculeaza coeficientii de interpolare a

            % TODO: calculeaza valoarea interpolata a pixelului (x, y)
            % Obs: pentru scrierea in imagine, x si y sunt in coordonate de
            % la 0 la n - 1 si trebuie aduse in coordonate de la 1 la n
        
        endfor
    endfor
    
    R = cast(R,"uint8");
    % transforma matricea rezultat in uint8 pentru a fi o imagine valida
    
endfunction

function out = get_bilinear_neighbour(f, i, j)
    [m, n] = size(f);
    if floor(j) < n
        x1 = floor(j);
        x2 = floor(j + 1);
    else
        x1 = floor(j) - 1;
        x2 = floor(j);
    endif
    if floor(i) < m
        y1 = floor(i);
        y2 = floor(i + 1);
    else
        y1 = floor(i) - 1;
        y2 = floor(i);
    endif
    a = bilinear_coef(f, x1, y1, x2, y2);
    out = a(1) + a(2) * j + a(3) * i + a(4) * j * i ;
endfunction

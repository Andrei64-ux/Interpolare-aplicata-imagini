function out = bilinear_rotate_RGB(img, rotation_angle)
    % =========================================================================
    % Aplica interpolare bilineara pentru a roti o imagine RGB cu un unghi dat.
    % =========================================================================
    
    % TODO: extrage canalul rosu al imaginii
    red = img(:,:,1);
    % TODO: extrage canalul verde al imaginii
    green = img(:,:,2);
    % TODO: extrace canalul albastru al imaginii
    blue = img(:,:,3);
    % TODO: aplica functia nn pe cele 3 canale ale imaginii
    out_red = bilinear_rotate(red , rotation_angle);
    out_green = bilinear_rotate(green , rotation_angle);
    out_blue = bilinear_rotate(blue , rotation_angle);
    % TODO: formeaza imaginea finala cu cele 3 canale de culori
    out = cat(3,out_red,out_green,out_blue);
    % Hint: functia cat
    
endfunction
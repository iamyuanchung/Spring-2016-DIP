function C = attachTexture(S8, L)

[m, n] = size(S8);

% locate the proper textures for zebra, leopard, and giraffe and draw the
% bounding box
O = S8;
% locate the texture of zebra
zebra_upper_left_i = 70;
zebra_upper_left_j = 185;
zebra_texture_size = 25;
zebra_texture = S8(zebra_upper_left_i:zebra_upper_left_i + zebra_texture_size, zebra_upper_left_j:zebra_upper_left_j + zebra_texture_size);
O(zebra_upper_left_i - 1, zebra_upper_left_j - 1:zebra_upper_left_j + zebra_texture_size) = 0;
O(zebra_upper_left_i + zebra_texture_size, zebra_upper_left_j - 1:zebra_upper_left_j + zebra_texture_size) = 0;
O(zebra_upper_left_i - 1:zebra_upper_left_i + zebra_texture_size, zebra_upper_left_j - 1) = 0;
O(zebra_upper_left_i - 1:zebra_upper_left_i + zebra_texture_size, zebra_upper_left_j + zebra_texture_size) = 0;
% locate the texture of leopard
leopard_upper_left_i = 350;
leopard_upper_left_j = 170;
leopard_texture_size = 50;
leopard_texture = S8(leopard_upper_left_i:leopard_upper_left_i + leopard_texture_size, leopard_upper_left_j:leopard_upper_left_j + leopard_texture_size);
O(leopard_upper_left_i - 1, leopard_upper_left_j - 1:leopard_upper_left_j + leopard_texture_size) = 0;
O(leopard_upper_left_i + leopard_texture_size, leopard_upper_left_j - 1:leopard_upper_left_j + leopard_texture_size) = 0;
O(leopard_upper_left_i - 1:leopard_upper_left_i + leopard_texture_size, leopard_upper_left_j - 1) = 0;
O(leopard_upper_left_i - 1:leopard_upper_left_i + leopard_texture_size, leopard_upper_left_j + leopard_texture_size) = 0;
% locate the texture of giraffe
giraffe_upper_left_i = 220;
giraffe_upper_left_j = 440;
giraffe_texture_size = 30;
giraffe_texture = S8(giraffe_upper_left_i:giraffe_upper_left_i + giraffe_texture_size, giraffe_upper_left_j:giraffe_upper_left_j + giraffe_texture_size);
O(giraffe_upper_left_i - 1, giraffe_upper_left_j - 1:giraffe_upper_left_j + giraffe_texture_size) = 255;
O(giraffe_upper_left_i + giraffe_texture_size, giraffe_upper_left_j - 1:giraffe_upper_left_j + giraffe_texture_size) = 255;
O(giraffe_upper_left_i - 1:giraffe_upper_left_i + giraffe_texture_size, giraffe_upper_left_j - 1) = 255;
O(giraffe_upper_left_i - 1:giraffe_upper_left_i + giraffe_texture_size, giraffe_upper_left_j + giraffe_texture_size) = 255;
% imshow(uint8(O));
% attach the textures onto the corresponding animals
zebra_pure = zeros(m, n);
for i = 1:leopard_texture_size:m
    for j = 1:leopard_texture_size:n
        zebra_pure(i:i + leopard_texture_size, j:j + leopard_texture_size) = leopard_texture;
    end
end
zebra_pure = zebra_pure(1:m, 1:n);
for i = 1:m
    for j = 1:n
        if L(i, j) ~= 160
            zebra_pure(i, j) = 255;
        end
    end
end

leopard_pure = zeros(m, n);
for i = 1:giraffe_texture_size:m
    for j = 1:giraffe_texture_size:n
        leopard_pure(i:i + giraffe_texture_size, j:j + giraffe_texture_size) = giraffe_texture;
    end
end
leopard_pure = leopard_pure(1:m, 1:n);
for i = 1:m
    for j = 1:n
        if L(i, j) ~= 80
            leopard_pure(i, j) = 255;
        end
    end
end

giraffe_pure = zeros(m, n);
for i = 1:zebra_texture_size:m
    for j = 1:zebra_texture_size:n
        giraffe_pure(i:i + zebra_texture_size, j:j + zebra_texture_size) = zebra_texture;
    end
end
giraffe_pure = giraffe_pure(1:m, 1:n);
for i = 1:m
    for j = 1:n
        if L(i, j) ~= 0
            giraffe_pure(i, j) = 255;
        end
    end
end

C = S8; % to keep the background the same as S8
for i = 1:256
    for j = 1:300
        if L(i, j) == 160
            C(i, j) = zebra_pure(i, j);
        end
    end
end
for i = 270:m
    for j = 400:n
        if L(i, j) == 80
            C(i, j) = leopard_pure(i, j);
        end
    end
end
for i = 1:m
    for j = 260:n
        if L(i, j) == 0
            C(i, j) = giraffe_pure(i, j);
        end
    end
end
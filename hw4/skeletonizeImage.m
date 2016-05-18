function G = skeletonizeImage(F)


[m, n] = size(F);

% define the conditional mark patterns for used in stage 1
patts = [0, 0, 1; 0, 1, 1; 0, 0, 1];
for i = 1:3
    patts(:, :, i + 1) = rot90(patts(:, :, 1), i);
end

patts(:, :, 5) = [1, 1, 1; 0, 1, 1; 0, 0, 0];
for i = 1:3
    patts(:, :, i + 5) = rot90(patts(:, :, 5), i);
end

patts(:, :, 9) = [0, 1, 1; 0, 1, 1; 0, 0, 1];
for i = 1:3
    patts(:, :, i + 9) = rot90(patts(:, :, 9), i);
end

patts(:, :, 13) = [1, 1, 1; 0, 1, 1; 0, 0, 1];
for i = 1:3
    patts(:, :, i + 13) = rot90(patts(:, :, 13), i);
end

patts(:, :, 17) = [0, 1, 1; 0, 1, 1; 0, 1, 1];
for i = 1:3
    patts(:, :, i + 17) = rot90(patts(:, :, 17), i);
end

patts(:, :, 21) = [1, 1, 1; 0, 1, 1; 0, 1, 1];
for i = 1:3
    patts(:, :, i + 21) = rot90(patts(:, :, 21), i);
end

patts(:, :, 25) = [0, 1, 1; 0, 1, 1; 1, 1, 1];
for i = 1:3
    patts(:, :, i + 25) = rot90(patts(:, :, 25), i);
end

patts(:, :, 29) = [1, 1, 1; 0, 1, 1; 1, 1, 1];
for i = 1:3
    patts(:, :, i + 29) = rot90(patts(:, :, 29), i);
end

patts(:, :, 33) = [0, 1, 0; 0, 1, 1; 0, 0, 0];
for i = 1:3
    patts(:, :, i + 33) = rot90(patts(:, :, 33), i);
end

patts(:, :, 37) = [1, 1, 1; 1, 1, 1; 0, 1, 1];
for i = 1:3
    patts(:, :, i + 37) = rot90(patts(:, :, 37), i);
end

patts = patts * 255;

% define a part of the conditional mark patterns used in stage 2
spur = [0, 0, 0; 0, 1, 0; 0, 0, 1];
sing = [0, 0, 0; 0, 1, 0; 0, 1, 0];
Lcor = [0, 1, 0; 0, 1, 1; 0, 0, 0];

% extend the boundary of F
F_extend = wextend('2D', 'sym', F, 1);
F_prev = F_extend;
epoch = 1;
while (1)
    % Stage 1: generate binary image M(i, j) called the conditional mask -
    %          M(i, j) = 1 if F(i, j) is a candidate for erasure;
    %          M(i, j) = 0 if no further operation is needed on F(i, j)
    M = zeros(m, n);
    for i = 1:m
        for j = 1:n
            if (F(i, j) == 255)
                for k = 1:40
                    if (F_extend(i:i + 2, j:j + 2) == patts(:, :, k))
                        M(i, j) = 1;
                        break;
                    end
                end
            end
        end
    end

    % uncomment this line if you want to savet the conditioned mask
    % generated in each epoch
    imwrite(uint8(M * 255), ['./rslt_images/epoch', num2str(epoch), '.png']);
    epoch = epoch + 1;

    % Stage 2: decide whether to erase the center pixel based on the
    % conditional mask M
    M_extend = wextend('2D', 'sym', M, 1);

    for i = 1:m
        for j = 1:n
            if (M(i, j) == 1)
                hit = 0;
                % Spur
                for k = 0:3
                    if (M_extend(i:i + 2, j:j + 2) == rot90(spur, k))
                        hit = 1;
                        break;
                    end
                end
                % only if hit = 0 should we need to further check other
                % patterns
                if (hit == 0)
                    % Single 4-connection
                    for k = 0:3
                        if (M_extend(i:i + 2, j:j + 2) == rot90(sing, k))
                            hit = 1;
                            break;
                        end
                    end
                end
                if (hit == 0)
                    % L corner
                    for k = 0:3
                        if (M_extend(i:i + 2, j:j + 2) == rot90(Lcor, k))
                            hit = 1;
                            break;
                        end
                    end
                end
                if (hit == 0)
                    % Corner cluster
                    if (M_extend(i:i + 1, j:j + 1) == ones(2, 2))
                        hit = 1;
                    end
                    if (M_extend(i + 1:i + 2, j + 1:j + 2) == ones(2, 2))
                        hit = 1;
                    end
                    % these two patterns do not appear in the pattern
                    % tables but show better result when including them!
                    if (M_extend(i:i + 1, j + 1:j + 2) == ones(2, 2))
                        hit = 1;
                    end
                    if (M_extend(i + 1:i + 2, j:j + 1) == ones(2, 2))
                        hit = 1;
                    end
                end
                if (hit == 0)
                    % Tee branch
                    if ((M_extend(i, j + 1) == 1 && M_extend(i + 1, j) == 1 && M_extend(i + 1, j + 1) == 1 && M_extend(i + 1, j + 2) == 1)     ...
                     || (M_extend(i, j + 1) == 1 && M_extend(i + 1, j) == 1 && M_extend(i + 1, j + 1) == 1 && M_extend(i + 2, j + 1) == 1)     ...
                     || (M_extend(i + 1, j) == 1 && M_extend(i + 1, j + 1) == 1 && M_extend(i + 1, j + 2) == 1 && M_extend(i + 2, j + 1) == 1) ...
                     || (M_extend(i, j + 1) == 1 && M_extend(i + 1, j + 1) == 1 && M_extend(i + 1, j + 2) == 1 && M_extend(i + 2, j + 1) == 1))
                        hit = 1;
                    end
                end
                if (hit == 0)
                    % Vee branch
                    if ((M_extend(i, j) == 1 && M_extend(i, j + 2) == 1 && M_extend(i + 1, j + 1) == 1 && (M_extend(i + 2, j) == 1 || M_extend(i + 2, j + 1) == 1 || M_extend(i + 2, j + 2) == 1)) ...
                     || (M_extend(i, j) == 1 && M_extend(i + 1, j + 1) == 1 && M_extend(i + 2, j) == 1 && (M_extend(i, j + 2) == 1 || M_extend(i + 1, j + 2) == 1 || M_extend(i + 2, j + 2) == 1)) ...
                     || (M_extend(i + 1, j + 1) == 1 && M_extend(i + 2, j) == 1 && M_extend(i + 2, j + 2) == 1 && (M_extend(i, j) == 1 || M_extend(i, j + 1) == 1 || M_extend(i, j + 2) == 1))     ...
                     || (M_extend(i, j + 2) == 1 && M_extend(i + 1, j + 1) == 1 && M_extend(i + 2, j + 2) == 1 && (M_extend(i, j) == 1 || M_extend(i + 1, j) == 1 || M_extend(i + 2, j) == 1)))
                        hit = 1;
                    end
                end
                if (hit == 0)
                    % Diagonal branch
                    if ((M_extend(i, j + 1) == 1 && M_extend(i, j + 2) == 0 && M_extend(i + 1, j) == 0 && M_extend(i + 1, j + 1) == 1 && M_extend(i + 1, j + 2) == 1 && M_extend(i + 2, j) == 1 && M_extend(i + 2, j + 1) == 0) ...
                     || (M_extend(i, j) == 0 && M_extend(i, j + 1) == 1 && M_extend(i + 1, j) == 1 && M_extend(i + 1, j + 1) == 1 && M_extend(i + 1, j + 2) == 0 && M_extend(i + 2, j + 1) == 0 && M_extend(i + 2, j + 2) == 1) ...
                     || (M_extend(i, j + 1) == 0 && M_extend(i, j + 2) == 1 && M_extend(i + 1, j) == 1 && M_extend(i + 1, j + 1) == 1 && M_extend(i + 1, j + 2) == 0 && M_extend(i + 2, j) == 0 && M_extend(i + 2, j + 1) == 1) ...
                     || (M_extend(i, j) == 1 && M_extend(i, j + 1) == 0 && M_extend(i + 1, j) == 0 && M_extend(i + 1, j + 1) == 1 && M_extend(i + 1, j + 2) == 1 && M_extend(i + 2, j + 1) == 1 && M_extend(i + 2, j + 2) == 0))
                        hit = 1;
                    end
                end
                % If there¡¦s a miss - erase the center pixel
                if (hit == 0)
                    F_extend(i + 1, j + 1) = 0;
                end
            end
        end
    end
    if (F_extend == F_prev)
        break;
    end
    F_prev = F_extend;
end

G = F_extend(2:end - 1, 2:end - 1);
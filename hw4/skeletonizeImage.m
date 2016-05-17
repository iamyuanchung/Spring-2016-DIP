function SKT = skeletonizeImage(S2)


[m, n] = size(S2);

% extend the boundary of S2
S2_extend = wextend('2D', 'sym', S2, 1);

% define the conditional mark patterns for used in stage 1
STK_cond_mark_patts = [0, 0, 1; 0, 1, 1; 0, 0, 1];
for i = 1:3
    STK_cond_mark_patts(:, :, i + 1) = rot90(STK_cond_mark_patts(:, :, 1), i);
end

STK_cond_mark_patts(:, :, 5) = [1, 1, 1; 0, 1, 1; 0, 0, 0];
for i = 1:3
    STK_cond_mark_patts(:, :, i + 5) = rot90(STK_cond_mark_patts(:, :, 5), i);
end

STK_cond_mark_patts(:, :, 9) = [0, 1, 1; 0, 1, 1; 0, 0, 1];
for i = 1:3
    STK_cond_mark_patts(:, :, i + 9) = rot90(STK_cond_mark_patts(:, :, 9), i);
end

STK_cond_mark_patts(:, :, 13) = [1, 1, 1; 0, 1, 1; 0, 0, 1];
for i = 1:3
    STK_cond_mark_patts(:, :, i + 13) = rot90(STK_cond_mark_patts(:, :, 13), i);
end

STK_cond_mark_patts(:, :, 17) = [0, 1, 1; 0, 1, 1; 0, 1, 1];
for i = 1:3
    STK_cond_mark_patts(:, :, i + 17) = rot90(STK_cond_mark_patts(:, :, 17), i);
end

STK_cond_mark_patts(:, :, 21) = [1, 1, 1; 0, 1, 1; 0, 1, 1];
for i = 1:3
    STK_cond_mark_patts(:, :, i + 21) = rot90(STK_cond_mark_patts(:, :, 21), i);
end

STK_cond_mark_patts(:, :, 25) = [0, 1, 1; 0, 1, 1; 1, 1, 1];
for i = 1:3
    STK_cond_mark_patts(:, :, i + 25) = rot90(STK_cond_mark_patts(:, :, 25), i);
end

STK_cond_mark_patts(:, :, 29) = [1, 1, 1; 0, 1, 1; 1, 1, 1];
for i = 1:3
    STK_cond_mark_patts(:, :, i + 29) = rot90(STK_cond_mark_patts(:, :, 29), i);
end

STK_cond_mark_patts = STK_cond_mark_patts * 255;

% define the conditional mark patterns used in stage 2
spur = [0, 0, 0; 0, 1, 0; 0, 0, 1];
sing = [0, 0, 0; 0, 1, 0; 0, 1, 0];
Lcor = [0, 1, 0; 0, 1, 1; 0, 0, 0];

SKT = S2;
epoch = 1;
% debug
M_prev = zeros(m, n);
while (1)
    fprintf('%d\n', epoch);
    epoch = epoch + 1;
    % Stage 1: generate binary image M(i, j) called the conditional mask -
    %          M(i, j) = 1 if S2(i, j) is a candidate for erasure;
    %          M(i, j) = 0 if no further operation is needed on S2(i, j)
    M = zeros(m, n);
    for i = 1:m
        for j = 1:n
            for k = 1:32
                if (S2_extend(i:i + 2, j:j + 2) == STK_cond_mark_patts(:, :, k))
                    M(i, j) = 1;
                    break
                end
            end
        end
    end

    if (M_prev == M)
        break;
    end
    M_prev = M;

    % imwrite(uint8(M * 255), './rslt_images/Stage1.png');

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
                end
                if (hit == 0)
                    % Tee branch
                    if ((M_extend(i, j + 1) == 1 && M_extend(i + 1, j) == 1 && M_extend(i + 1, j + 1) == 1 && M_extend(i + 1, j + 2) == 1)     ...
                     || (M_extend(i, j + 1) == 1 && M_extend(i + 1, j) == 1 && M_extend(i + 1, j + 1) == 1 && M_extend(i + 2, j + 1) == 1)     ...
                     || (M_extend(i + 1, j) == 1 && M_extend(i + 1, j + 1) == 1 && M_extend(i + 1, j + 2) == 1 && M_extend(i + 2, j + 1) == 1) ...
                     || (M_extend(i, j + 1) == 1 && M_extend(i + 1, j + 1) == 1 && M_extend(i + 1, j + 2) == 1 && M_extend(i + 2, j + 2) == 1))
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
                    SKT(i, j) = 0;
                end
            end
        end
    end
end
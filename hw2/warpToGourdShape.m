function G = warpToGourdShape(S)
% ####################################################################### %
% warpToGourdShape:
%                                                                         %
%   Usage:                                                                %
%       G = warpToGourdShape(S)                                           %
%                                                                         %
%   Reference:                                                            %
%       [1] 
% ####################################################################### %

all_coordinate = zeros(2, 512 * 512);
count = 1;
for i = 1:512
    for j = 1:512
        all_coordinate(1, count) = i;
        all_coordinate(2, count) = j;
        count = count + 1;
    end
end

G = zeros(size(S));

C_input = [
    289, 289, 289, 400, 400, 400, 512, 512, 512;
      1, 256, 512,   1, 256, 512,   1, 256, 512
];
C_target = [
    300, 289, 300, 400, 400, 400, 500, 512, 500;
     50, 256, 462,   1, 256, 512,  50, 256, 462
];
C_poly = C_target / [ones(1, 9); C_input; C_input(1, :) .^ 2; C_input(1, :) .* C_input(2, :); C_input(2, :) .^ 2];

C_coordinate = all_coordinate(:, 288 * 512 + 1:end);

% round(C_poly * [ones(1, 9); C_input; C_input(1, :) .^ 2; C_input(1, :) .* C_input(2, :); C_input(2, :) .^ 2])

C_transform_coordinate = round(C_poly * [ones(1, 224 * 512); C_coordinate; C_coordinate(1, :) .^ 2; C_coordinate(1, :) .* C_coordinate(2, :); C_coordinate(2, :) .^ 2]);
C_transform_coordinate(:, 1:157)

for i = 1:224 * 512
    if G(C_transform_coordinate(:, i)') == 0
        % fprintf('%d\n', i);
    %fprintf('%f, %f\n', G(C_transform_coordinate(:, i)'), S(C_coordinate(:, i)'));
        G(C_transform_coordinate(:, i)') = S(C_coordinate(:, i)');
    end
    % fprintf('%f, %f\n', G(C_transform_coordinate(:, i)'), S(C_coordinate(:, i)'));
end

% for i = 289:512
%     for j = 1:512
%         G(C_transform_coordinate()) = S();
%         count = count + 1;
%     end
% end

imshow(uint8(G));
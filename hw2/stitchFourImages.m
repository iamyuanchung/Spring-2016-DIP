function [R, S] = stitchFourImages(S4, S5, S6, S7)
% ####################################################################### %
% stitchFourImage: stitch S4, S5, S6, and S7 toghether as required        %
%                                                                         %
%   Usage:                                                                %
%       [R, S] = stitchFourImages(S4, S5, S6, S7)                         %
%                                                                         %
%   Description:                                                          %
%       The function is hard-coded and only suitable for taking S4 ~ S7   %
%       as inputs. The algorithm is designed somewhat heuristically and   %
%       its details are described in the report.                          %
%       In fact, I think this task should be better written as a script   %
%       instead of a function ...                                         %
% ####################################################################### %

% stitch S4 with S5 to locate the position (pos_i_45, pos_j_45) of the
% upper-left point of the overlapped rectangle
fprintf('\n    Stitching sample4.raw and sample5.raw ...\n');
pos_i_45 = 0;
pos_j_45 = 0;
max_match_num = -1;
for i = 100:324
    for j = 200:324
        cur_match_num = sum(sum(S4(i:324, j:324) == S5(1:325 - i, 1:325 - j)));
        if (cur_match_num > max_match_num)
            max_match_num = cur_match_num;
            pos_i_45 = i;
            pos_j_45 = j;
        end
    end
end
S_45 = zeros(323 + pos_i_45, 323 + pos_j_45);
S_45(1:324, 1:324) = S4;
S_45(pos_i_45:end, pos_j_45:end) = S5;
imwrite(uint8(S_45), './rslt_images/sample4_5.png');

% stitch S5 with S6 to locate the position (pos_i_56, pos_j_56) of the
% upper-right point of the overlapped rectangle
fprintf('\n    Stitching sample5.raw and sample6.raw ...\n');
pos_i_56 = 0;
pos_j_56 = 0;
max_match_num = -1;
for i = 170:324
    for j = 324:-1:1
        cur_match_num = sum(sum(S5(i:324, 1:j) == S6(1:325 - i, 325 - j:324)));
        if (cur_match_num > max_match_num)
            max_match_num = cur_match_num;
            pos_i_56 = i;
            pos_j_56 = j;
        end
    end
end
S_56 = zeros(323 + pos_i_56, 648 - pos_j_56);
S_56(1:324, end - 323:end) = S5;
S_56(pos_i_56:end, 1:324) = S6;
imwrite(uint8(S_56), './rslt_images/sample5_6.png');

% stitch S6 with S7 to locate the position (pos_i_67, pos_j_67) of the
% upper-left point of the overlapped rectangle
fprintf('\n    Stitching sample6.raw and sample7.raw ...\n');
pos_i_67 = 0;
pos_j_67 = 0;
max_match_num = -1;
for i = 1:324
    for j = 270:324
        cur_match_num = sum(sum(S7(i:324, j:324) == S6(1:325 - i, 1:325 - j)));
        if (cur_match_num > max_match_num)
            max_match_num = cur_match_num;
            pos_i_67 = i;
            pos_j_67 = j;
        end
    end
end
S_67 = zeros(323 + pos_i_67, 323 + pos_j_67);
S_67(1:324, 1:324) = S7;
S_67(pos_i_67:end, pos_j_67:end) = S6;
imwrite(uint8(S_67), './rslt_images/sample6_7.png');

% stitch S4 with S7 to locate the position (pos_i_47, pos_j_47) of the
% upper-right point of the overlapped rectangle
fprintf('\n    Stitching sample4.raw and sample7.raw ...\n');
pos_i_47 = 0;
pos_j_47 = 0;
max_match_num = -1;
for i = 170:324
    for j = 324:-1:1
        cur_match_num = sum(sum(S4(i:324, 1:j) == S7(1:325 - i, 325 - j:324)));
        if (cur_match_num > max_match_num)
            max_match_num = cur_match_num;
            pos_i_47 = i;
            pos_j_47 = j;
        end
    end
end
S_47 = -zeros(323 + pos_i_47, 648 - pos_j_47);
S_47(1:324, end - 323:end) = S4;
S_47(pos_i_47:end, 1:324) = S7;
imwrite(uint8(S_47), './rslt_images/sample4_7.png');

% #(rows) counting from left should be the same as #(rows) counting from
% right, and #(columns) counting from top should be the same as #(columns)
% from bottom
assert ((pos_i_47 - 1 + 324 + pos_i_67 - 1 == pos_i_45 - 1 + 324 + pos_i_56 - 1) ...
     && (324 - pos_j_47 + 324 + pos_j_45 - 1 == pos_j_67 - 1 + 324 + 324 - pos_j_56));

R = zeros(pos_i_47 - 1 + 324 + pos_i_67 - 1, 324 - pos_j_47 + 324 + pos_j_45 - 1);
R(1:324, 324 - pos_j_47 + 1:324 - pos_j_47 + 1 + 323) = S4;
R(pos_i_45:pos_i_45 + 323, end - 324 + 1:end) = S5;
R(end - 324 + 1:end, pos_j_67:pos_j_67 + 323) = S6;
R(pos_i_47:pos_i_47 + 324 - 1, 1:324) = S7;

% crop the largest square image of R and denote it as S
S = R(pos_i_45:end - pos_i_67 + 1, 324 - pos_j_47 + 1: end - 324 + pos_j_56);

% check with the Hint
[m_S, n_S] = size(S);
assert (m_S == 512 && n_S == 512);
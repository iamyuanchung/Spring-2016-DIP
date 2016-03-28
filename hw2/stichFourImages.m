function [R, S] = stichFourImages(S4, S5, S6, S7)
% ####################################################################### %
% stichFourImage: stich S4, S5, S6, and S7 toghether as required          %
%                                                                         %
%   Usage:                                                                %
%       [R, S] = stichFourImages(S4, S5, S6, S7)                          %
%                                                                         %
%   Description:                                                          %
%       TODO
% ####################################################################### %

% stick S4 and S5 together
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
% S_45 = -ones(323 + pos_i_45, 323 + pos_j_45);
% S_45(1:324, 1:324) = S4;
% S_45(pos_i_45:end, pos_j_45:end) = S5;

% stick S5 and S6 together
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
% S_56 = -ones(323 + pos_i_56, 648 - pos_j_56);
% S_56(1:324, end - 323:end) = S5;
% S_56(pos_i_56:end, 1:324) = S6;

% stick S6 and S7 together
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
% S_67 = -ones(323 + pos_i_67, 323 + pos_j_67);
% S_67(1:324, 1:324) = S7;
% S_67(pos_i_67:end, pos_j_67:end) = S6;

% stick S4 and S7 together
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
% S_47 = -ones(323 + pos_i_47, 648 - pos_j_47);
% S_47(1:324, end - 323:end) = S4;
% S_47(pos_i_47:end, 1:324) = S7;

assert ((pos_i_47 - 1 + 324 + pos_i_67 - 1 == pos_i_45 - 1 + 324 + pos_i_56 - 1) ...
     && (324 - pos_j_47 + 324 + pos_j_45 - 1 == pos_j_67 - 1 + 324 + 324 - pos_j_56));

R = zeros(pos_i_47 - 1 + 324 + pos_i_67 - 1, 324 - pos_j_47 + 324 + pos_j_45 - 1);
R(1:324, 324 - pos_j_47 + 1:324 - pos_j_47 + 1 + 323) = S4;
R(pos_i_45:pos_i_45 + 323, end - 324 + 1:end) = S5;
R(end - 324 + 1:end, pos_j_67:pos_j_67 + 323) = S6;
R(pos_i_47:pos_i_47 + 324 - 1, 1:324) = S7;

R = R(pos_i_45:end - pos_i_67 + 1, 324 - pos_j_47 + 1: end - 324 + pos_j_56);
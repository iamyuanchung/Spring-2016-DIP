function count = shapeAnalysis(S1, TS)


% remove the noisy background
S1 = (S1 > 0) * 255;
% imwrite(uint8(S1), './rslt_images/Sample1_clean.png');

%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% heuristic trimming %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%
% binarize TrainingSet.raw such that there will only be 0 or 255 pixel
% value
TS = (TS >= 128) * 255;
% imwrite(uint8(TS), './rslt_images/TrainingSet_bin.png')
TS = TS(10:240, 8:441);

[m, n] = size(TS);

m_slice = floor(m / 5);   % 46
n_slice = floor(n / 14);  % 31

for i = 1:5
    for j = 1:14
        data(:, :, (i - 1) * 14 + j) = TS((i - 1) * m_slice + 1:i * m_slice, (j - 1) * n_slice + 1:j * n_slice);
    end
end

mkdir('./rslt_images/', 'Q1_classes/');

n_class = length(data); % total number of classes (different characters) = 70
% for i = 1:n_class
%     imwrite(uint8(data(:, :, i)), ['./rslt_images/Q1_classes/class', num2str(i), '.png']);
% end

Cls = {};
for i = 1:n_class
    list1 = find(data(:, :, i)' == 0);
    top = ceil(min(list1) / n_slice);
    bottom = ceil(max(list1) / n_slice);
    list2 = find(data(:, :, i) == 0);
    left = ceil(min(list2) / m_slice);
    right = ceil(max(list2) / m_slice);
    Cls{end + 1} = data(top:bottom, left:right, i);
end

for i = 1:n_class
    imwrite(uint8(Cls{i}), ['./rslt_images/Q1_classes/class', num2str(i), '_trim.png']);
end

mkdir('./rslt_images/', 'Q1_instances/');

% segment all the characters appear in Sample1.raw and store them into a
% cell array Ins, where Ins{i} denotes the i-th instance
Ins = signSegment(S1, {}, 1);
n_instance = length(Ins); % n_instance = 22
% for i = 1:n_instance
%     imwrite(uint8(Ins{i}), ['./rslt_images/Q1_instances/instance', num2str(i), '.png']);
% end


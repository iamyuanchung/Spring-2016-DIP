function count = shapeAnalysis(S1, TS)


% remove the noisy background
S1 = (S1 > 0) * 255;
imwrite(uint8(S1), './rslt_images/Sample1_clean.png');

%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% heuristic trimming %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%
% binarize TrainingSet.raw such that there will only be 0 or 255 pixel
% value
TS = (TS >= 128) * 255;
imwrite(uint8(TS), './rslt_images/TrainingSet_bin.png')
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
for i = 1:n_class
    imwrite(uint8(data(:, :, i)), ['./rslt_images/Q1_classes/class', num2str(i), '.png']);
end

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
for i = 1:n_instance
    imwrite(uint8(Ins{i}), ['./rslt_images/Q1_instances/instance', num2str(i), '.png']);
end

count = zeros(n_class, 1);
for i = 1:n_instance
    maxOverlap = 0;
    for j = 1:n_class
        curClsSize = size(Cls{j});
        InsScaled = imresize(Ins{i}, curClsSize);
        Max = max(max(InsScaled));
        Min = min(min(InsScaled));
        InsScaled = (InsScaled > (Max - Min) / 2) * 255;
        curOverlap = sum(sum(Cls{j} == InsScaled)) / (curClsSize(1) * curClsSize(2));
        if (curOverlap > maxOverlap)
            maxOverlap = curOverlap;
            maxIndex = j;
        end
    end
    if (maxIndex <= 26) % A ~ Z
        c = char('A' + maxIndex - 1);
    elseif (maxIndex > 26 && maxIndex <= 52) % a ~ z
        c = char('a' + maxIndex - 27);
    elseif (maxIndex > 52 && maxIndex <= 62) % 0 ~ 9
        c = char('0' + maxIndex - 53);
    else % ! ~ *
        c = 'does not occur in Sample1.raw';
    end
    fprintf('sample %d, classify as %s\n', i, c);
    count(maxIndex) = count(maxIndex) + 1;
end

for i = 1:n_class
    if (count(i) > 0)
        if (i <= 26) % A ~ Z
            c = char('A' + i - 1);
        elseif (i > 26 && i <= 52) % a ~ z
            c = char('a' + i - 27);
        elseif (i > 52 && i <= 62) % 0 ~ 9
            c = char('0' + i - 53);
        else % ! ~ *
            c = 'does not occur in Sample1.raw';
        end
        % fprintf('%s: %d\n', c, count(i));    
    end
end
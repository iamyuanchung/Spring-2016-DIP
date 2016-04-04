function idx = kMeansCluster(data, k)

[nData, ~] = size(data);

% initialize the centers randomly
% data_min = min(data);
% data_max = max(data);
% data_range = data_max - data_min;   % range for each dimension
% centers = ones(k, dim) .* rand(k, dim);
% for i = 1:k
%     centers(i, :) = centers(i, :) .* data_range + data_min;
% end
centers = data(randi([1 nData], 1, k), :);

% stopping criteria: when assignment remains the same
idx = zeros(nData, 1);
idx_prev = ones(nData, 1);
% isDiff is 0 when all elements in idx are same as the elements in
% idx_prev, and is 1 otherwise; k-means should stop when isDiff = 0
isDiff = sum(sum(idx ~= idx_prev)) > 0;
while isDiff
    % record idx
    idx_prev = idx;
    % assign new labels to each data points
    for i = 1:nData
        % compute square of euclidean distance
        % subtract vector from matrix rows without for loop
        distSquare = sum(bsxfun(@minus, centers, data(i, :))' .^ 2);
        [~, idx(i)] = min(distSquare);
    end
    % update centers
    for i = 1:k
        index = find(idx == i);
        centers(i, :) = mean(data(index, :));
    end
    % recompute isDiff to see if it meets the stopping criteria
    isDiff = sum(sum(idx ~= idx_prev)) > 0;
end
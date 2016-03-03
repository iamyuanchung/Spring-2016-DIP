function H = plotHistogram(filename)
    % TODO
    disp(['Plotting the histogram of ' filename ' ...']);
    G = readraw(filename);
    [m, n] = size(G);
    H = zeros(1, 256);
    for i = 1:m
        for j = 1:n
            H(G(i, j) + 1) = H(G(i, j) + 1) + 1;
        end
    end
    bar(0:255, H);
    saveas(gcf, strcat(filename(1, 1:length(filename) - 4), '.histogram.png'));
end
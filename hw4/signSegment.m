function Ins = signSegment(F, Ins, vertical)



if (length(find(F(1, :) == 0)) > 0 && length(find(F(end, :) == 0)) > 0 ...
 && length(find(F(:, 1) == 0)) > 0 && length(find(F(:, end) == 0)) > 0)
    % meet the terminal condition, F can no longer be seperate into smaller
    % pieces
    Ins{end + 1} = F;
else
    % segment F into smaller pieces
    [m, n] = size(F);
    if (vertical == 1)
        v = 1;
        while (1)
            while (v <= n && length(find(F(:, v) > 0)) == m)
                v = v + 1;
            end
            left = v;

            while (v <= n && length(find(F(:, v) == 0)) > 0)
                v = v + 1;
            end
            right = v - 1;

            if (left > right)
                break;
            end
            Ins = signSegment(F(:, left:right), Ins, 0);
        end
    else
        h = 1;
        while (1)
            while (h <= m && length(find(F(h, :) > 0)) == n)
                h = h + 1;
            end
            top = h;

            while (h <= m && length(find(F(h, :) == 0)) > 0)
                h = h + 1;
            end
            bottom = h - 1;

            if (top > bottom)
                break;
            end

            Ins = signSegment(F(top:bottom, :), Ins, 1);
        end
    end
end
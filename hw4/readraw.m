function G = readraw(filename)
    disp(['Retrieving Image ' filename ' ...']);
      fid = fopen(filename, 'rb');
    if (fid == - 1)
        error('can not open imput image filem press CTRL-C to exit \n');
        pause
    end
    pixel = fread(fid, inf, 'uchar');
    fclose(fid);
    [Y, X] = size(pixel);
    Size = (Y * X);
    N = sqrt(Size);
    G = zeros(N, N);
    G(1:Size) = pixel(1:Size);
    G = G';
end
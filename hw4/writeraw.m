function count = writeraw(G, filename)
    disp(['Writing image data to ' filename ' ...']);
      fid = fopen(filename, 'wb');
    if (fid == - 1)
        error('can not open output image filem press CTRL-C to exit \n');
        pause
    end
    G = G';
    count = fwrite(fid, G, 'uchar');
    fclose(fid);
end
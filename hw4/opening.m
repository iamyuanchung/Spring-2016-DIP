function G = opening(F, H)


G = dilateImage(erodeImage(F, H), H);
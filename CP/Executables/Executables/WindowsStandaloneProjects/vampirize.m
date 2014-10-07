function vampirize(A)
%entropy(A)
img =im2double( imread(A));
imgEnhanced = entropyfilt(img,getnhood(strel('Disk',4)));
imgEnhanced = imgEnhanced/max(imgEnhanced(:));
imgEnhanced = imadjust(imgEnhanced,[0.30; 0.85],[0.90; 0.00], 0.90);
%imshow(imgEnhanced)
C=imgEnhanced;
%Courtesy :http://blogs.mathworks.com/steve/2012/11/13/image-effects-part-1/#9f844c5d-f437-49f3-b04d-629dfd6ee2d5
imwrite(C,'output.png');
quit;

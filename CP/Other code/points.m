function X= points(A)
A=imread(A);
h = fspecial('gaussian', 5 ,1.5);
B = imfilter(A,h,'replicate');
%C = imnoise(B,'salt & pepper');
se = strel('ball',9,9);
X = imdilate(B,se);

%Just dilate?

end
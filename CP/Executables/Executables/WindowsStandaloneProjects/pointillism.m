function pointillism(A)
firstImage =im2double( imread(A));
% = imread('nature.jpg');
% imshow(firstImage);

cform = makecform('srgb2lab');
lab_image = applycform(firstImage,cform);
bsize=4;

L = double(lab_image(:,:,1));
nrows = size(L,1);
ncols = size(L,2);
L = reshape(L,nrows*ncols,1);

nColors = 10;
% repeat the clustering 3 times to avoid local minima
[cluster_idx,cluster_center] = kmeans(L,nColors,'distance','sqEuclidean','Replicates',3);

pixel_labels = reshape(cluster_idx,nrows,ncols);
%imshow(pixel_labels,[]);
segmented_images = cell(1,nColors);
rgb_label = repmat(pixel_labels,[1 1 3]);

for k = 1:nColors
    color = firstImage;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
end

A=firstImage;
Ar=firstImage(:,:,1);
Ag=firstImage(:,:,2);
Ab=firstImage(:,:,3);
A(:,:,:)=255;
Ar(:,:)=255;
Ag(:,:)=255;
Ab(:,:)=255;
xL = size(A,1); 
yL = size(A,2);
r=2;

for i=1:2*r-1:xL-r
    for j=1:2*r-1:yL-r
        Xcenter = i+r+1; 
        Ycenter = j+r+1; 
        index=pixel_labels(i,j);
        
        %ThisColor = floor(256 * rand());
        ThisColorR = segmented_images{index}(i,j,1);
        ThisColorG = segmented_images{index}(i,j,2); 
        ThisColorB = segmented_images{index}(i,j,3);  

        ThisRadius = r;
        
        %circlePixels = bsxfun(@(x,y) (x - Xcenter).^2 + (y - Ycenter).^2 <= ThisRadius.^2, (1:xL).', 1:yL);
        circlePixels = bsxfun(@(x,y) (x - Xcenter).^2 + (y - Ycenter).^2 <= ThisRadius.^2, (1:xL).', 1:yL);
        Ar(circlePixels)= ThisColorR;
        Ag(circlePixels)= ThisColorG;
        Ab(circlePixels)= ThisColorB;
        %A(circlePixels) = ThisColor;

    end    
end
A=cat(3,Ar,Ag,Ab);
imshow(A);
layer1Image=A;

B=firstImage;
Br=firstImage(:,:,1);
Bg=firstImage(:,:,2);
Bb=firstImage(:,:,3);
B(:,:,:)=0;
Br(:,:)=0;
Bg(:,:)=0;
Bb(:,:)=0;
xL = size(B,1); 
yL = size(B,2);

siz=5;
for i=1:siz:xL-siz
    for j=1:siz:yL-siz
        newXcenter = randi([i,i+siz]); 
        newYcenter = randi([j,j+siz]);

        newColorR = firstImage(i,j,1);
        newColorG = firstImage(i,j,2); 
        newColorB = firstImage(i,j,3);  

        newRadius = randi([1,2]);
        
        newCirclePixels = bsxfun(@(x,y) (x - newXcenter).^2 + (y - newYcenter).^2 <= newRadius.^2, (1:xL).', 1:yL);
        Br(newCirclePixels)= newColorR;
        Bg(newCirclePixels)= newColorG;
        Bb(newCirclePixels)= newColorB;
     

    end    
end

B=cat(3,Br,Bg,Bb);
imshow(B);
layer2Image=B;

a=layer1Image;
b=layer2Image;
imshow(b);
hold on;
h=imshow(a);
set(h,'AlphaData',0.8);

imwrite(h,'output.png');
quit;

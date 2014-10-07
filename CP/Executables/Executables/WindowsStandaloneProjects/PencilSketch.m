function PencilSketch( input_image )
p = 20.1;
thresh = 79.4;
row = 0.017;

image = imread(input_image);
image2 = rgb2gray(image);

gaussian1 = fspecial('Gaussian', 5,.5);
gaussian2 = fspecial('Gaussian', 5,2);
dog = (1+p)*gaussian1 - (p*gaussian2);
dogFilteredImage = conv2(double(image2),dog,'same');
dogSize = size(dogFilteredImage);

for i=1:dogSize(1)
    for j=1:dogSize(2)
        if dogFilteredImage(i,j) > thresh
            dogFilteredImage(i,j) = 1;
        else
            dogFilteredImage(i,j) = 1 + tanh(row*(dogFilteredImage(i,j)-thresh));
        end
    end
end

gaussian3 = fspecial('Gaussian',10,1.5);
dogFilteredImage3 = conv2(dogFilteredImage,gaussian3,'same');

X = dogFilteredImage3;

imwrite(X,'output.png');
quit;



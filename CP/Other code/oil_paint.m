function X= oil_paint(A)
%Source:http://www.codeproject.com/Articles/471994/OilPaintEffect
%A=input image
%X=output image
%m,n,d size of image
%rad=size of processing area-can extend as user input,should be odd so we can use
%center pixel
%mask=intensity mask
%intensity=for blockier images
%Basically this effect is achieved by examining the nearest pixels for all pixels. 
%For every pixel, it finds the maximum repeated color and that color will be considered as the output. 
%We will get a blocky image with less information, similar to oil painting effect of the image. 
A =imread(A);
[p, q, r]=size(A);
rad=6;

X=uint8(zeros(p-rad,q-rad,3));
%Calculate the histogram for each RGB value.

for i=1:p-rad
    for j=1:q-rad
        mask=A(i:i+rad-1,j:j+rad-1,:);
        h=zeros(256,3);
        for x=1:rad
            for y= 1:rad
                h((mask(x,y,1)+1),1)=h((mask(x,y,1)+1),1)+1;%offset by 1 bcoz vals 0:255 & index 1:256
                h((mask(x,y,2)+1),2)=h((mask(x,y,2)+1),2)+1;
                h((mask(x,y,3)+1),3)=h((mask(x,y,3)+1),3)+1;
            end
        end
  %Maximum occurring value and the position is obtained
       for k=1:3
        [maxvalue,pos]=max(h(:,k));
        X(i,j,k)=pos-1;
       end
    end
end

%imshow(X);
end
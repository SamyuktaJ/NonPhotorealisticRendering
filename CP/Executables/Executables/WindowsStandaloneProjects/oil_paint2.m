function oil_paint2(A,rad)
%A=input image
%X=output image
%m,n,d size of image
%rad=size of processing area-can extend as user input,should be odd so we can use
%center pixel
%mask=intensity mask
%intensity=for blockier images
A =imread(A);
[p, q, d]=size(A);
%rad=6;

X=uint8(zeros(p-rad,q-rad,3));
%Calculate the histogram for each RGB value.

for i=1:p-rad
    for j=1:q-rad
        mask=A(i:i+rad-1,j:j+rad-1,:);
       r=reshape(mask(:,:,1),1,rad*rad);
       X(i,j,1)=mode(r);
       g=reshape(mask(:,:,2),1,rad*rad);
       X(i,j,2)=mode(g);
       b=reshape(mask(:,:,3),1,rad*rad);
       X(i,j,3)=mode(b);        
    end
end

imwrite(X,'output.png');
quit;

function glass(A)
%A=input image
%X=output image
%m,n,d size of image
%rad=size of processing area-can extend as user input
A =imread(A);
[p, q, r]=size(A);
rad=7;
X=uint8(zeros(p-rad,q-rad,3));

for i=1:p-rad
    for j=1:q-rad

        mask=A(i:i+rad-1,j:j+rad-1,:);
%Select a pixel value from the neighborhood.
x2=randi(rad);
y2=randi(rad);
    
        X(i,j,:)=mask(x2,y2,:);
    end
end

imwrite(X,'output.png');
quit;
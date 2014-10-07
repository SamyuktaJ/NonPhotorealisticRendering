function rastafarian(A)%abstract1(A)
%Samyukta J
A=imread(A);
B=A;

h = fspecial('gaussian', 5 ,1.5);
B = imfilter(B,h,'replicate');
rad=9;
se = strel('ball',rad,rad);
%15 is too small, 75 is too big
X = imdilate(B,se);
[p, q, r]=size(X);

Y=rgb2gray(X);
for i=2:(p-1)
    for j=2:(q-1)        
        if((Y(i-1,j)~=Y(i+1,j))||(Y(i,j-1)~=Y(i,j+1)))            
            X(i,j,:)=0;               
        end        
    end
end
imwrite(X,'output.png');
quit;

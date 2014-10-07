function comic(A)
%Samyukta J
%   Detailed explanation goes here
A =im2double( imread(A));
B= decorrstretch(A,'tol',0.3);

%B= decorrstretch(A,'TargetSigma',50);

%Gaussian blur- makes smooth
 G = fspecial('gaussian',[5 5],2);
 B=imfilter(B,G);
 
 %Adjust contrast
 B = imadjust(B,[0.30; 0.85],[0.00; 0.90], 0.90);
 X=B;
imwrite(X,'output.png');
quit;



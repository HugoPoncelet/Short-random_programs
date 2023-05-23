function [Ea,Eb]=YoungModulus(dir,d,m,window)
% Author: Hugo PONCELET
% Last modification: 23rd May, 2023
% 
% Computes the Young modulus of a cylindrical rod thanks to a first order
% polynomial fit: F/S=E*l/l0-E, so F/S=ax+b
%
% OUTPUT: 
%   - Ea is the Young modulus associated to the constant a of the fit 
%   - Eb is the one from b (both in Pa)
%
% INPUT: 
%   - "dir" is a string containing the directory of the photos
%   - "d" is the diameter of the rod (in m)
%   - "m" the mass asociated to each photo (in kg)
%   - "window" the axis' limits to zoom on the rod (in px)


    list=ls(dir);
    files=list(3:end,:);
    nIm=size(files,1);
    
    g=9.81; 
    S=pi*d^2;
    F=m*g;

    X=zeros(2,nIm);
    Y=X;

% Click on the control points on your rod to compute the elongation
    for i=1:nIm
        Im=imread([dir files(i,:)]);
        imagesc(Im);axis(window)
        [x,y]=ginput(2); 
        X(:,i)=x;
        Y(:,i)=y;
    end

    dx=X(1,:)-X(2,:);
    dy=Y(1,:)-Y(2,:);

% Computation of all the distances
    L=sqrt(dx.^2+dy.^2); 

    P=polyfit(L/L(1),F/S,1);

    Ea=P(1);
    Eb=-P(2);
end

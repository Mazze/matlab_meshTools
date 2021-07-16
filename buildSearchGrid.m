function [grid,boundsX,boundsY] = buildSearchGrid(face,data,numberOfBins)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


range =[min(data(:,1)),max(data(:,1));
        min(data(:,2)),max(data(:,2))];
grid= cell(numberOfBins,numberOfBins);
%bounds=
[boundsX,boundsY] = meshgrid(0:numberOfBins,0:numberOfBins);
boundsX=range(1)+boundsX*((range(1,2)-range(1,1))/numberOfBins);
boundsY=range(1)+boundsY*((range(2,2)-range(2,1))/numberOfBins);

for i=1:size(face,2)
    
    points= data(face(:,i),:);
    for j= 1: size(grid,1)
        if any( points(:,1)>=boundsX(1,j) &  (points(:,1)<=boundsX(1,j+1))  )
            for n= 1: size(grid,2)
                if any( points(:,2)>=boundsY(n,1) &  (points(:,2)<=boundsY(n+1,1))  )
                    grid{j,n}(end+1)=i;
                end
            end
        end
            
    end     
end

%function C = OuterProduct(A, B)  % version 4
%C = A .* reshape(B, [ones(1, ndims(A)), size(B)]);
%end
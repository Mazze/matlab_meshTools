function [val] = barycentricInterpolation(point,faces,coords,data,grid,boundsX,boundsY,defaultValue)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


if ~exist('grid','var')
    [grid, boundsX,boundsY]=buildSearchGrid(faces,coords,20);
end
if ~exist ('defaultValue','var')
    defaultValue = nan;
end

% Let find the triangle we are in.
i=1:(size(boundsX,2)-1);
j=2:(size(boundsX,2));
x=(boundsX(1,i)<=point(1) )& (boundsX(1,j)>=point(1) );
y=(boundsY(i,1)<=point(2) )& (boundsY(j,1)>=point(2) );
x=find(x);
y=find(y);
% loop just in case we are on a boundary
%if any(point==1)
%    disp("got")
%end
%sg=size(grid);
for i=x
    for j=y
        if isempty(i)
            warning("Extra polation required, return default value")
            break;
        end
        if isempty(j)
            warning("Extra polation required, return default value")
            break
        end

        %sprintf("%d x %d  | i=%d ,j=%d",sg(1),sg(2),i,j)
        currentCells= grid{i,j};
        for n=1:length(currentCells)
            points= coords(faces(:,currentCells(n)),:);
            [w1,w2,w3] = barycentricFromCart(points,point);
            w=[w1,w2,w3];
            if ~any(isnan(w))& ~any(w<-1e-10)% Allows some tollerance                
                val= dot(data(faces(:,currentCells(n)),:),w);
                if isnan(val)
                    disp("d")
                end
                break;
            end            
        end
        if exist('val','var')
            break
        end
    end
    if exist('val','var')
        break
    end
end
if ~exist('val','var')
   val=defaultValue;
end

end


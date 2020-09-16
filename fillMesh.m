function [mesh] = fillMesh(mesh,fieldNameBounday,threshold, seedId,value,newFieldname)
%FILLMESH Summary of this function goes here
%   Detailed explanation goes here

if (isfield(mesh,'nodes'))
    nameVertex='nodes';
elseif (isfield(mesh,'vertex'))
    nameVertex='vertex';
else
    warning("No node points point ")
end

if isempty(newFieldname)
    newFieldname="Filled Array";
end


if (~isfield(mesh,fieldNameBounday))
    warning ("Boundary field name does not exist in mesh")
    return ;
end

if ~ isfield(mesh,'nodeToCell')
    [mesh] = getNodeToCellConnections(mesh);
end


if ~isfield(mesh,newFieldname)
    mesh.(newFieldname)= zeros(max(size(mesh.(nameVertex))),1);
end
newPoints=seedId;
proccessedPoints=[];
while ~isempty(newPoints)
    if mesh.(fieldNameBounday)(newPoints(1))<threshold
        %Add
        usePoint=newPoints(1);
        proccessedPoints=[proccessedPoints(:) ; usePoint];
        mesh.(newFieldname)(usePoint)=value;        
        t=mesh.faces(mesh.nodeToCell{usePoint},:);
        newPoints=horzcat(newPoints,t(:)');
        newPoints=unique(newPoints);
        [~,inewPoints]=intersect(newPoints,proccessedPoints);
        newPoints(inewPoints)=[];
    else 
        newPoints(1)=[];
    end
        
    
end

end


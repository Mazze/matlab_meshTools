function [newNodes, newFaces,nodesKeeped,deleteFaces] = getSubSurface(nodes, faces, data,subId)
%GETSUBSURFACE Extract the part which has subId
%   From a surface mesh, all nodes that are subId will be extraced 
%   and remaining surface be 

if (size(nodes,1)~= length(nodes))
    nodes=nodes';
end
if (size(faces,1)~= length(faces))
    faces=faces';
end

%Which nodes to keep
toKeep =(data==subId);
%Which faces to keep
facesToKeep = sum(toKeep(faces),2)>1  ;
allUsedNodes = unique(faces(facesToKeep,:));
newNodes = nodes (allUsedNodes,:);
%Map old id to new
oldNodesToNew=zeros(size(nodes,1),1);
for i = 1:size(allUsedNodes,1)
	oldNodesToNew(allUsedNodes(i) )=i ;
end 
%Get the faces and convert there indices
newFaces = faces(facesToKeep,:);
newFaces=oldNodesToNew(newFaces);

nodesKeeped=false(size(nodes,1),1);
nodesKeeped(allUsedNodes)=true;

deleteFaces= 1: size(faces,1);
deleteFaces(facesToKeep)=[];

end 
function [bounds,cons,mesh] = getRegionInterfaces(mesh, regions)
%GETREGIONINTERFACES Summary of this function goes here
%   Detailed explanation goes here

bounds=[];
for i = 1: length(mesh.faces)
   el=mesh.faces(i,:) ;
   ids=regions(el);
   if length(unique(ids))>1
       %Element on border
       [v,j]=min(ids);
       t=el(ids==v);
       bounds(end+1:end+size(t,2),1:2)=[t;repmat(v,1,size(t,2))]';
   end
end

if ~ isfield(mesh,'nodeToCell')
    [mesh] = getNodeToCellConnections(mesh);
end

%build the connections
consCount=1;
cons=cell(max(bounds(:,2))-min(bounds(:,2))+1,1);
for i =min(bounds(:,2)):max(bounds(:,2))
    currentId =bounds(bounds(:,2)==i ,1);
    connetions=[];
    for j= 1: length(currentId)        
        potentialNodes=mesh.faces(mesh.nodeToCell{currentId(j)},:);
        connectedTo = intersect(potentialNodes(:),currentId);
        connectedTo(connectedTo==currentId(j))=[];
        if(~isempty(connectedTo))
            connetions(end+1:end+size(connectedTo,1),1:2) =...
                [repmat(currentId(j), size(connectedTo,1),1),connectedTo];
        end
    end    
    cons{consCount}=unique(sort(connetions,2),'rows');
    consCount=consCount+1;
end
end


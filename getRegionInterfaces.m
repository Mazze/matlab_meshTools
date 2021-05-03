function [bounds,cons,mesh,key] = getRegionInterfaces(mesh, regions,generateKey)


%GETREGIONINTERFACES Summary of this function goes here
%   Detailed explanation goes here
if ~exist('generateKey','var') 
    generateKey= false;
end
mesh.faces= mesh.faces;
if (size(mesh.faces,1)~= length(mesh.faces))    
    mesh.faces=mesh.faces';
end
bounds=[];
for i = 1: length(mesh.faces)
   el=mesh.faces(i,:) ;
   ids=regions(el);
   if length(unique(ids))>1
       %Element on border
       [v,j]=max(ids);
       t=el(ids==v);
       bounds(end+1:end+size(t,2),1:2)=[t;repmat(v,1,size(t,2))]';
   end
end

if ~ isfield(mesh,'nodeToCell')
    [mesh] = getNodeToCellConnections(mesh);
end

%build the connections
consCount=1;
%key= max(bounds(:,2))-min(bounds(:,2))+1;
key= min(bounds(:,2)) :max(bounds(:,2));
cons=cell(max(bounds(:,2))-min(bounds(:,2))+1,1);
for i = key
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


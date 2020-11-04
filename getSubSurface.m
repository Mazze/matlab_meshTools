function [nodes, faces,nodesKeeped] = getSubSurface(nodes, faces, data,subId)
%GETSUBSURFACE Extract the part which has subId
%   From a surface mesh, all nodes that are subId will be extraced 
%   and remaining surface be 

toKeep =(data~=subId);
idToKeep=1:size(data,1);
idToKeep(~toKeep)=[];%This is a ordered list

  
%for i=1:length(idToKeep)
deleteFaces = zeros( size(faces,1),1);
for i=1:size(faces,1)      
    for j=1:size(faces,2)
        
        if sum(faces(i,j)== idToKeep)>0
            
            deleteFaces(i)=1;
           break;
        else
            ind=find((idToKeep-faces(i,j))>0,1,'first')-1;
            if ind>0
          %      faces(i,j)=faces(i,j)-ind;
            end
        end
        
    end
end
faces(logical(deleteFaces),:)=[];

% check for unrefered points
s=size(nodes);
tic
tests=1:s(1);
tests(toKeep)=[];
disp(['Remove before ' num2str(size(toKeep))]);
for i =tests
    if isempty(find(faces==i,1))
        %found non used node 
        toKeep(i)=1;
        
    end 
end
disp(['Remove after ' num2str(size(toKeep))]);
toc
% remove the points 
nodes=nodes(~toKeep,:);
[sf,sfi]=sort(faces(:));
nodesGone=sort(find(toKeep));
last=1;
sfnew=sf;
for i = 1:size(nodesGone,1)
    last=find(sf>=nodesGone(i),1);
    sfnew(last:end)=sfnew(last:end)-1;
end 
sf(sfi)=sfnew;
faces=reshape(sf,size(faces));
    %faces(faces>idToKeep(i))=faces(faces>idToKeep(i))-1;    
    %nanvertices(i+1:end)=nanvertices(i+1:end)-1;
nodesKeeped=~toKeep;
end


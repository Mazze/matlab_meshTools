function [mesh,maps] = cleanPolydata(mesh)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% check for unrefered points
s=max(size(mesh.vertex));
if (size(mesh.vertex,1)>size(mesh.vertex,2))
    mesh.vertex =mesh.vertex';
end
tests=1:s;
toRemove=logical(zeros(s,1));
maps=zeros(s,1)-1;

newId=1;
for i =tests
    r=(mesh.faces==i);
    if isempty(find(r,1))
        %found non used node 
        toRemove(i)=1;  
    else
        maps(newId)=i;
        
        mesh.faces(r)=newId;%correct faces
        newId=newId+1;
    end 
end
maps(newId:end)=[];
mesh.vertex(:,toRemove)=[];


end


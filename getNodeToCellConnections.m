function [mesh] = getNodeToCellConnections(mesh)
%GETNODETOCELLCONNECTIONS Summary of this function goes here
%   Detailed explanation goes here
s=size(mesh.vertex);
mesh.nodeToCell=cell(s(2),1);
sC=size(mesh.faces);
for i =1:s(2)
    con=find(mesh.faces==i);
    [con,~]=ind2sub(sC,con);
    con=unique(con);
    mesh.nodeToCell{i}=con;
end
end


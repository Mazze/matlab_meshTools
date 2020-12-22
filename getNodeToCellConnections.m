function [mesh] = getNodeToCellConnections(mesh)
%GETNODETOCELLCONNECTIONS Summary of this function goes here
%   Detailed explanation goes here
s=length(mesh.vertex);
mesh.nodeToCell=cell(s,1);
sC=size(mesh.faces);
for i =1:s
    con=find(mesh.faces==i);
    [con,~]=ind2sub(sC,con);
    con=unique(con);
    mesh.nodeToCell{i}=con;
end
end


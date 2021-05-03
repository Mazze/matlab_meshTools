function [mesh] = getNodeToCellConnections(mesh)
%GETNODETOCELLCONNECTIONS Get all cells of a single node
%   returns a cell list with each cell giving the connected nodes
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


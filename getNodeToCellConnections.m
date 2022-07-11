function [mesh] = getNodeToCellConnections(mesh)
%GETNODETOCELLCONNECTIONS Get all cells of a single node
%   returns a cell list with each cell giving the connected nodes
s=length(mesh.vertex);
%mesh.nodeToCell=cell(s,1);
sC=size(mesh.faces);

% extraOne = @(a,b,c) [r,~]=a(b,c);return r; );
% for i =1:s
%      con=find(mesh.faces==i);
%      if any(con>s)
%          disp("Found")
%      end
%      [con3,~]=ind2sub(sC,con);
%      con2=ind2sub(sC,con);
%      cc=extraOne(ind2sub(sC,con));
% %     con=unique(con);
% %     mesh.nodeToCell{i}=con;
% end

function ret = findElem (i)
    [con,~]=ind2sub(sC,find(mesh.faces==i));   
    ret = unique(con);
end

mesh.nodeToCell= arrayfun ( @(i)  findElem(i)  ,1:s,'UniformOutput',false)';
%mesh.nodeToCell= arrayfun ( @(i)   unique(ind2sub(sC,find(mesh.faces==i))) ,1:s,'UniformOutput',false)';


end


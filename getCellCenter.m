function [mesh] = getCellCenter(mesh)
%UNTITLED Get the center of all cells
%   The cell center is calculated by averaging all vertexes

mesh.facedata.CellCenter= zeros(3,size(mesh.faces,2));
for i=1:size(mesh.faces,2)
    mesh.facedata.CellCenter (:,i)=(sum(mesh.vertex (:,mesh.faces(:,i)),2)/3)';
end

sizeElement= size(mesh.elements,1);
mesh.elementdata.CellCenter= zeros(3,size(mesh.elements,2));
for i=1:size(mesh.elements,2)
    mesh.elementdata.CellCenter (:,i)=(sum(mesh.vertex (:,mesh.elements(:,i)),2)/sizeElement )';
end
if isfield(mesh.pointdata,"alphaVol") && ...
        isfield(mesh.pointdata,"betaVol") && ...
            isfield(mesh.pointdata,"z")
        % Get the coordinate in univeral as well
        
        mesh.facedata.UACCenter= zeros(3,size(mesh.faces,2));
        for i=1:size(mesh.faces,2)
            t=vertcat( mesh.pointdata.alphaVol (mesh.faces(:,i)) , ...
                mesh.pointdata.betaVol (mesh.faces(:,i)), ...
                mesh.pointdata.z (mesh.faces(:,i)));                
            mesh.facedata.UACCenter (:,i)=(sum(t,2)/3)';
        end
        sizeElement= size(mesh.elements,1);
        mesh.elementdata.UACCenter= zeros(3,size(mesh.elements,2));
        for i=1:size(mesh.elements,2)
            t=vertcat( mesh.pointdata.alphaVol (mesh.elements(:,i)) , ...
                mesh.pointdata.betaVol (mesh.elements(:,i)), ...
                mesh.pointdata.z (mesh.elements(:,i)));     
            mesh.elementdata.UACCenter (:,i)=(sum(t,2)/sizeElement )';
        end
end
end


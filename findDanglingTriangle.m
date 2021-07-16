function [trianlges]= findDanglingTriangle(meshOut)
     
    connectionCount = zeros(size(meshOut.vertices,1),1);
    for i = 1: size(meshOut.faces,1)
        connectionCount(meshOut.faces(i,:))=connectionCount(meshOut.faces(i,:))+1;        
    end
    keepCell = true(size(meshOut.faces,1),1);
    for i = 1: size(meshOut.faces,1)
        a=sort(connectionCount(meshOut.faces(i,:)));
        if sum(a(1:2))==2
            keepCell(i)=false;
        end
    end
    trianlges = find(~keepCell);
end
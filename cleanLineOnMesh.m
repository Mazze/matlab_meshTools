function [LineElements] = cleanLineOnMesh(LineElements,meshElements)
%cleanLineOnMesh smoothes a line on a mesh 
%   Smoothing is achieved using only one egde of each element

foundEl = ismember(meshElements,LineElements);

sumEl = sum(foundEl,2);
meshids= meshElements(sumEl==3,:);
removeIds=[];
newEls=[];
for i= 1 : size(meshids,1)
    curID=meshids(i,:);
    a=ismember(LineElements, curID );
    b=sum(a,2);
    %b==2 %Within the element
    
    % b==1 %Start an end
    a2=LineElements(b==1,:);    
    newEl=unique(a2(ismember(a2,curID)));
    % There are more complicated situations. I don't to handel them now.
    if length(newEl)==2 
        removeIds= [removeIds,find(b==2)'];
        newEls=[newEls;newEl'];
    elseif length(newEl)>2
        disp("H")
    end
    
end
%Remove and add
LineElements(removeIds,:)=[];
LineElements=[LineElements;newEls];
end


function [components] = getConnectedComponents(connections)
%GETCONNECTEDCOMPONENTS Summary of this function goes here
%   conections is a list of elements nxp,where n is the number of elements
%   and p is the conectivity of each element

components={};
while ~isempty(connections)
    nextElem=connections(1,:);
    currentComp=connections(1,:);
    connections(1,:)=[];
    
    while ~isempty(nextElem)
        
        [r,c] = find (connections==nextElem(1));
        temp= connections(r,:);
        currentComp =[currentComp;temp];
        
        connections(r,:)=[];
        nextElem(1)=[];
        nextElem=[nextElem(:); temp(:)];
        nextElem=unique(nextElem);
    end
    components{end+1}=currentComp;
end
end


function [outputMesh] = copyLabelsFromMtoM(inputMesh,outputMesh)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    Dis = pdist2(inputMesh.vertex',outputMesh.vertex');
    [~,ids]=min(Dis);
    
    
    
    
    
    possibleArray=fieldnames(inputMesh);    
    for i=1:size(possibleArray,1)
        if strcmp(possibleArray{i},'vertex') ||...
            strcmp(possibleArray{i},'faces')||...
            strcmp(possibleArray{i},'elements')
            continue;       
        end
        %outputMesh.(possibleArray{i}) = zeros(min(size(inputMesh)),max(size(outputMesh)));        
        if(size(inputMesh.(possibleArray{i}),1) >size(inputMesh.(possibleArray{i}),2))
            outputMesh.(possibleArray{i})(:,:)= inputMesh.(possibleArray{i})(ids,:)';
        else
            outputMesh.(possibleArray{i})(:,:)= inputMesh.(possibleArray{i})(:,ids);
        end
    end

end


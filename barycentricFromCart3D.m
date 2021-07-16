function [w1,w2,w3] = barycentricFromCart3D(points,p)
%UNTITLED Convert 2D Cartesian Coordinates to barycentrinc
%   point: 3 x 3 matrix of egde points, first point Id, second coordinate id
%   p      1 x 2 matrix point of interrest


%% Construct 2d coordinates


v1 = points(1,:);
v2 = points(2,:);
v3 = points(3,:);



%now find eh1 such that  eh1 cdot eh2 = 0 and it is in the same plane of v1
%v2
eh1= v3-v1;
eh2 = v2-v1;
eh1=eh1./norm(eh1); % normalize
eh2=eh2./norm(eh2); % normalize

%Make an orthogonal system
eh2=eh2-dot(eh2,eh1).*eh1;
eh2=eh2./norm(eh2);

%% Test

%t5= dot(eh1,eh2);

%% get triangle in new coordinate system
v1n=[0,0];
v2t=v2-v1;
v2n=[dot(eh1,v2t),dot(eh2,v2t)];
v3t=v3-v1;
v3n=[dot(eh1,v3t),dot(eh2,v3t)];
newPoints=[v1n;v2n;v3n];
newPt=p-v1;
newP= [dot(eh1,newPt),dot(eh2,newPt)];
[w1,w2,w3] = barycentricFromCart2D(newPoints,newP);
end


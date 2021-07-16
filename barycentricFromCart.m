function [w1,w2,w3] = barycentricFromCart(points,p)
%UNTITLED Convert 2D or 3d Cartesian Coordinates to barycentrinc
%   point: 3 x n matrix of egde points,first point Id, second coordinate id
%   p      1 x 2 matrix point of interrest

if size(points,2) ==2
    [w1,w2,w3]=barycentricFromCart2D(points,p);
elseif size(points,2) ==3
    [w1,w2,w3]=barycentricFromCart3D(points,p);
else
    error("The size of points does not match")
end


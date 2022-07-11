function [V] = triangleVolume(a,b,c)
%UNTITLED Volume of a trianlge with tree points
%   Detailed explanation goes here
A= vecnorm( b(:)-a(:));
B= vecnorm( c(:)-a(:));
C= vecnorm( c(:)-b(:));

V= 0.25 * sqrt( (A+B+C) *(-A +B +C) * (A-B+C) *(A+B-C)  ); 

end


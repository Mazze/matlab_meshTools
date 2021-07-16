function  [w1,w2,w3] = barycentricFromCart2D(points,p)
%UNTITLED Convert 2D Cartesian Coordinates to barycentrinc
%   point: 3 x 2 matrix of egde points, first point Id, second coordinate id
%   p      1 x 2 matrix point of interrest

    
    t= (points(2,2) -points(3,2))*(points(1,1) -points(3,1)) + ...
        (points(3,1) -points(2,1))*(points(1,2) -points(3,2));
    
    w1= ((points(2,2) -points(3,2))*(p(1,1) -points(3,1)) + ...
        (points(3,1) -points(2,1))*(p(1,2) -points(3,2))) /t ;
    
    w2= ((points(3,2) -points(1,2))*(p(1,1) -points(3,1)) + ...
        (points(1,1) -points(3,1))*(p(1,2) -points(3,2))) /t ;
    
    w3= 1-w1-w2;

end


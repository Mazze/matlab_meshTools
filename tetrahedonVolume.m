function [V] = tetrahedonVolume(a,b,c,d)
%UNTITLED Volume of a tetrahedon with four points
%   Detailed explanation goes here
t1=cross((b-d),(c-d));
V=abs(dot (a-d,t1))/6;
end


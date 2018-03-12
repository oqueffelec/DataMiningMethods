function [ d ] = mongradient( teta )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
d=[400*teta(1)^3+2*teta(1)*(1-200*teta(2))-2;200*(teta(2)-teta(1)^2)];
end

